# ----------------------------------------------------------------------------
# Busca o código do idioma (locale) - por exemplo, português é pt_BR.
# Com a opção -c, pesquisa somente nos códigos e não em sua descrição.
# Uso: zzlocale [-c] código|texto
# Ex.: zzlocale chinese
#      zzlocale -c pt
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2005-06-30
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzlocale ()
{
	zzzz -h locale "$1" && return

	local url='https://raw.githubusercontent.com/funcoeszz/funcoeszz/master/local/zzlocale.txt'
	local cache="$ZZTMP.locale"
	local padrao="$1"

	# Opções de linha de comando
	if [ "$1" = '-c' ]
	then
		# Padrão de pesquisa válido para última palavra da linha (código)
		padrao="$2[^ ]*$"
		shift
	fi

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso locale; return 1; }

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" > "$cache"
	fi

	# Faz a consulta
	grep -i -- "$padrao" "$cache"
}
