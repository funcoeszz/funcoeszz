# ----------------------------------------------------------------------------
# Mostra o texto de ajuda da função informada (ou de todas).
# Opções: --lista  lista de todas as funções, com sua descrição
#         --uso    resumo de todas as funções, com a sintaxe de uso
# Uso: zzajuda [--lista|--uso] [nome-da-função]
# Ex.: zzajuda            # mostra a ajuda de todas as funções
#      zzajuda zzdata     # mostra a ajuda da zzdata
#      zzajuda --lista
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-05-04
# Versão: 2
# Requisitos: zzzz zztool
# ----------------------------------------------------------------------------
zzajuda ()
{
	zzzz -h ajuda "$1" && return

	local func
	local path
	local separador
	local zzcor_pager

	case "$1" in
		--uso)
			shift
			# Lista com sintaxe de uso, basta pescar as linhas Uso:
			# Funciona para uma ou todas as funções
			zzajuda "$@" |
				sed -n 's/^Uso: //p' |
				sort |
				zztool acha '^zz[^ ]*'
		;;
		--lista)
			local texto
			while read -r func
			do
				texto=$(
					zzajuda "$func" |
					grep -v ^http |
					head -n 1
				)
				printf '%-17s%s\n' "$func" "$texto"
			done < "$ZZTMP.on" |
				zztool acha '^zz[^ ]*'
		;;
		zz*)
			func="$1"

			test -n "$ZZPATH" && path="$ZZPATH"
			test -n "$ZZDIR" && path="$ZZDIR/$func.sh"
			test -n "$path" || {
				echo "Ops! Não consigo encontrar o texto de ajuda." >&2
				echo "Você precisa definir a variável ZZPATH ou a ZZDIR." >&2
				return
			}
			test -r "$path" || {
				echo "Erro: Não consigo ler o arquivo $path" >&2
				echo "Essa path foi determinado com base em:" >&2
				echo "ZZPATH='$ZZPATH'" >&2
				echo "ZZDIR='$ZZDIR'" >&2
				return
			}

			# Extrai o texto de ajuda
			# Nota: Os comentários do script sed estão sem acentos,
			#       para evitar qualquer tipo de problema com UTF-8.
			sed -n '
				# Para cada bloco de texto de ajuda que encontrar,
				# guarde o conteudo relevante no hold space.
				/^# -----* *$/,/^# -----* *$/ {

					# Apaga a metadata (Autor, Desde, Versao, etc)
					/^# Autor:/,/^# -----* *$/ d

					# Apaga a primeira linha separadora
					/^# -----* *$/ d

					# Remove o caractere de comentario
					s/^# \{0,1\}//

					# Anexa o conteudo no hold space
					H
				}

				# Se logo em sequida ao bloco de ajuda aparecer a funcao
				# que estamos buscando, mostre o texto de ajuda guardado
				# no hold space e saia (quit), porque ja obtivemos o que
				# queriamos.
				'"/^$func ()/"' {
					g

					# Remove linhas em branco do inicio e fim
					s/^\n*//
					s/\n*$//

					p
					q
				}

				# Se o bloco de ajuda atual for de qualquer outra
				# funcao, basta descartá-lo e limpar o hold space para o
				# próximo bloco
				/^zz[^ ]* ()/ {
					s/.*//
					h
				}
			' "$path"
		;;
		*)
			# Linha separadora com exatamente 77 hífens (7x11)
			separador=$(echo '-------' | sed 's/.*/&&&&&&&&&&&/'
)
			# Desliga cores para os paginadores antigos
			test "$PAGER" = 'less' -o "$PAGER" = 'more' && zzcor_pager=0

			# Mostra a ajuda de todas as funções, paginando
			while read -r func
			do
				echo "$separador"
				zzajuda "$func"
			done < "$ZZTMP.on" |
				ZZCOR=${zzcor_pager:-$ZZCOR} zztool acha 'zz[a-z0-9]\{2,\}' |
				${PAGER:-less -r}
		;;
	esac
}
