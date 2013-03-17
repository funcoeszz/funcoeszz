# ----------------------------------------------------------------------------
# http://pt.wikipedia.org/wiki/Anexo:Lista_de_munic%C3%ADpios_do_Brasil
# Lista completa com todas as 5.500+ cidades do Brasil, com busca.
# Obs.: Sem argumentos, mostra uma cidade aleatória.
#
# Uso: zzcidade [palavra|regex]
# Ex.: zzcidade              # mostra uma cidade qualquer
#      zzcidade campos       # mostra as cidades com "Campos" no nome
#      zzcidade '(SE)'       # mostra todas as cidades de Sergipe
#      zzcidade ^X           # mostra as cidades que começam com X
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2013-02-21
# Versão: 2
# Licença: GPL
# Requisitos: zzlinha
# ----------------------------------------------------------------------------
zzcidade ()
{
	zzzz -h cidade "$1" && return

	local url='http://pt.wikipedia.org/wiki/Anexo:Lista_de_munic%C3%ADpios_do_Brasil'
	local cache="$ZZTMP.cidade"
	local padrao="$*"

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		# Exemplo:^     * Aracaju (SE)
		$ZZWWWDUMP "$url" | sed -n 's/^  *\* \(.* (..)\)$/\1/p' > "$cache"
	fi

	if test -z "$padrao"
	then
		# Mostra uma cidade qualquer
		zzlinha -t . "$cache"
	else
		# Faz uma busca nas cidades
		grep -h -i -- "$padrao" "$cache"
	fi
}
