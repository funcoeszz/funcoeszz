# ----------------------------------------------------------------------------
# Usa todas as funções de dicionário e tradução de uma vez.
# Uso: zzdictodos palavra
# Ex.: zzdictodos Linux
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-02-22
# Versão: 1
# Licença: GPL
# Requisitos: zzdicbabelfish zzdicbabylon zzdicjargon zzdicportugues
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-22 Hoje não faz mais sentido essa função…
zzdictodos ()
{
	zzzz -h dictodos "$1" && return

	local dic

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dictodos; return 1; }

	for dic in babelfish babylon jargon portugues
	do
		zztool eco "zzdic$dic:"
		zzdic$dic $1
	done
}
