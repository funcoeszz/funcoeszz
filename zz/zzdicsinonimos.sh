# ----------------------------------------------------------------------------
# http://www.sinonimos.com.br/
# Procura sinônimos para um termo.
# Uso: zzdicsinonimos termo
# Ex.: zzdicsinonimos deste modo
#
# Autor: gabriell nascimento <gabriellhrn (a) gmail com>
# Desde: 2013-04-15
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzdicsinonimos ()
{

	zzzz -h dicsinonimos "$1" && return

	local url='http://www.sinonimos.com.br/busca.php'
	local palavra="$*"
	local parametro_busca=$( echo "$palavra" | sed "$ZZSEDURL" )

	# Verifica se recebeu parâmetros
	if test -z "$1"
	then
		zztool uso dicsinonimos
		return 1
	fi

	# Faz a busca do termo e limpa, deixando somente os sinônimos
	# O sed no final separa os sentidos, caso a palavra tenha mais de um
	$ZZWWWDUMP "${url}?q=${parametro_busca}" |
		sed -n "/[0-9]\{1,\} sinônimos\{0,1\} d/,/«/ {
			/[0-9]\{1,\} sinônimos\{0,1\} d/d
			/«/d
			/^$/d
			p
		}" |
		sed '/^\s*[A-Z]/ i\ '

	echo
}
