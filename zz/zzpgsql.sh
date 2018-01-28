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
# Versão: 4
# Licença: GPL
# Requisitos: zztrim zzsqueeze
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
		awk '/<dt>/,/<\/dt>/{if ($0 ~ /<dt>/) printf "%3s:", ++i; printf $0; if ($0 ~ /<\/dt>/) print ""}' |
		sed 's/<a href=[^"]*"//;s/\.html">/.html:/;s/<[^>]*>//g;s/: */:/' |
		zztrim |
		zzsqueeze > $cache
	fi

	if test -n "$1"
	then
		if zztool testa_numero $1
		then
			comando=$(sed -n "/^ *${1}:/{s///;s/:.*//;p;}" $cache)
			zztool dump "${url}/${comando}" |
			awk '
				$0  ~ /^$/  { branco++; if (branco == 3) { print "----------"; branco = 0 } }
				$0 !~ /^$/  { for (i=1;i<=branco;i++) { print "" }; print ; branco = 0 }
			' |
			sed -n '/^ *[_-][_-][_-][_-]*/,/^ *[_-][_-][_-][_-]*/p' |
			sed '1d;$d;' | zztrim -V | sed '1s/^ *//;s/        */       /'
		else
			grep -i $1 $cache | awk -F: '{printf "%3s %s\n", $1, $3}'
		fi
	else
		cat "$cache" | awk -F: '{printf "%3s %s\n", $1, $3}'
	fi
}
