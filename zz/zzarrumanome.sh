# ----------------------------------------------------------------------------
# Renomeia arquivos do diretório atual, arrumando nomes estranhos.
# Obs.: Ele deixa tudo em minúsculas, retira acentuação e troca espaços em
#       branco, símbolos e pontuação pelo sublinhado _.
# Opções: -n  apenas mostra o que será feito, não executa
#         -d  também renomeia diretórios
#         -r  funcionamento recursivo (entra nos diretórios)
# Uso: zzarrumanome [-n] [-d] [-r] arquivo(s)
# Ex.: zzarrumanome *
#      zzarrumanome -n -d -r .                   # tire o -n para renomear!
#      zzarrumanome "DOCUMENTO MALÃO!.DOC"       # fica documento_malao.doc
#      zzarrumanome "RAMONES - Don't Go.mp3"     # fica ramones-dont_go.mp3
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2001-07-23
# Versão: 1
# Requisitos: zzzz zztool zzminusculas
# Tags: arquivo, manipulação
# ----------------------------------------------------------------------------
zzarrumanome ()
{
	zzzz -h arrumanome "$1" && return

	local arquivo caminho antigo novo recursivo pastas nao i

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-d) pastas=1    ;;
			-r) recursivo=1 ;;
			-n) nao="[-n] " ;;
			* ) break       ;;
		esac
		shift
	done

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso arrumanome; return 1; }

	# Para cada arquivo que o usuário informou...
	for arquivo
	do
		# Tira a barra no final do nome da pasta
		test "$arquivo" != / && arquivo=${arquivo%/}

		# Ignora arquivos e pastas não existentes
		test -f "$arquivo" -o -d "$arquivo" || continue

		# Se for uma pasta...
		if test -d "$arquivo"
		then
			# Arruma arquivos de dentro dela (-r)
			test "${recursivo:-0}" -eq 1 &&
				zzarrumanome -r ${pastas:+-d} ${nao:+-n} "$arquivo"/*

			# Não renomeia nome da pasta (se não tiver -d)
			test "${pastas:-0}" -ne 1 && continue
		fi

		# A pasta vai ser a corrente ou o 'dirname' do arquivo (se tiver)
		caminho='.'
		zztool grep_var / "$arquivo" && caminho="${arquivo%/*}"

		# $antigo é o arquivo sem path (basename)
		antigo="${arquivo##*/}"

		# $novo é o nome arrumado com a magia negra no Sed
		novo=$(
			echo "$antigo" |
			tr -s '\t ' ' ' |  # Squeeze: TABs e espaços viram um espaço
			zzminusculas |
			sed -e "
				# Remove aspas
				s/[\"']//g

				# Remove espaços do início e do fim
				s/^  *//
				s/  *$//

				# Remove acentos
				y/àáâãäåèéêëìíîïòóôõöùúûü/aaaaaaeeeeiiiiooooouuuu/
				y/çñß¢Ð£Øø§µÝý¥¹²³/cnbcdloosuyyy123/

				# Qualquer caractere estranho vira sublinhado
				s/[^a-z0-9._-]/_/g

				# Remove sublinhados consecutivos
				s/__*/_/g

				# Remove sublinhados antes e depois de pontos e hífens
				s/_\([.-]\)/\1/g
				s/\([.-]\)_/\1/g

				# Hífens no início do nome são proibidos
				s/^-/_/

				# Não permite nomes vazios
				s/^$/_/"
		)

		# Se der problema com a codificação, é o y/// do Sed anterior quem estoura
		if test $? -ne 0
		then
			zztool erro "Ops. Problemas com a codificação dos caracteres."
			zztool erro "O arquivo original foi preservado: $arquivo"
			return 1
		fi

		# Nada mudou, então o nome atual já certo
		test "$antigo" = "$novo" && continue

		# Se já existir um arquivo/pasta com este nome, vai
		# colocando um número no final, até o nome ser único.
		if test -e "$caminho/$novo"
		then
			i=1
			while test -e "$caminho/$novo.$i"
			do
				i=$((i+1))
			done
			novo="$novo.$i"
		fi

		# Tudo certo, temos um nome novo e único

		# Mostra o que será feito
		echo "$nao$arquivo -> $caminho/$novo"

		# E faz
		test -n "$nao" || mv -- "$arquivo" "$caminho/$novo"
	done
}
