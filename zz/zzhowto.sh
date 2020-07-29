# ----------------------------------------------------------------------------
# http://www.ibiblio.org
# Procura documentos do tipo HOWTO.
# Uso: zzhowto [--atualiza] palavra
# Ex.: zzhowto apache
#      zzhowto --atualiza
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2002-08-27
# Versão: 3
# Licença: GPL
# Requisitos: zztrim zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzhowto ()
{
	zzzz -h howto "$1" && return

	local padrao
	local cache=$(zztool cache howto)
	local url='http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html_single/'

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso howto; return 1; }

	# Força atualização da listagem apagando o cache
	if test '--atualiza' = "$1"
	then
		zztool atualiza howto
		shift
	fi

	padrao=$1

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		zztool source "$url" |
			zzxml --untag |
			zztrim |
			fgrep '.html' |
			sed 's/ [0-9][0-9]:.*//' > "$cache"
	fi

	# Pesquisa o termo (se especificado)
	if test -n "$padrao"
	then
		zztool eco "$url"
		grep -i "$padrao" "$cache"
	fi
}
