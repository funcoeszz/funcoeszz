# ----------------------------------------------------------------------------
# http://www.dicio.com.br
# Dicionário de português.
# Obs.: Ainda não funciona com palavras acentuadas :( [issue #41]
# Uso: zzdicportugues palavra
# Ex.: zzdicportugues bolacha
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2003-02-26
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzdicportugues ()
{
	zzzz -h dicportugues "$1" && return

	local url='http://dicio.com.br/pesquisa.php'
	local ini='^Significado de '
	local fim='^Definição de '
	local padrao=$(echo $* | sed "$ZZSEDURL")

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dicportugues; return 1; }

	$ZZWWWDUMP "$url?q=$padrao" |
		sed -n "
			/$ini/,/$fim/ {
				/$ini/d
				/$fim/d
				s/^ *//
				p
			}"
}
