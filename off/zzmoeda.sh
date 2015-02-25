# ----------------------------------------------------------------------------
# http://br.invertia.com
# Busca a cotação de várias moedas (mais de 100!) em relação ao dólar.
# Com a opção -t, mostra TODAS as moedas, sem ela, apenas as principais.
# É possível passar várias palavras de pesquisa para filtrar o resultado.
# Obs.: Hora GMT, Dólares por unidade monetária para o Euro e a Libra.
# Uso: zzmoeda [-t] [pesquisa]
# Ex.: zzmoeda
#      zzmoeda -t
#      zzmoeda euro libra
#      zzmoeda -t peso
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2004-03-29
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2015-02-24 Site foi descontinuado (veja issue #160)
zzmoeda ()
{
	zzzz -h moeda "$1" && return

	local extra dados formato linha
	local url='http://br.invertia.com/mercados/divisas'
	local padrao='.'

	# Devemos mostrar todas as moedas?
	if test "$1" = '-t'
	then
		extra='divisasregion.aspx?idtel=TODAS'
		shift
	fi

	# Prepara o filtro para pesquisar todas as palavras informadas (OU)
	test -n "$1" && padrao=$(echo $* | sed 's/ /\\|/g')

	# Faz a consulta e filtra o resultado
	dados=$(
		$ZZWWWDUMP "$url/$extra" |
		sed '
			# Limpeza
			/IFRAME:/d
			s/\[.*]//
			s/^  *//
			/h[0-9][0-9]$/!d

			# Move nome completo da moeda para o fim da linha
			s/^\([^»]*\)»  *\([^ ].*\)/\2   \1/
		' |
		grep -i "$padrao"
	)

	# Pescamos algo?
	test -n "$dados" || return

	echo "        Compra     Venda        Variação"
	echo "$dados"
}
