# ----------------------------------------------------------------------------
# http://dilbert.com/
# Mostra o texto em inglês das últimas tirinhas de Dilbert.
#
# Uso: zzdilbert
# Ex.: zzdilbert     # Mostra as tirinhas mais recentes
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2018-05-19
# Versão: 1
# Licença: GPL
# Requisitos: zztrim zzunescape zzxml
# Tags: internet, distração
# ----------------------------------------------------------------------------
# DESATIVADA: 2020-12-24 Transcrição da tirinha não está mais disponível.
zzdilbert ()
{
	zzzz -h dilbert "$1" && return

	local url="http://dilbert.com/"

	zztool source "$url" |
		awk '/comic-title-name/{print "-------";sub(/></,">Dilbert<");print};/>Transcript</,/<\/p>/' |
		zzxml --untag |
		zzunescape --html |
		sed '
			/Transcript/d
			s/\([.!?]\{1,\}\)\([^.:!?]\{1,\}:\)/\1\
\2/g' |
		zztrim
}
