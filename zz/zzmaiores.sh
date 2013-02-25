# ----------------------------------------------------------------------------
# Acha os maiores arquivos/diretórios do diretório atual (ou outros).
# Opções: -r  busca recursiva nos subdiretórios
#         -f  busca somente os arquivos e não diretórios
#         -n  número de resultados (o padrão é 10)
# Uso: zzmaiores [-r] [-f] [-n <número>] [dir1 dir2 ...]
# Ex.: zzmaiores
#      zzmaiores /etc /tmp
#      zzmaiores -r -n 5 ~
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2001-08-28
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzmaiores ()
{
	zzzz -h maiores "$1" && return

	local pastas recursivo modo tab resultado
	local limite=10

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-n)
				limite=$2
				shift; shift
			;;
			-f)
				modo='f'
				shift
				# Até queria fazer um -d também para diretórios somente,
				# mas o du sempre mostra os arquivos quando está recursivo
				# e o find não mostra o tamanho total dos diretórios...
			;;
			-r)
				recursivo=1
				shift
			;;
			*)
				break
			;;
		esac
	done

	if [ "$modo" = 'f' ]
	then
		# Usuário só quer ver os arquivos e não diretórios.
		# Como o 'du' não tem uma opção para isso, usaremos o 'find'.

		# Se forem várias pastas, compõe a lista glob: {um,dois,três}
		# Isso porque o find não aceita múltiplos diretórios sem glob.
		# Caso contrário tenta $1 ou usa a pasta corrente "."
		if [ "$2" ]
		then
			pastas=$(echo {$*} | tr -s ' ' ',')
		else
			pastas=${1:-.}
			[ "$pastas" = '*' ] && pastas='.'
		fi

		tab=$(echo -e '\t')
		[ "$recursivo" ] && recursivo= || recursivo='-maxdepth 1'

		resultado=$(
			find $pastas $recursivo -type f -ls |
				tr -s ' ' |
				cut -d' ' -f7,11- |
				sed "s/ /$tab/" |
				sort -nr |
				sed "$limite q"
		)
	else
		# Tentei de várias maneiras juntar o glob com o $@
		# para que funcionasse com o ponto e sem argumentos,
		# mas no fim é mais fácil chamar a função de novo...
		pastas="$@"
		if [ ! "$pastas" -o "$pastas" = '.' ]
		then
			zzmaiores ${recursivo:+-r} -n $limite * .[^.]*
			return

		fi

		# O du sempre mostra arquivos e diretórios, bacana
		# Basta definir se vai ser recursivo (-a) ou não (-s)
		[ "$recursivo" ] && recursivo='-a' || recursivo='-s'

		# Estou escondendo o erro para caso o * ou o .* não expandam
		# Bash2: nullglob, dotglob
		resultado=$(
			du $recursivo "$@" 2>/dev/null |
				sort -nr |
				sed "$limite q"
		)
	fi
	# TODO é K (nem é, só se usar -k -- conferir no SF) se vier do du e bytes se do find
	echo "$resultado"
	# | while read tamanho arquivo
	# do
	# 		echo -e "$(zzbyte $tamanho)\t$arquivo"
	# done
}
