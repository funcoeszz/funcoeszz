# ----------------------------------------------------------------------------
# http://br.finance.yahoo.com
# Pesquisa índices de bolsas e cotações de ações.
# Sem parâmetros mostra a lista de bolsas disponíveis (códigos).
# Com 1 parâmetro:
#  -l ou --lista: apenas mostra as bolsas disponíveis e seus nomes.
#  --limpa ou --limpar: exclui todos os arquivos de cache.
#  commodities: produtos de origem primária nas bolsas.
#  taxas_fixas ou moedas: exibe tabela de comparação de câmbio (principais).
#  taxas_cruzadas: exibe a tabela cartesiana do câmbio.
#  nome_moedas ou moedas_nome: lista códigos e nomes das moedas usadas.
#  volume: lista ações líderes em volume de negócios na Bovespa.
#  alta ou baixa: lista as ações nessa condição na BMFBovespa.
#  "código de bolsa ou ação": mostra sua última cotação.
#
# Com 2 parâmetros:
#  -l e código de bolsa: lista as ações (códigos).
#  --lista e "código de bolsa": lista as ações com nome e última cotação.
#  taxas_fixas ou moedas <principais|europa|asia|latina>: exibe tabela de
#   comparação de câmbio dessas regiões.
#  "código de bolsa" e um texto: pesquisa-o no nome ou código das ações
#    disponíveis na bolsa citada.
#  "código de bolsa ou ação" e data: pesquisa a cotação no dia.
#  noticias e "código de ação": Noticias relativas a essa ação (só Bovespa)
#
# Com 3 parâmetros ou mais:
#  "código de bolsa ou ação" e 2 datas: pesquisa as cotações nos dias com
#    comparações entre datas e variações da ação ou bolsa pesquisada.
#  vs (ou comp) e 2 códigos de bolsas ou ações: faz a comparação entre as duas
#   ações ou bolsas. Se houver um quarto parâmetro como uma data faz essa
#   comparação na data especificada. Mas não compara ações com bolsas.
#
# Uso: zzbolsas [-l|--lista] [bolsa|ação] [data1|pesquisa] [data2]
# Ex.: zzbolsas                  # Lista das bolsas (códigos)
#      zzbolsas -l               # Lista das bolsas (nomes)
#      zzbolsas -l ^BVSP         # Lista as ações do índice Bovespa (código)
#      zzbolsas --lista ^BVSP    # Lista as ações do índice Bovespa (nomes)
#      zzbolsas ^BVSP loja       # Procura ações com "loja" no nome ou código
#      zzbolsas ^BVSP            # Cotação do índice Bovespa
#      zzbolsas PETR4.SA         # Cotação das ações da Petrobrás
#      zzbolsas PETR4.SA 21/12/2010  # Cotação da Petrobrás nesta data
#      zzbolsas commodities      # Tabela de commodities
#      zzbolsas alta             # Lista ações em altas na Bovespa
#      zzbolsas volume           # Lista ações em alta em volume de negócios
#      zzbolsas taxas_fixas
#      zzbolsas taxas_cruzadas
#      zzbolsas noticias sbsp3.sa    # Noticias recentes no mercado da Sabesp
#      zzbolsas vs petr3.sa vale3.sa # Compara ambas cotações
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2009-10-04
# Versão: 25
# Licença: GPL
# Requisitos: zzcolunar zzdatafmt zzjuntalinhas zzlimpalixo zzmaiusculas zzsqueeze zztrim zzunescape zzxml
# ----------------------------------------------------------------------------
# DESATIVADA: 2016-09-28 Qualidade das informações é duvidosa e imprecisa.
zzbolsas ()
{
	zzzz -h bolsas "$1" && return

	local url='http://br.financas.yahoo.com'
	local new_york='^NYA ^NYI ^NYY ^NY ^NYL ^NYK'
	local nasdaq='^IXIC ^BANK ^NBI ^IXCO ^IXF ^INDS ^INSR ^OFIN ^IXTC ^TRAN ^NDX'
	local sp='^GSPC ^OEX ^MID ^SPSUPX ^SP600'
	local amex='^XAX ^NWX ^XMI ^SPHYDA'
	local ind_nac='^IBX50 ^IVBX ^IGCX ^IEE INDX.SA'
	local bolsa pag pags pag_atual data1 data2 vartemp

	case $# in
		0)
			# Lista apenas os códigos das bolsas disponíveis
			for bolsa in americas europe asia africa
			do
				zztool eco "\n$bolsa :"
				zztool source "$url/intlindices?e=$bolsa" |
				zzxml --tag table |
				sed -n '/<table cellpadding="0" cellspacing="0">/,/<\/table>/p' |
				zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
				sed -n '/^<tr.*Componentes/p' |
				zzxml --untag |
				zzsqueeze |
				awk '{printf " " $1}' |
				zztool nl_eof
			done

			zztool eco "\nDow Jones :"
			zztool source "$url/usindices" |
			zzxml --tag table |
			sed -n '/<table cellpadding="0" cellspacing="0">/,/<\/table>/p' |
			zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
			sed -n '/^<tr.*Componentes/p' |
			zzxml --untag |
			zzsqueeze |
			awk '{printf " " $1}' |
			zztool nl_eof

			zztool eco "\nNYSE :"
			for bolsa in $new_york; do printf " %s" "$bolsa"; done;echo

			zztool eco "\nNasdaq :"
			for bolsa in $nasdaq; do printf " %s" "$bolsa"; done;echo

			zztool eco "\nStandard & Poors :"
			for bolsa in $sp; do printf " %s" "$bolsa"; done;echo

			zztool eco "\nAmex :"
			for bolsa in $amex; do printf " %s" "$bolsa"; done;echo

			zztool eco "\nOutros Índices Nacionais :"
			for bolsa in $ind_nac; do printf " %s" "$bolsa"; done;echo
		;;
		1)
			# Lista os códigos da bolsas e seus nomes
			case "$1" in
			-l | --lista)
				for bolsa in americas europe asia africa
				do
					zztool eco "\n$bolsa :"
					zztool source "$url/intlindices?e=$bolsa" |
						zzxml --tag table |
						sed -n '/<table cellpadding="0" cellspacing="0">/,/<\/table>/p' |
						zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
						sed -n '/^<tr.*Componentes/{s,</td>,|,g;p;}' |
						zzxml --untag |
						zzsqueeze |
						sed 's/ *| */|/g' |
						zztrim |
						awk -F "|" '{ printf " %-10s%s\n", $1, $2 }' |
						zztrim
				done

				zztool eco "\nDow Jones :"
				zztool source "$url/usindices" |
					zzxml --tag table |
					sed -n '/<table cellpadding="0" cellspacing="0">/,/<\/table>/p' |
					zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
					sed -n '/^<tr.*Componentes/{s,</td>,|,g;p;}' |
					zzxml --untag |
					zzsqueeze |
					sed 's/ *| */|/g' |
					zztrim |
					awk -F "|" '{ printf " %-10s%s\n", $1, $2 }'

				zztool eco "\nNYSE :"
				for bolsa in $new_york;
				do
					printf " %-10s " "$bolsa"
					zztool dump "$url/q?s=$bolsa" |
					sed -n "/($bolsa)/{p;q;}" |
					sed "s/^ *//;s/ *($bolsa)//"
				done

				zztool eco "\nNasdaq :"
				for bolsa in $nasdaq;
				do
					printf " %-10s " "$bolsa"
					zztool dump "$url/q?s=$bolsa" |
					sed -n "/($bolsa)/{p;q;}" |
					sed "s/^ *//;s/ *($bolsa)//"
				done

				zztool eco "\nStandard & Poors :"
				for bolsa in $sp;
				do
					printf " %-10s " "$bolsa"
					zztool dump "$url/q?s=$bolsa" |
					sed -n "/($bolsa)/{p;q;}" |
					sed "s/^ *//;s/ *($bolsa)//"
				done

				zztool eco "\nAmex :"
				for bolsa in $amex;
				do
					printf " %-10s " "$bolsa"
					zztool dump "$url/q?s=$bolsa" |
					sed -n "/($bolsa)/{p;q;}" |
					sed "s/^ *//;s/ *($bolsa)//"
				done

				zztool eco "\nOutros Índices Nacionais :"
				for bolsa in $ind_nac;
				do
					printf " %-10s " "$bolsa"
					zztool dump "$url/q?s=$bolsa" |
					sed -n "/($bolsa)/{p;q;}" |
					sed "s/^ *//;s/ *($bolsa)//;s/ *-$//"
				done
			;;
			commodities)
				zztool eco  "Commodities"
				zztool source "$url/moedas/principais" |
					zzxml --tidy |
					sed -n '
					/<table id="yfi-commodities-energy" summary="Index for energia">/,/<\/table>/p
					/<table id="yfi-commodities-metals" summary="Index for metais">/,/<\/table>/p' |
					zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
					sed -n '/^<tr/{s,</t[dh]>,|,g;p;}' |
					zzxml --untag |
					zzsqueeze |
					sed 's/ *| */|/g' |
					awk -F '|' '
						$1 ~ "Nome" { print ""; print (NR==1? "Energia" : "Metais") }
						{ printf "%-32s %10s %10s %12s\n", $1, $2, $3, $4 }'
			;;
			taxas_fixas | moedas)
				zzbolsas $1 principais
			;;
			taxas_cruzadas)
				zztool eco "Taxas Cruzadas"
				zztool source "$url/moedas/principais" |
				zzxml --tidy |
				sed -n '/<table id="cross-rates-table"/,/<\/table>/p' |
				zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
				sed -n '/^<tr/{s,</t[dh]>,|,g;p;}' |
				zzxml --untag |
				zzsqueeze |
				sed 's/ *| */|/g; s| N/D||g; s/ .ltima transação//' |
				zzunescape --html |
				awk -F '|' '{ printf " %-8s  %8s  %8s  %8s  %8s  %8s  %8s  %8s\n", $1, $2, $3, $4, $5, $6, $7, $8 }'
			;;
			moedas_nome | nome_moedas)
				zztool source "$url/moedas/principais" |
				sed -n '/^ *"shortname":/p; /^ *"longname":/p; /^ *"symbol":/p' |
				awk -F '"' '{printf $4 (NR%3==0?"\n":" - ")}' |
				sed 's/ - *$//'
			;;
			volume | alta | baixa)
				case "$1" in
					volume) pag='actives';;
					alta)	pag='gainers';;
					baixa)	pag='losers';;
				esac
				zztool eco "Maiores ${1}s"
				zztool source "$url/${pag}?e=sa" |
				zzxml --tag table |
				sed -n '/<table cellpadding="0" cellspacing="0">/,/<\/table>/p' |
				zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
				sed -n '/^<tr/{s,</td>,|,g;p;}' |
				zzxml --untag |
				zzsqueeze |
				sed 's/ *| */|/g' |
				awk -F '|' '
					BEGIN { printf "%-17s  %-26s  %29s  %19s  %12s\n","Símbolo","Nome","Última Transação","Variação","Volume" }
					{ sub(/ de /,"/", $3); printf "%-17s  %-26s  %29s  %19s  %12s\n", $1, $2, $3, $4, $5 }'
			;;
			*)
				bolsa=$(echo "$1" | zzmaiusculas)
				# Último índice da bolsa citada ou cotação da ação
				zztool source "$url/q?s=$bolsa" |
				zzxml --notag style |
				sed -n '
					/<div class="title">/,/<\/div>/p
					/<div class="yfi_rt_quote_summary_rt_top sigfig_promo_0">/,/<\/div>/p
					/<table id="table[12]">/,/<\/table>/p
				' |
				zzjuntalinhas -i '<div ' -f '</div>' -d ' ' |
				zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
				sed -n '
					/^<div / {
						s/<span class="up_g time_rtq_content">/ Em alta /
						s/<span class="down_r time_rtq_content">/ Em baixa /
						p
						}
					/^<tr/{ /Próxima data de anúncio/d; s,</t[dh]>,|,g; p; }
				' |
				zzxml --untag |
				zzsqueeze |
				sed 's/ *| */|/g' |
				zzunescape --html |
				awk -F '|' '{
					if ($0 ~ /\|/) { printf "%-22s %s\n", $1, $2}
					else { sub(/^ */,""); print }
				}' |
				zztrim
			;;
			esac
		;;
		2 | 3 | 4)
			# Lista as ações de uma bolsa especificada
			bolsa=$(echo "$2" | zzmaiusculas)
			if test "$1" = "-l" -o "$1" = "--lista" && (zztool grep_var "$bolsa" "$dj $new_york $nasdaq $sp $amex $ind_nac" || zztool grep_var "^" "$bolsa")
			then
				if test "$1" = "--lista" -o "$1" = "-l"
				then
					pag_final=$(zztool source "$url/q/cp?s=$bolsa" | zzxml --tidy | sed -n '/^1 - /{s/.*de //;s/ .*//;p;q;}')
					pags=$(echo "scale=0;($pag_final - 1) / 50" | bc)

					unset vartemp
					pag=0
					while test $pag -le $pags
					do
						# Listar as ações com descrição e suas últimas posições
						zztool source "$url/q/cp?s=$bolsa&c=$pag" |
						zzxml --tag table |
						sed -n '/<table width="100%" cellpadding="0" cellspacing="0" border="0" class="yfnc_tableout1">/,/<\/table>/p' |
						zzxml --untag=table --untag=b --untag=a --untag=span --untag=nobr --untag=small --untag=img |
						zzlimpalixo |
						zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
						sed -n '/^<tr/{s,</t[dh]>,|,g;p;}' |
						zzxml --untag |
						zztrim |
						zzsqueeze |
						sed 's/ *| */|/g' |
						zzunescape --html |
						awk -F '|' -v pag_awk=$pag '
							BEGIN { if (pag_awk==0) printf "%-14s %-59s %25s %15s %15s\n", "Símbolo", "Nome", "Última transação", "Variação   ", "Volume  " }
							$2=="Nome" {next}
							{ sub(/ de /,"/", $3); printf "%-14s %-59s %25s %15s %15s\n", $1, $2, $3, $4, $5 }'
						pag=$(($pag+1))
					done
				fi |
				if test "$1" = "-l"
				then
					sed '1d; s/ .*//' | zzcolunar 7
				else
					cat -
				fi

			# Valores de uma bolsa ou ação em uma data especificada (histórico)
			elif zztool testa_data $(zzdatafmt "$2" 2>/dev/null)
			then
				local dd mm yyyy dd2 mm2 yyyy2
				vartemp=$(zzdatafmt -f "DD MM AAAA DD/MM/AAAA" "$2")
				dd=$(echo $vartemp | cut -f1 -d ' ')
				mm=$(echo $vartemp | cut -f2 -d ' ')
				yyyy=$(echo $vartemp | cut -f3 -d ' ')
				data1=$(echo $vartemp | cut -f4 -d ' ')
				mm=$(echo "scale=0;${mm}-1" | bc)

				if test -n "$3" && zztool testa_data $(zzdatafmt "$3" 2>/dev/null)
				then
					vartemp=$(zzdatafmt -f "DD MM AAAA DD/MM/AAAA" "$3")
					dd2=$(echo $vartemp | cut -f1 -d ' ')
					mm2=$(echo $vartemp | cut -f2 -d ' ')
					yyyy2=$(echo $vartemp | cut -f3 -d ' ')
					data2=$(echo $vartemp | cut -f4 -d ' ')
					mm2=$(echo "scale=0;${mm2}-1" | bc)
				fi

				unset vartemp

				bolsa=$(echo "$1" | zzmaiusculas)
				if test -n "$dd2"
				then
					zztool source "$url/q/hp?s=$bolsa&a=${mm}&b=${dd}&c=${yyyy}&d=${mm}&e=${dd}&f=${yyyy}&g=d"
					zztool source "$url/q/hp?s=$bolsa&a=${mm2}&b=${dd2}&c=${yyyy2}&d=${mm2}&e=${dd2}&f=${yyyy2}&g=d"
				else
					zztool source "$url/q/hp?s=$bolsa&a=${mm}&b=${dd}&c=${yyyy}&d=${mm}&e=${dd}&f=${yyyy}&g=d"
				fi |
				zzxml --tag h2 --tag table |
				sed -n "/($bolsa)/p; /^<td>$/d ;/<table class=\"yfnc_datamodoutline1\"/,/<\/table>/p" |
				zzjuntalinhas -i '<td' -f '</td>' -d ' ' |
				zzjuntalinhas -i '<th' -f '</th>' -d ' ' |
				sed -n '1p; /^<t[dh]/{/<small>/d;p;}' |
				zzxml --untag |
				zzsqueeze |
				sed '16,22d;30,$d' |
				awk 'NR == 1
					NR == 9 || NR == 16 { gsub(/ de /,"/") }
					NR > 1 { linha[NR-1]=$0 }
					END {
						if (NR==15) { for (i=1;i<=7;i++) printf "%-15s %15s\n", linha[i], linha[i+7] }
						if (NR==22) {
							for (i=1;i<=7;i++) {
								printf "%-15s %15s %15s", linha[i], linha[i+7], linha[i+14]
								if (i==1)
									print "   Variação (%)"
								else {
									gsub(/\./,"",linha[i+7]); gsub(/\./,"",linha[i+14])
									gsub(/,/,".",linha[i+7]); gsub(/,/,".",linha[i+14])
									if (linha[i+7]==0)
										printf "%10s\n", 0
									else
										printf "%10s (%.2f%%)\n", linha[i+14] - linha[i+7], ((linha[i+14]/linha[i+7])-1)*100
								}
							}
						}
					}' |
					zztrim

			# Compara duas ações ou bolsas diferentes
			elif (test "$1" = "vs" -o "$1" = "comp")
			then
				# Duas bolsas ou duas ações, sem misturar
				if (zztool grep_var "^" "$2" && zztool grep_var "^" "$3")
				then
					vartemp="0"
				elif (! zztool grep_var "^" "$2" && ! zztool grep_var "^" "$3")
				then
					vartemp="0"
				fi

				if test -n "$vartemp"
				then
					# Compara numa data especifica as ações ou bolsas
					if (test -n "$4" && zztool testa_data $(zzdatafmt "$4"))
					then
						(zzbolsas "$2" "$4"; zzbolsas "$3" "$4" | sed '2,$s/[A-Z][^0-9]*//')
					# Ultima cotaçao das açoes ou bolsas comparadas
					else
						(zzbolsas "$2"; zzbolsas "$3" | sed 's/.*:  *//')
					fi |
					zzcolunar 2 |
					zztrim

				fi
			# Noticias relacionadas a uma ação especifica
			elif (test "$1" = "noticias" -o "$1" = "notícias" && ! zztool grep_var "^" "$2")
			then
				zztool source "$url/q/h?s=$bolsa" |
				zzxml --tag li --tag h3 |
				zzjuntalinhas -i '<li' -f '</li>' -d ' ' |
				zzjuntalinhas -i '<h3>' -f '</h3>' -d ' ' |
				sed -n '/<cite>/{s/<cite>/|/;p;}; /<h3>.*<span>[[:blank:]]*/{s///;p;}' |
				zzxml --untag |
				zzsqueeze |
				zzunescape --html |
				awk '$0 !~ /^ / {print ""};1'
			elif (test "$1" = "taxas_fixas" || test "$1" = "moedas")
			then
				case $2 in
				asia)
					url="$url/moedas/asia-pacifico"
					zztool eco "$(echo $1 | sed 'y/tfm_/TFM /') - Ásia-Pacífico"
				;;
				latina)
					url="$url/moedas/america-latina"
					zztool eco "$(echo $1 | sed 'y/tfm_/TFM /') - América Latina"
				;;
				europa)
					url="$url/moedas/europa"
					zztool eco "$(echo $1 | sed 'y/tfm_/TFM /') - Europa"
				;;
				principais | *)
					url="$url/moedas/principais"
					zztool eco "$(echo $1 | sed 'y/tfm_/TFM /') - Principais"
				;;
				esac

				zztool source "$url" |
				zzxml --tidy |
				sed -n '/<table.*summary="Tabela de moedas com taxas fixas">/,/<\/table>/p' |
				zzjuntalinhas -i '<tr' -f '</tr>' -d ' ' |
				sed -n '/^<tr/{s,</t[dh]>,|,g;p;}' |
				zzxml --untag |
				zzsqueeze |
				sed 's/ *| */|/g; s/Par c/C/; 2,$s/Cambial/& inv./' |
				awk -F '|' '
					$1 ~ "Cambial" && NR>1 {print ""}
					{ printf " %-14s  %8s  %10s  %12s  %19s  %19s\n", $1, $2, $3, $4, $5, $6 }'
			else
				bolsa=$(echo "$1" | zzmaiusculas)
				vartemp=$(zzbolsas --lista "$bolsa")
				echo "$vartemp" | head -n 1
				echo "$vartemp" | sed '1d' | grep -i --color=never -- "$2"
			fi
		;;
	esac
}
