# ----------------------------------------------------------------------------
# http://www.antonimos.com.br/
# Procura antônimos para uma palavra.
# Uso: zzdicantonimos palavra
# Ex.: zzdicantonimos bom
#
# Autor: gabriell nascimento <gabriellhrn (a) gmail com>
# Desde: 2013-04-15
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzdicantonimos ()
{

	zzzz -h dicantonimos "$1" && return

	local url='http://www.antonimos.com.br/busca.php'
	local palavra="$*"
	local palavra_busca=$( echo "$palavra" | sed "$ZZSEDURL" )

	# Verifica se recebeu parâmetros
	if test -z "$1"
	then
		zztool uso dicantonimos
		return 1
	fi

	# Faz a busca do termo no site, deixando somente os antônimos
	$ZZWWWDUMP "${url}?q=${palavra_busca}" |
		sed -n "/[0-9]\{1,\} antônimos\{0,1\} d/,/«/ {
			/[0-9]\{1,\} antônimos\{0,1\} d/d
			/«/d
			/^$/d
			p
		}"

	echo
}
