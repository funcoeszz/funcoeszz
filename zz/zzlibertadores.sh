# ----------------------------------------------------------------------------
# Mostra a classificação e jogos do torneio Libertadores da América.
#
# Nomenclatura:
#  P   - Pontos Ganhos
#  J   - Jogos
#
# Obs.: Se usar a opção --atualiza, o cache usado é renovado.
#
# Uso: zzlibertadores
# Ex.: zzlibertadores            # Classificação dos grupos e jogos mata-mata.
#      zzlibertadores --atualiza # Atualiza o cache.
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-17
# Versão: 16
# Requisitos: zzdatafmt zzjuntalinhas zzlimpalixo zzunescape zzxml
# Tags: internet, futebol, consulta
# ----------------------------------------------------------------------------
zzlibertadores ()
{
	zzzz -h libertadores "$1" && return

	local url url2
	local url3='https://www.ogol.com.br/'
	local cache=$(zztool cache libertadores)

	# Para não causar bloqueios, consulta uma vez por dia usando cache.
	test '--atualiza' = "$1" && { zztool cache rm libertadores; shift; }
	if ! test -s "$cache" || test $(head -n 1 "$cache") != $(zzdatafmt --iso hoje)
	then
		zzdatafmt --iso hoje > "$cache"

		# Descobrindo a URL da Libertadores.
		url2=$(
			zztool source "$url3" |
			zztool texto_em_iso |
			zzxml --tidy |
			awk '
				/Internacional de Seleções/ { exit }
				/^Internacionais$/,/Internacional de Seleções/ {
					if ($0 ~ /href=/) {
						printf $0 "\t"
						getline
						getline
						getline
						print
				}
			}' |
			sed -n '/Libertadores/{s/">//;s/.*"//;p;}' |
			cut -f 1
		)

		# Descobrindo a URL redirecionada, usar a url primária não funciona.
		url=$(curl -s -L -o /dev/null -w %{url_effective} "${url3}${url2}")

		zztool source "$url" | zztool texto_em_iso >> "$cache"

	fi

	zzxml --tidy "$cache" |
	zzjuntalinhas -i '<h2' -f 'h2>' -d '' |
	zzjuntalinhas -i '<tr' -f 'tr>' -d '|' |
	sed -n '/class="header"/,/<script>/{s/<[^>]*>//g;p;/Fotografias/q;}' |
	zzlimpalixo |
	tr -s '|' |
	sed '
		s/|F|G|/|/g
		s/|Ida|Volta|/|||&/
		s/|J|P|/||&/
		s/|cd|/|/g
		/ver jogos/d
		/|Classificação|/d
		$d
	' |
	awk -F '|' '
		NF>1 {print}
		$1 ~ /Libertadores|Grupo|Oitavas|Quartas|Semi|Final/ {
			# Uma linha separadora entre fases
			printf ($1 ~ /[A-H]$/?"":"=====================================================================================") "\n" $0 "\n"
		}
	' |
	zzunescape --html |
	awk -F'|' '
		NF==7 { printf "%25s %-5s %-25s %-12s %-12s\n", $2, $3, $4, $5, $6; next }
		NF==6 { printf "%1s %-25s %-2s %-2s\n", $2, $3, $4, $5; next }
		NF==9 { printf "%25s %-5s %-25s %-12s\n", $3, $4, $5, $2; next }
		NF>1  { next }
		1
	'
}
