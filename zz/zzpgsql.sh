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
# Versão: 3
# Licença: GPL
# Requisitos: zzunescape zztrim
# ----------------------------------------------------------------------------
zzpgsql ()
{
	zzzz -h pgsql "$1" && return

	local url='http://www.postgresql.org/docs/current/static'
	local cache=$(zztool cache pgsql)
	local comando

	if ! test -s "$cache"
	then
		zztool source "${url}/sql-commands.html" |
		awk '{printf "%s",$0; if ($0 ~ /<\/dt>/) {print ""} }'|
		zzunescape --html | sed -n '/<dt>/p' | sed 's/  */ /g' |
		awk -F'"' '{ printf "%3s %s\n", NR, substr($3,2) ":" $2 }' |
		sed 's/<[^>]*>//g;s/^>/ /g' > $cache
	fi

	if test -n "$1"
	then
		if zztool testa_numero $1
		then
			comando=$(cat $cache | sed -n "/^ *${1} /p" | cut -f2 -d":")
			zztool dump "${url}/${comando}" |
			sed -n '/^ *[_-][_-][_-][_-]*/,/^ *[_-][_-][_-][_-]*/p' |
			sed '1d;$d;' | zztrim -V | sed '1s/^ *//;s/        */       /'
		else
			grep -i $1 $cache | cut -f1 -d":"
		fi
	else
		cat "$cache" | cut -f1 -d":"
	fi
}
