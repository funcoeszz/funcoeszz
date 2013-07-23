# ----------------------------------------------------------------------------
# Lista os comandos SQL no PostgreSQL, numerando-os.
# Pesquisa detalhe dos comando, ao fornecer o número na listagem a esquerda.
# E filtra a busca se fornecer um texto.
#
# Uso: zzpgsql [ código | filtro ]
# Ex.: zzpgsql        # Lista os comandos disponíveis
#      zzpgsql 20     # Consulta o comando ALTER SCHEMA
#      zzpgsql alter  # Filtra os comandos que possuam alter na declaração
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-05-11
# Versão: 2
# Licença: GPL
# Requisitos: zzunescape
# ----------------------------------------------------------------------------
zzpgsql ()
{
	zzzz -h pgsql "$1" && return

	local url='http://www.postgresql.org/docs/current/static'
	local cache="$ZZTMP.pgsql"
	local comando

	if ! test -s "$cache"
	then
		$ZZWWWHTML "${url}/sql-commands.html" |
		awk '{printf "%s",$0; if ($0 ~ /<\/dt>/) {print ""} }'|
		zzunescape --html | sed -n '/<dt>/p' | sed 's/  */ /g' |
		awk -F'"' '{ printf "%3s %s\n", NR, substr($3,2) ":" $2 }' |
		sed 's/<[^>]*>//g;s/^>/ /g' > $cache
	fi

	if [ "$1" ]
	then
		if zztool testa_numero $1
		then
			comando=$(cat $cache | sed -n "/^ *${1} /p" | cut -f2 -d":")
			$ZZWWWDUMP "${url}/${comando}" | sed -n '/^ *__*/,/^ *__*/p' | sed '1d;$d'
		else
			grep -i $1 $cache | cut -f1 -d":"
		fi
	else
		cat "$cache" | cut -f1 -d":"
	fi
}
