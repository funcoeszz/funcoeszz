# ----------------------------------------------------------------------------
# http://dilbert.com/
# Mostra o texto em inglês das últimas tirinhas de Dilbert.
# Com a opção -t, faz a tradução para o português.
#
# Uso: zzdilbert [-t|--traduzir]
# Ex.: zzdilbert     # Mostra as tirinhas mais recentes
#      zzdilbert -t  # Mostra as tirinhas mais recentes traduzidas
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2018-05-19
# Versão: 1
# Licença: GPL
# Requisitos: zztradutor zztrim zzunescape zzxml
# Tags: internet, distração
# ----------------------------------------------------------------------------
zzdilbert ()
{
	zzzz -h dilbert "$1" && return

	if test -n "$1"
	then
		test '-t' = "$1" -o '--traduzir' = "$1" || { zztool -e uso dilbert; return 1; }
	fi

	local url="http://dilbert.com/"

	zztool source "$url" |
		awk '/comic-title-name/{print "-------";sub(/></,">Dilbert<");print};/>Transcript</,/<\/p>/' |
		zzxml --untag |
		zzunescape --html |
		sed '
			/Transcript/d
			s/\([.!?]\{1,\}\)\([^.:!?]\{1,\}:\)/\1\
\2/g' |
		zztrim |
		case $1 in
			-t | --traduzir )
				zztradutor en-pt |
				awk '
					/:/{print ""}
					/-------/ {if(NR>1)print "";print;getline;print;next}
					{printf $0}
					END {print ""}' |
					sed '/^$/d'
			;;
			*) cat - ;;
		esac
}
