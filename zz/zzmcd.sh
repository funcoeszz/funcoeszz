# ----------------------------------------------------------------------------
# Cria diretórios e subdiretórios, e muda diretório de trabalho (primeiro).
#
# Opções:
#      -n: Cria os diretórios, mas não muda o diretório de trabalho atual.
#      -s: Apenas simula o comando mkdir com os argumentos
#
# Uso: zzmcd [-n|-s] <dir[/subdir]> [dir[/subdir]]
# Ex.: zzmcd tmp1/tmp2
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2018-03-30
# Versão: 1
# Licença: GPL
# Tags: diretório, emulação
# ----------------------------------------------------------------------------
zzmcd ()
{
	zzzz -h mcd "$1" && return

	local opt dir erro

	# Verificação das opções
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-n) opt="n"; shift;;
			-s) opt="s"; shift;;
			--) shift; break;;
			-*) zztool -e uso mcd; return 1;;
		esac
	done

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso mcd; return 1; }

	# Cria/simula os diretório
	case "$opt" in
		s) echo mkdir -p $*; erro=0 ;;
		*)
			mkdir -p $* 2>/dev/null && test 'n' = "$opt" && erro=0
			# Verificando diretórios que falharam
			for dir in $*
			do
				test -d "$dir" || zztool erro "'$dir' não criado."
			done
		;;
	esac

	# Desloca-se ao primeiro diretório criado no último nivel possível
	test -d "$1" && test -z "$opt" && cd "$1"
	return $erro
}
