# ----------------------------------------------------------------------------
# Exibe a relação dos elementos químicos.
# Pesquisa na Wikipédia se informado o número atômico ou símbolo do elemento.
#
# Uso: zzquimica [número|símbolo]
# Ex.: zzquimica       # Lista de todos os elementos químicos
#      zzquimica He    # Pesquisa o Hélio na Wikipédia
#      zzquimica 12    # Pesquisa o Magnésio na Wikipédia
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-22
# Versão: 5
# Licença: GPL
# Requisitos: zzcapitalize zzwikipedia zzxml
# ----------------------------------------------------------------------------
zzquimica ()
{

	zzzz -h quimica "$1" && return

	local elemento
	local cache="$ZZTMP.quimica"

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWHTML "http://www.tabelaperiodicacompleta.com/" |
		awk '/class="elemento/,/<\/td>/{print}'|
		zzxml --untag=br | zzxml --tidy |
		sed '/id=57-71/,/<\/td>/d;/id=89-103/,/<\/td>/d' |
		awk 'BEGIN {print "N.º     Nome     Símbolo   Massa            Orbital       Classificação (estado)" }
			/^<td /     {
				info["familia"] = $5
					sub(/ao/, "ão", info["familia"])
					sub(/nideo/, "nídeo", info["familia"])
					sub(/gas/, "gás", info["familia"])
					sub(/genio/, "gênio", info["familia"])
					sub(/l[-]t/, "l de t", info["familia"])
					if (info["familia"] ~ /[los][-][rmn]/)
						sub(/-/, " ", info["familia"])

					info["familia"] = info["familia"] ($6 ~ /13$/ ? " [família do boro]":"")
					info["familia"] = info["familia"] ($6 ~ /14$/ ? " [família do carbono]":"")
					info["familia"] = info["familia"] ($6 ~ /15$/ ? " [família do nitrogênio]":"")
					info["familia"] = info["familia"] ($6 ~ /16$/ ? " [calcogênio]":"")

				info["estado"] = $7
					sub(/.>/, "", info["estado"])
					sub(/solido/, "sólido", info["estado"])
					sub(/liquido/, "líquido", info["estado"])
				}
			/^<a /      { info["url"] = $0; sub(/.*href=./, "", info["url"]); sub(/".*/, "", info["url"]) }
			/^<strong / { getline info["numero"] }
			/^<abbr/    { getline info["simbolo"]; sub(/ */, "", info["simbolo"]) }
			/^<em/      { getline info["nome"] }
			/^<i/       { getline info["massa"] }
			/^<small/   { getline info["orbital"]; gsub(/ /, "-", info["orbital"]) }
			{
				if (info["numero"]==114) { info["nome"]="Fleróvio"; info["simbolo"]="Fl" }
				if (info["numero"]==116) { info["nome"]="Livermório"; info["simbolo"]="Lv" }
			}
			/^<\/td>/ { printf "%-5s %-15s %-7s %-12s %-18s %s\n", info["numero"], info["nome"], info["simbolo"], info["massa"], info["orbital"], info["familia"] " (" info["estado"] ")" }
		' | sort -n > "$cache"
	fi

	if [ "$1" ]
	then
		if zztool testa_numero "$1"
		then
			# Testando se forneceu o número atômico
			elemento=$(awk ' $1 ~ /'$1'/ { print $2 }' "$cache")
		else
			# Ou se forneceu o símbolo do elemento químico
			elemento=$(awk '{ if ($3 == "'$(zzcapitalize "$1")'") print $2 }' "$cache")
		fi

		# Se encontrado, pesquisa-o na wikipedia
		if [ ${#elemento} -gt 0 ]
		then
			[ "$elemento" = "Rádio" -o "$elemento" = "Índio" ] && elemento="${elemento}_(elemento_químico)"
			zzwikipedia "$elemento"
		else
			zztool uso quimica
			return 1
		fi

	else
		# Lista todos os elementos químicos
		cat "$cache" | zzcapitalize | sed 's/ D\([eo]\) / d\1 /g'
	fi
}
