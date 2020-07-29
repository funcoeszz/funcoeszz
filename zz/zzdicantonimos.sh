# ----------------------------------------------------------------------------
# http://www.antonimos.com.br/
# Procura antônimos para uma palavra.
# Uso: zzdicantonimos palavra
# Ex.: zzdicantonimos bom
#
# Autor: gabriell nascimento <gabriellhrn (a) gmail com>
# Desde: 2013-04-15
# Versão: 3
# Licença: GPL
# Tags: internet, dicionário
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
		zztool -e uso dicantonimos
		return 1
	fi

	# Faz a busca do termo no site, deixando somente os antônimos
	zztool dump "${url}?q=${palavra_busca}" |
		sed -n "/[0-9]\{1,\} antônimos\{0,1\} d/,/«/ {
			/[0-9]\{1,\} antônimos\{0,1\} d/d
			/«/d
			/^$/d
			s/^ *//
			s/^[0-9]*\. //
			s/,//g
			s/\.$//
			p
		}" |
		awk '/:/ {printf (NR>1?"\n\n":"") $0 "\n"; next}; NF==0 {print ""}; {printf " " $0}' |
		zztool nl_eof
}
