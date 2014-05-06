# ----------------------------------------------------------------------------
# http://br.finance.yahoo.com
# Pesquisa índices de bolsas e cotações de ações.
# Sem parâmetros mostra a lista de bolsas disponíveis (códigos).
# Com 1 parâmetro:
#  -l ou --lista: apenas mostra as bolsas disponíveis e seus nomes.
#  --limpa ou --limpar: exclui todos os arquivos de cache.
#  commodities: produtos de origem primária nas bolsas.
#  taxas_fixas ou moedas: exibe tabela de comparação de câmbio (pricipais).
#  taxas_cruzadas: exibe a tabela cartesiana do câmbio.
#  nome_moedas ou moedas_nome: lista códigos e nomes das moedas usadas.
#  servicos, economia ou politica: mostra notícias relativas a esse assuntos.
#  noticias: junta as notícias de servicos e economia.
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
#   ações ou bolsas. Se houver um quarto parametro como uma data faz essa
#   comparaçao na data especificada. Mas não compara ações com bolsas.
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
#      zzbolsas noticias         # Noticias recentes do mercado financeiro
#      zzbolsas vs petr3.sa vale5.sa # Compara ambas cotações
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2009-10-04
# Versão: 21
# Licença: GPL
# Requisitos: zzmaiusculas zzsemacento zzdatafmt zzuniq
# ----------------------------------------------------------------------------
zzbolsas ()
{
	zzzz -h bolsas "$1" && return

	local url='http://br.finance.yahoo.com'
	local new_york='^NYA ^NYI ^NYY ^NY ^NYL ^NYK'
	local nasdaq='^IXIC ^BANK ^NBI ^IXCO ^IXF ^INDS ^INSR ^OFIN ^IXTC ^TRAN ^NDX'
	local sp='^GSPC ^OEX ^MID ^SPSUPX ^SP600'
	local amex='^XAX ^IIX ^NWX ^XMI'
	local ind_nac='^IBX50 ^IVBX ^IGCX ^IEE INDX.SA'
	local cache="$ZZTMP.bolsas.$$"
	local bolsa pag pags pag_atual data1 data2 vartemp

	case $# in
		0)
			# Lista apenas os códigos das bolsas disponíveis
			for bolsa in americas europe asia africa
			do
				zztool eco "\n$bolsa :"
				$ZZWWWDUMP "$url/intlindices?e=$bolsa" |
					sed -n '/Última/,/_/p' | sed '/Componentes,/!d' |
					awk '{ printf "%s ", $1}';echo
			done

			zztool eco "\nDow Jones :"
			$ZZWWWDUMP "$url/usindices" |
				sed -n '/Última/,/_/p' | sed '/Componentes,/!d' |
				awk '{ printf "%s ", $1}';echo

			zztool eco "\nNYSE :"
			for bolsa in $new_york; do printf "%s " "$bolsa"; done;echo

			zztool eco "\nNasdaq :"
			for bolsa in $nasdaq; do printf "%s " "$bolsa"; done;echo

			zztool eco "\nStandard & Poors :"
			for bolsa in $sp; do printf "%s " "$bolsa"; done;echo

			zztool eco "\nAmex :"
			for bolsa in $amex; do printf "%s " "$bolsa"; done;echo

			zztool eco "\nOutros Índices Nacionais :"
			for bolsa in $ind_nac; do printf "%s " "$bolsa"; done;echo
		;;
		1)
			# Lista os códigos da bolsas e seus nomes
			case "$1" in
			#Limpa todos os cache acumulado
			--limpa| --limpar) rm -f "$ZZTMP.bolsas".* 2>/dev/null;;
			-l | --lista)
				for bolsa in americas europe asia africa
				do
					zztool eco "\n$bolsa :"
					$ZZWWWDUMP "$url/intlindices?e=$bolsa" |
						sed -n '/Última/,/_/p' | sed '/Componentes,/!d' |
						sed 's/[0-9]*\.*[0-9]*,[0-9].*//g' |
						awk '{ printf " %-10s ", $1; for(i=2; i<=NF-1; i++) printf "%s ",$i; print $NF}'
				done

				zztool eco "\nDow Jones :"
				$ZZWWWDUMP "$url/usindices" |
					sed -n '/Última/,/_/p' | sed '/Componentes,/!d' |
					sed 's/[0-9]*\.*[0-9]*,[0-9].*//g' |
					awk '{ printf " %-10s ", $1; for(i=2; i<=NF-1; i++) printf "%s ",$i; print $NF}'
					printf " %-10s " "$dj";$ZZWWWDUMP "$url/q?s=$dj" |
					sed -n "/($dj)/{p;q;}" | sed "s/^ *//;s/ *($dj)//"

				zztool eco "\nNYSE :"
				for bolsa in $new_york;
				do
					printf " %-10s " "$bolsa";$ZZWWWDUMP "$url/q?s=$bolsa" |
					sed -n "/($bolsa)/{p;q;}" | sed "s/^ *//;s/ *($bolsa)//"
				done

				zztool eco "\nNasdaq :"
				for bolsa in $nasdaq;
				do
					printf " %-10s " "$bolsa";$ZZWWWDUMP "$url/q?s=$bolsa" |
					sed -n "/($bolsa)/{p;q;}" | sed "s/^ *//;s/ *($bolsa)//"
				done

				zztool eco "\nStandard & Poors :"
				for bolsa in $sp;
				do
					printf " %-10s " "$bolsa";$ZZWWWDUMP "$url/q?s=$bolsa" |
					sed -n "/($bolsa)/{p;q;}" | sed "s/^ *//;s/ *($bolsa)//"
				done

				zztool eco "\nAmex :"
				for bolsa in $amex;
				do
					printf " %-10s " "$bolsa";$ZZWWWDUMP "$url/q?s=$bolsa" |
					sed -n "/($bolsa)/{p;q;}" | sed "s/^ *//;s/ *($bolsa)//"
				done

				zztool eco "\nOutros Índices Nacionais :"
				for bolsa in $ind_nac;
				do
					printf " %-10s " "$bolsa";$ZZWWWDUMP "$url/q?s=$bolsa" |
					sed -n "/($bolsa)/{p;q;}" | sed "s/^ *//;s/ *($bolsa)//;s/ *-$//"
				done
			;;
			commodities)
				zztool eco  "Commodities"
				$ZZWWWDUMP "$url/moedas/mercado.html" |
				sed -n '/^Commodities/,/Mais commodities/p' |
				sed '1d;$d;/^ *$/d;s/CAPTION: //g;s/ *Metais/\
&/'| sed 's/^   //g'
			;;
			taxas_fixas | moedas)
				zzbolsas $1 principais
			;;
			taxas_cruzadas)
				zztool eco "Taxas Cruzadas"
				$ZZWWWDUMP "$url/moedas/principais" |
				sed -n '/CAPTION: Taxas cruzadas/,/Not.cias e coment.rios/p' |
				sed '1d;/^[[:space:]]*$/d;$d;s/ .ltima transação /                  /g; s, N/D,    ,g; s/           //; s/^  *//'
			;;
			moedas_nome | nome_moedas)
				zztool eco "BRL - Real"
				zztool eco "USD - Dolar Americano"
				zztool eco "EUR - Euro"
				zztool eco "GBP - Libra Esterlina"
				zztool eco "CHF - Franco Suico"
				zztool eco "CNH - Yuan Chines"
				zztool eco "HKD - Dolar decHong Kong"
				zztool eco "SGD - Dolar de Singapura"
				zztool eco "MXN - Peso Mexicano"
				zztool eco "ARS - Peso Argentino"
				zztool eco "UYU - Peso Uruguaio"
				zztool eco "CLP - Peso Chileno"
				zztool eco "PEN - Nuevo Sol (Peru)"
			;;
			not[íi]cias | economia | pol[íi]tica | servi[çc]os)
				case "$1" in
				economia | pol[íi]tica) vartemp=$($ZZWWWDUMP "$url/noticias/categoria-economia-politica-governo") ;;
				servi[çc]os) vartemp=$($ZZWWWDUMP "$url/noticias/setor-servicos") ;;
				not[íi]cias)
					zztool eco "Economia - Política - Governo"
					zzbolsas economia
					zztool eco "Setor de Serviços"
					zzbolsas servicos
					return
				;;
				esac
				echo "$vartemp" |
				sed -n '/^[[:space:]]\{1,\}.*atrás[[:space:]]*$/p;/^[[:space:]]\{1,\}.*BRT[[:space:]]*$/p' |
				sed 's/^[[:space:]]\{1,\}//g' | zzuniq
			;;
			volume | alta | baixa)
				case "$1" in
					volume) pag='actives';;
					alta)	pag='gainers';;
					baixa)	pag='losers';;
				esac
				zztool eco "Maiores ${1}s"
				$ZZWWWDUMP "$url/${pag}?e=sa" |
				sed -n '/Informações relacionadas/,/^[[:space:]]*$/p' |
				sed '1d;s/Down /-/g;s/ de /-/g;s/Up /+/g;s/Gráfico, .*//g' |
				sed 's/ *Para *cima */ +/g;s/ *Para *baixo */ -/g' |
				awk 'BEGIN {
							printf "%-10s  %-24s  %-24s  %-18s  %-10s\n","Símbolo","Nome","Última Transação","Variação","Volume"
						}
					{
						if (NF > 6) {
							nome = ""
							printf "%-10s ", $1;
							for(i=2; i<=NF-5; i++) {nome = nome sprintf( "%s ", $i)};
							printf " %-24s ", nome;
							for(i=NF-4; i<=NF-3; i++) printf " %-8s ", $i;
							printf "  "
							printf " %-6s ", $(NF-2); printf " %-9s ", $(NF-1);
							printf " %11s", $NF
							print ""
						}
					}'
			;;
			*)
				bolsa=$(echo "$1" | zzmaiusculas)
				# Último índice da bolsa citada ou cotação da ação
				$ZZWWWDUMP "$url/q?s=$bolsa" |
				sed -n "/($bolsa)/,/Cotações atrasadas, salvo indicação/p" |
				sed '{
						/^[[:space:]]*$/d
						/IFRAME:/d;
						/^[[:space:]]*-/d
						/Adicionar ao portfólio/d
						/As pessoas que viram/d
						/Cotações atrasadas, salvo indicação/,$d
						/Próxima data de anúncio/d
						s/[[:space:]]\{1,\}/ /g
						s|p/ *|p/|g
					}' |
				zzsemacento | awk -F":" '{if ( $1 != $2 && length($2)>0 ) {printf "%-20s%s\n", $1 ":", $2} else { print $1 } }'
			;;
			esac
		;;
		2 | 3 | 4)
			# Lista as ações de uma bolsa especificada
			bolsa=$(echo "$2" | zzmaiusculas)
			if [ "$1" = "-l" -o "$1" = "--lista" ] && (zztool grep_var "$bolsa" "$dj $new_york $nasdaq $sp $amex $ind_nac" || zztool grep_var "^" "$bolsa")
			then
				pag_final=$($ZZWWWDUMP "$url/q/cp?s=$bolsa" | sed -n '/Primeira/p;/Primeira/q' | sed "s/^ *//g;s/.* of *\([0-9]\{1,\}\) .*/\1/;s/.* de *\([0-9]\{1,\}\) .*/\1/")
				pags=$(echo "scale=0;($pag_final - 1) / 50" | bc)

				unset vartemp
				pag=0
				while test $pag -le $pags
				do
					if test "$1" = "--lista"
					then
						# Listar as ações com descrição e suas últimas posições
						$ZZWWWDUMP "$url/q/cp?s=$bolsa&c=$pag" |
						sed -n 's/^ *//g;/Símbolo /,/^Tudo /p' |
						sed '/Símbolo /d;/^Tudo /d;/^[ ]*$/d' |
						sed 's/ *Para *cima */ +/g;s/ *Para *baixo */ -/g' |
						awk -v pag_awk=$pag '
						BEGIN { if (pag_awk==0) {printf "%-14s %-54s %-23s %-15s %-10s\n", "Símbolo", "Empresa", "Última Transação", "Variação", "Volume"} }
						{
							nome = ""
							if (NF>=7) {
								if (index($(NF-3),":") != 0) { ajuste=0; limite = 7 } else { ajuste=2; limite = 9 }
								if (NF>=limite) {
									if (ajuste == 0 ) { data_hora = $(NF-3) }
									else if (ajuste == 2 ) { data_hora = $(NF-5) " " $(NF-4) " " $(NF-3) }
									for(i=2;i<=(NF-5-ajuste);i++) {nome = nome " " $i }
									printf "%-13s %-50s %10s %10s %10s %9s %10s\n", $1, nome, $(NF-4-ajuste), data_hora, $(NF-2), $(NF-1), $NF
								}
							}
						}'
					else
						# Lista apenas os códigos das ações
						vartemp=${vartemp}$($ZZWWWDUMP "$url/q/cp?s=$bolsa&c=$pag" |
						sed -n 's/^ *//g;/Símbolo /,/^Tudo /p' |
						sed '/Símbolo /d;/^Tudo /d;/^[ ]*$/d' |
						awk '{printf "%s  ",$1}')

						if test "$pag" = "$pags";then echo $vartemp;fi
					fi
					pag=$(($pag+1))
				done

			# Valores de uma bolsa ou ação em uma data especificada (histórico)
			elif zztool testa_data $(zzdatafmt "$2")
			then
				vartemp=$(zzdatafmt -f "DD MM AAAA DD/MM/AAAA" "$2")
				dd=$(echo $vartemp | cut -f1 -d ' ')
				mm=$(echo $vartemp | cut -f2 -d ' ')
				yyyy=$(echo $vartemp | cut -f3 -d ' ')
				data1=$(echo $vartemp | cut -f4 -d ' ')
				unset vartemp

				mm=$(echo "scale=0;${mm}-1" | bc)
				bolsa=$(echo "$1" | zzmaiusculas)
					# Emprestando as variaves pag, pags e pag_atual efeito estético apenas
					pag=$($ZZWWWDUMP "$url/q/hp?s=$bolsa&a=${mm}&b=${dd}&c=${yyyy}&d=${mm}&e=${dd}&f=${yyyy}&g=d" |
					sed -n "/($bolsa)/p;/Abertura/,/* Preço/p" | sed 's/Data/    /;/* Preço/d' |
					sed 's/^ */ /g;/Proxima data de anuncio/d')

					echo "$pag" | sed -n '2p' | sed 's/ [A-Z]/\
\t&/g;s/Enc ajustado/Ajustado/' | sed '/^ *$/d' | awk 'BEGIN { printf "%-13s\n", "Data" } {printf "%-12s\n", $1}' > "${cache}.pags"

					echo "$pag" | sed -n '3p' | cut -f7- -d" " | sed 's/ [0-9]/\
&/g' | sed '/^ *$/d' | awk 'BEGIN { print "    '$data1'" } {printf "%14s\n", $1}' > "${cache}.pag_atual"
					echo "$pag" | sed -n '1p'| sed 's/^ *//'

					if [ "$3" ] && zztool testa_data $(zzdatafmt "$3")
					then
						vartemp=$(zzdatafmt -f "DD MM AAAA DD/MM/AAAA" "$3")
						dd=$(echo $vartemp | cut -f1 -d ' ')
						mm=$(echo $vartemp | cut -f2 -d ' ')
						yyyy=$(echo $vartemp | cut -f3 -d ' ')
						data2=$(echo $vartemp | cut -f4 -d ' ')
						mm=$(echo "scale=0;${mm}-1" | bc)
						unset vartemp

						$ZZWWWDUMP "$url/q/hp?s=$bolsa&a=${mm}&b=${dd}&c=${yyyy}&d=${mm}&e=${dd}&f=${yyyy}&g=d" |
						sed -n "/($bolsa)/p;/Abertura/,/* Preço/p" | sed 's/Data/    /;/* Preço/d' |
						sed 's/^ */ /g' | sed -n '3p' | cut -f7- -d" " | sed 's/ [0-9]/\n&/g' |
						sed '/^ *$/d' | awk 'BEGIN { print "     '$data2'" } {printf " %14s\n", $1}' > "${cache}.pag"

						printf '%b\n' "       Variação\t Var (%)" > "${cache}.vartemp"
						paste "${cache}.pag_atual" "${cache}.pag" | while read data1 data2
						do
							echo "$data1 $data2" | tr -d '.' | tr ',' '.' |
							awk '{ if (index($1,"/")==0) {printf "%15.2f\t", $2-$1; if ($1 != 0) {printf "%7.2f%\n", (($2-$1)/$1)*100}}}' 2>/dev/null
						done >> "${cache}.vartemp"

						paste "${cache}.pags" "${cache}.pag_atual" "${cache}.pag" "${cache}.vartemp"
					else
						paste "${cache}.pags" "${cache}.pag_atual"
					fi
			# Compara duas ações ou bolsas diferentes
			elif ([ "$1" = "vs" -o "$1" = "comp" ])
			then
				if (zztool grep_var "^" "$2" && zztool grep_var "^" "$3")
				then
					vartemp="0"
				elif (! zztool grep_var "^" "$2" && ! zztool grep_var "^" "$3")
				then
					vartemp="0"
				fi
				if [ "$vartemp" ]
				then
					# Compara numa data especifica as ações ou bolsas
					if ([ "$4" ] && zztool testa_data $(zzdatafmt "$4"))
					then
						zzbolsas "$2" "$4" | sed '/Proxima data de anuncio/d' > "${cache}.pag"
						vartemp=$(zztool num_linhas ${cache}.pag)
						zzbolsas "$3" "$4" |
						sed '/Proxima data de anuncio/d;s/^[[:space:]]*//g;s/[[:space:]]*$//g' |
						sed '2,$s/^[[:upper:][:space:][:space:]][^0-9]*//g' > "${cache}.temp"
						sed -n "1,${vartemp}p" "${cache}.temp" > "${cache}.pags"
					# Ultima cotaçao das açoes ou bolsas comparadas
					else
						zzbolsas "$2" | sed '/Proxima data de anuncio/d' > "${cache}.pag"
						zzbolsas "$3" | sed '/Proxima data de anuncio/d' |
						sed 's/^[[:space:]]*//g;3,$s/.*:[[:space:]]*//g' > "${cache}.pags"
					fi
					# Imprime efetivamente a comparação
					if [ $(awk 'END {print NR}' "${cache}.pag") -ge 4 -a $(awk 'END {print NR}' "${cache}.pags") -ge 4 ]
					then
						paste -d"|" "${cache}.pag" "${cache}.pags" |
						awk -F"|" '{printf "%-42s %25s\n", $1, $2}'
					fi
				fi
			# Noticias relacionadas a uma ação especifica
			elif ([ "$1" = "noticias" -o "$1" = "notícias" ] && ! zztool grep_var "^" "$2")
			then
				$ZZWWWDUMP "$url/q/h?s=$bolsa" |
				sed -n '/^[[:blank:]]\{1,\}\*.*Agencia.*)$/p;/^[[:blank:]]\{1,\}\*.*at noodls.*)$/p' |
				sed 's/^[[:blank:]]*//g;s/Agencia/ &/g;s/at noodls/ &/g'
			elif ([ "$1" = "taxas_fixas" ] || [ "$1" = "moedas" ])
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

				$ZZWWWDUMP "$url" |
					sed -n '
						# grepa apenas as linhas das moedas e os títulos
						/CAPTION: Taxas fixas/,/CAPTION: Taxas cruzadas/ {
							/^  *[A-Z][A-Z][A-Z]\/[A-Z][A-Z][A-Z]/ p
							/^  *Par cambial/ p
						}' |
					sed '
						# Remove lixos
						s/ *Visualização do gráfico//g
						s/ Inverter pares /                /g

						# A segunda tabela é invertida
						3,$ s/Par cambial             /Par cambial inv./

						# Diminuição do espaçamento para caber em 80 colunas
						s/^  *//
						s/        //

						# Quebra linha antes do título das duas tabelas
						/^Par cambial/ s/^/\
/
						# Apagando linha duplicada com valores em branco
						/[A-Z]\{3\}\/[A-Z]\{3\} *$/d
						'
			else
				bolsa=$(echo "$1" | zzmaiusculas)
				pag_final=$($ZZWWWDUMP "$url/q/cp?s=$bolsa" | sed -n '/Primeira/p;/Primeira/q' | sed 's/^ *//g;s/.* of *\([0-9]\{1,\}\) .*/\1/;s/.* de *\([0-9]\{1,\}\) .*/\1/')
				pags=$(echo "scale=0;($pag_final - 1) / 50" | bc)
				pag=0
				while test $pag -le $pags
				do
					$ZZWWWDUMP "$url/q/cp?s=$bolsa&c=$pag" |
					sed -n 's/^ *//g;/Símbolo /,/Primeira/p' |
					sed '/Símbolo /d;/Primeira/d;/^[ ]*$/d' |
					grep -i "$2"
					pag=$(($pag+1))
				done
			fi
		;;
	esac
}
