# ----------------------------------------------------------------------------
# Mostra a programação da TV, diária ou semanal, com escolha de emissora.
#
# Canais:
# ae_hd                   espn_brasil     max_prime_e    sony_hd
# ae                      espn_mais       max_prime      sony_spin
# amazon                  espn            max            sony
# animal                  esporte_inter   megapix_hd     space_hd
# arte1                   eurochannel     megapix        space
# axn_hd                  rede_familia    mgm            sport_tv2
# axn                     film_arts       mix_tv         sport_tv3
# baby                    fox_hd          mtv            sport_tv
# band                    fox_life        multishow      studio_universal
# band_espotes            fox_news        nat_geo_hd     super_rede
# band_news               fox_sports      nat_geo        syfy
# bbc_hd                  fox             nbr            tbs
# bbc                     futura          nhk            tcm
# biography               fx              nickelodeon    telecine_action_hd
# bis_hd                  gazeta          nick_hd        telecine_action
# bloomberg               rede_genesis    nick_jr        telecine_cult
# boomerang               glitz           off            telecine_fun
# canal_21                globo_bahia     ppv1           telecine_hd
# canal_boi               globo_campinas  ppv2           telecine_pipoca_hd
# canal_brasil            globo_df        ppv3           telecine_pipoca
# cancao_nova             globo_eptv      ppv4           telecine_premium
# cartoon                 globo_goias     ppv5           telecine
# casa_clube              globo_minas     ppv6           tele_sur
# cinemax                 globo_news      ppv7           terra_viva
# climatempo              globo_poa       ppv8           tnt_hd
# cnn_espanhol            globo_rj        ppv9           tnt
# cnn                     globo_sp        ppv10          tooncast
# cnt                     globo           ppv11          travel
# combate                 gloob           ppv12          trutv_hd
# comedy                  gnt             premiere_fc    trutv
# concert                 golf            rai            tv5_monde
# corinthians             hbo2            ra_tim_bum     tv_brasil_central
# cultura                 hbo_family      record_news    tv_brasil
# discovery_civilization  hbo_hd          record         tv_camara
# discovery_hd            hbo_plus_e      rede_tv        tv_escola
# discovery_kids          hbo_plus        rede_vida      tv_justica
# discovery_science       hbo_signature   rit            tv_uniao
# discovery_turbo         hbo             rtp            universal
# discovery               history_hd      rural          vh1_hd
# disney_hd               history         rush_hd        vh1_mega
# disney_jr               home_health     santa_cecilia  vh1
# disney                  htv             sbt            viva
# disney_xd               investigacao    senado         warner_hd
# dwtv ou deutsche        isat            sesc ou senac  warner
# entertainment           lbv             shoptime       woohoo
# tv_espanha              max_hd          sic
#
# Programação corrente:
# doc, esportes, filmes, infantil, series, variedades, aberta, todos (padrão).
#
# Se o segundo argumento for "semana" ou "s" mostra toda programação semanal.
# Opção só é válida para os canais.
# Se o primeiro argumento é cod seguido de um número, obtido pelas listagens
# citadas anteriormente, com segundo argumento, mostra um resumo do programa.
#
# Uso: zztv <emissora> [semana|s]  ou  zztv cod <numero>
# Ex.: zztv cultura
#      zztv cod 3235238
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2002-02-19
# Versão: 10
# Licença: GPL
# Requisitos: zzunescape
# ----------------------------------------------------------------------------
zztv ()
{
	zzzz -h tv "$1" && return

	local DATA=$(date +%d\\/%m)
	local URL="http://meuguia.tv/programacao"
	local desc

	# 0 = lista canal especifico
	# 1 = lista programas de vários canais no horário
	local flag=0

	case "$1" in
	ae)                               URL="${URL}/canal/MDO"; desc="A&E";;
	ae_hd)                            URL="${URL}/canal/MDH"; desc="A&E HD";;
	amazon)                           URL="${URL}/canal/AMZ"; desc="Amazon Sat";;
	animal)                           URL="${URL}/canal/APL"; desc="Animal Planet";;
	arte1)                            URL="${URL}/canal/BQ5"; desc="Arte 1";;
	axn_hd)                           URL="${URL}/canal/AXH"; desc="AXN HD";;
	axn)                              URL="${URL}/canal/AXN"; desc="AXN";;
	baby)                             URL="${URL}/canal/BAB"; desc="Baby TV";;
	band)                             URL="${URL}/canal/BAN"; desc="Band Rede";;
	band_esportes)                    URL="${URL}/canal/BSP"; desc="Band Esportes";;
	band_news)                        URL="${URL}/canal/NEW"; desc="Band News";;
	bbc)                              URL="${URL}/canal/BBC"; desc="BBC World News";;
	bbc_hd)                           URL="${URL}/canal/BHD"; desc="BBC HD";;
	biography)                        URL="${URL}/canal/BIO"; desc="Biography Channel";;
	bis_hd)                           URL="${URL}/canal/MSH"; desc="Bis HD";;
	bloomberg)                        URL="${URL}/canal/BIT"; desc="Bloomberg";;
	boomerang)                        URL="${URL}/canal/BMG"; desc="Boomerang";;
	canal_21)                         URL="${URL}/canal/C21"; desc="Play TV (Canal 21)";;
	canal_brasil)                     URL="${URL}/canal/CBR"; desc="Canal Brasil";;
	cancao_nova)                      URL="${URL}/canal/CNV"; desc="Canção Nova";;
	cartoon)                          URL="${URL}/canal/CAR"; desc="Cartoon Network";;
	casa_clube)                       URL="${URL}/canal/CCL"; desc="Casa Club TV";;
	max)                              URL="${URL}/canal/MXE"; desc="Max";;
	canal_boi)                        URL="${URL}/canal/BOI"; desc="Canal do Boi";;
	cinemax)                          URL="${URL}/canal/MNX"; desc="Cinemax";;
	climatempo)                       URL="${URL}/canal/CLI"; desc="Climatempo";;
	cnn_espanhol)                     URL="${URL}/canal/CNE"; desc="CNN Espanhol";;
	cnn)                              URL="${URL}/canal/CNN"; desc="CNN International";;
	cnt)                              URL="${URL}/canal/CNT"; desc="CNT";;
	comedy)                           URL="${URL}/canal/CCE"; desc="Comedy Central";;
	combate)                          URL="${URL}/canal/135"; desc="Combate";;
	concert)                          URL="${URL}/canal/100"; desc="Concert Channel";;
	cultura)                          URL="${URL}/canal/CUL"; desc="TV Cultura";;
	corinthians)                      URL="${URL}/canal/TCO"; desc="TV Corinthians";;
	discovery_civilization)           URL="${URL}/canal/DCI"; desc="Discovery Civilization";;
	discovery_hd)                     URL="${URL}/canal/DHD"; desc="Discovery HD Theater";;
	discovery_kids)                   URL="${URL}/canal/DIK"; desc="Discovery Kids";;
	discovery_science)                URL="${URL}/canal/DSC"; desc="Discovery Science";;
	discovery_turbo)                  URL="${URL}/canal/DTU"; desc="Discovery Turbo";;
	discovery)                        URL="${URL}/canal/DIS"; desc="Discovery Channel";;
	disney)                           URL="${URL}/canal/DNY"; desc="Disney Channel";;
	disney_hd)                        URL="${URL}/canal/DNH"; desc="Disney Channel HD";;
	disney_jr)                        URL="${URL}/canal/PHD"; desc="Disney Junior";;
	disney_xd)                        URL="${URL}/canal/DXD"; desc="Disney XD";;
	dwtv | deutsche)                  URL="${URL}/canal/DWL"; desc="Deutsche Welle";;
	entertainment)                    URL="${URL}/canal/EET"; desc="E! Entertainment Television";;
	tv_espanha)                       URL="${URL}/canal/TVE"; desc="TVE Espanha";;
	espn_brasil)                      URL="${URL}/canal/ESB"; desc="ESPN Brasil";;
	espn)                             URL="${URL}/canal/ESP"; desc="ESPN";;
	espn_mais)                        URL="${URL}/canal/ESH"; desc="ESPN+";;
	esporte_inter)                    URL="${URL}/canal/SPI"; desc="Esporte Interativo";;
	eurochannel)                      URL="${URL}/canal/EUR"; desc="Eurochannel";;
	rede_familia)                     URL="${URL}/canal/REF"; desc="Rede Famí­lia";;
	film_arts)                        URL="${URL}/canal/BRA"; desc="Film & Arts";;
	fox_hd)                           URL="${URL}/canal/FHD"; desc="Fox HD";;
	fox_life)                         URL="${URL}/canal/FLI"; desc="Fox Life";;
	fox_news)                         URL="${URL}/canal/FNE"; desc="Fox News";;
	fox_sports)                       URL="${URL}/canal/FSP"; desc="Fox Sports";;
	fox)                              URL="${URL}/canal/FOX"; desc="Fox";;
	futura)                           URL="${URL}/canal/FUT"; desc="Canal Futura";;
	fx)                               URL="${URL}/canal/CFX"; desc="FX";;
	gazeta)                           URL="${URL}/canal/GAZ"; desc="TV Gazeta";;
	rede_genesis)                     URL="${URL}/canal/TVG"; desc="Rede Gênesis";;
	glitz)                            URL="${URL}/canal/FAS"; desc="Glitz*";;
	globo_bahia)                      URL="${URL}/canal/GBB"; desc="Globo - Rede Bahia";;
	globo_campinas)                   URL="${URL}/canal/GRC"; desc="Globo - EPTV Campinas";;
	globo_df)                         URL="${URL}/canal/GHB"; desc="Globo - Brasília";;
	globo_eptv)                       URL="${URL}/canal/GRP"; desc="Globo - EPTV Ribeirão Preto";;
	globo_goias)                      URL="${URL}/canal/GBG"; desc="Globo - TV Anhanguera Goiás";;
	globo_minas)                      URL="${URL}/canal/GBM"; desc="Globo - Minas Gerais";;
	globo_news)                       URL="${URL}/canal/GLN"; desc="Globo News";;
	globo_poa)                        URL="${URL}/canal/POA"; desc="Globo - Porto Alegre";;
	globo_rj)                         URL="${URL}/canal/GRJ"; desc="Globo - Rio de Janeiro";;
	globo_sp)                         URL="${URL}/canal/GSP"; desc="Globo - São Paulo";;
	globo)                            URL="${URL}/canal/GRD"; desc="Globo - Satélite";;
	gloob)                            URL="${URL}/canal/GOB"; desc="Gloob";;
	gnt)                              URL="${URL}/canal/GNT"; desc="Canal GNT";;
	golf)                             URL="${URL}/canal/TGC"; desc="The Golf Channel";;
	hbo2)                             URL="${URL}/canal/HB2"; desc="HBO 2";;
	hbo_signature)                    URL="${URL}/canal/HFE"; desc="HBO Signature";;
	hbo_family)                       URL="${URL}/canal/HFA"; desc="HBO Family";;
	hbo_hd)                           URL="${URL}/canal/HBH"; desc="HBO HD";;
	hbo_plus_e)                       URL="${URL}/canal/HPE"; desc="HBO Plus *e";;
	hbo_plus)                         URL="${URL}/canal/HPL"; desc="HBO Plus";;
	hbo)                              URL="${URL}/canal/HBO"; desc="HBO";;
	home_health)                      URL="${URL}/canal/HEA"; desc="Discovery Home & Health";;
	htv)                              URL="${URL}/canal/HTV"; desc="HTV";;
	history)                          URL="${URL}/canal/HIS"; desc="History Channel";;
	history_hd)                       URL="${URL}/canal/HIH"; desc="History Channel HD";;
	investigacao)                     URL="${URL}/canal/LIV"; desc="Investigação Discovery";;
	isat)                             URL="${URL}/canal/SAT"; desc="i-Sat";;
	max_hd)                           URL="${URL}/canal/MHD"; desc="Max HD";;
	max_prime_e)                      URL="${URL}/canal/MPE"; desc="Max Prime *e";;
	max_prime)                        URL="${URL}/canal/MAP"; desc="Max Prime";;
	megapix_hd)                       URL="${URL}/canal/MPH"; desc="Megapix HD";;
	megapix)                          URL="${URL}/canal/MPX"; desc="Megapix";;
	mgm)                              URL="${URL}/canal/MGM"; desc="MGM";;
	mix_tv)                           URL="${URL}/canal/MIX"; desc="Mix TV";;
	mtv)                              URL="${URL}/canal/MTV"; desc="MTV Brasil";;
	multishow)                        URL="${URL}/canal/MSW"; desc="Multishow";;
	lbv)                              URL="${URL}/canal/LBV"; desc="Boa Vontade TV";;
	nat_geo)                          URL="${URL}/canal/SUP"; desc="National Geography";;
	nat_geo_hd)                       URL="${URL}/canal/NGH"; desc="Nat Geo Wild HD";;
	nbr)                              URL="${URL}/canal/NBR"; desc="NBR";;
	nhk)                              URL="${URL}/canal/NHK"; desc="NHK World";;
	nickelodeon)                      URL="${URL}/canal/NIC"; desc="Nickelodeon";;
	nick_hd)                          URL="${URL}/canal/NIH"; desc="Nick HD";;
	nick_jr)                          URL="${URL}/canal/NJR"; desc="Nick Jr.";;
	off)                              URL="${URL}/canal/OFF"; desc="Canal Off";;
	ppv1)                             URL="${URL}/canal/PV1"; desc="PPV 1 DLA";;
	ppv2)                             URL="${URL}/canal/PV2"; desc="PPV 2 DLA";;
	ppv3)                             URL="${URL}/canal/PV3"; desc="PPV 3 DLA";;
	ppv4)                             URL="${URL}/canal/PV4"; desc="PPV 4 DLA";;
	ppv5)                             URL="${URL}/canal/PV5"; desc="PPV 5 DLA";;
	ppv6)                             URL="${URL}/canal/PV6"; desc="PPV 6 DLA";;
	ppv7)                             URL="${URL}/canal/PV7"; desc="PPV 7 DLA";;
	ppv8)                             URL="${URL}/canal/PV8"; desc="PPV 8 DLA";;
	ppv7)                             URL="${URL}/canal/PV9"; desc="PPV 9 DLA";;
	ppv10)                            URL="${URL}/canal/P10"; desc="PPV 10 DLA";;
	ppv11)                            URL="${URL}/canal/P11"; desc="PPV 11 DLA";;
	ppv12)                            URL="${URL}/canal/P12"; desc="PPV 12 DLA";;
	premiere_fc)                      URL="${URL}/canal/121"; desc="PremiereFC";;
	rai)                              URL="${URL}/canal/RAI"; desc="RAI International";;
	ra_tim_bum)                       URL="${URL}/canal/RTB"; desc="TV Rá-tim-bum";;
	record_news)                      URL="${URL}/canal/RCN"; desc="Record News";;
	record)                           URL="${URL}/canal/REC"; desc="Record";;
	rede_tv)                          URL="${URL}/canal/RTV"; desc="Rede TV";;
	rede_vida)                        URL="${URL}/canal/VDA"; desc="Rede Vida";;
	rit)                              URL="${URL}/canal/RIT"; desc="Rede Internacional de TV";;
	rtp)                              URL="${URL}/canal/RTP"; desc="RTP Internacional";;
	rural)                            URL="${URL}/canal/RUR"; desc="Canal Rural";;
	rush_hd)                          URL="${URL}/canal/RSH"; desc="Rush HD";;
	santa_cecilia)                    URL="${URL}/canal/STC"; desc="Santa Cecília TV";;
	sbt)                              URL="${URL}/canal/SBT"; desc="SBT";;
	senado)                           URL="${URL}/canal/SEN"; desc="TV Senado";;
	sesc | senac)                     URL="${URL}/canal/NAC"; desc="SESC TV";;
	shoptime)                         URL="${URL}/canal/SHO"; desc="Shoptime";;
	sic)                              URL="${URL}/canal/SIC"; desc="SIC Internacional";;
	sony_hd)                          URL="${URL}/canal/SEH"; desc="Sony HD";;
	sony_spin)                        URL="${URL}/canal/ANX"; desc="Sony Spin";;
	sony)                             URL="${URL}/canal/SET"; desc="Sony Entertainment TV";;
	space_hd)                         URL="${URL}/canal/SPH"; desc="Space HD";;
	space)                            URL="${URL}/canal/SPA"; desc="Space";;
	sport_tv2)                        URL="${URL}/canal/SP2"; desc="SporTV 2";;
	sport_tv3)                        URL="${URL}/canal/SP3"; desc="SporTV 3";;
	sport_tv)                         URL="${URL}/canal/SPO"; desc="SporTV";;
	studio_universal)                 URL="${URL}/canal/HAL"; desc="Studio Universal";;
	super_rede)                       URL="${URL}/canal/SRD"; desc="Rede Super de Televisão";;
	syfy)                             URL="${URL}/canal/SCI"; desc="SyFy";;
	tbs)                              URL="${URL}/canal/TBS"; desc="TBS";;
	tcm)                              URL="${URL}/canal/TCM"; desc="TCM - Turner Classic Movies";;
	telecine_action)                  URL="${URL}/canal/TC2"; desc="Telecine Action";;
	telecine_action_hd)               URL="${URL}/canal/T2H"; desc="Telecine Action HD";;
	telecine_cult)                    URL="${URL}/canal/TC5"; desc="Telecine Cult";;
	telecine_hd)                      URL="${URL}/canal/TCH"; desc="Telecine Premuim HD";;
	telecine_fun)                     URL="${URL}/canal/TC6"; desc="Telecine Fun";;
	telecine_pipoca)                  URL="${URL}/canal/TC4"; desc="Telecine Pipoca";;
	telecine_pipoca_hd)               URL="${URL}/canal/T4H"; desc="Telecine Pipoca HD";;
	telecine_premium)                 URL="${URL}/canal/TC1"; desc="Telecine Premium";;
	telecine)                         URL="${URL}/canal/TC3"; desc="Telecine Touch";;
	tele_sur)                         URL="${URL}/canal/TLS"; desc="Tele Sur";;
	terra_viva)                       URL="${URL}/canal/TVV"; desc="Terra Viva";;
	tnt)                              URL="${URL}/canal/TNT"; desc="TNT";;
	tnt_hd)                           URL="${URL}/canal/TNH"; desc="TNT HD";;
	tooncast)                         URL="${URL}/canal/TOC"; desc="Tooncast";;
	travel)                           URL="${URL}/canal/TRV"; desc="Travel & Living";;
	trutv_hd)                         URL="${URL}/canal/TRH"; desc="TruTV HD";;
	trutv)                            URL="${URL}/canal/TRU"; desc="TruTV";;
	tv5_monde)                        URL="${URL}/canal/TV5"; desc="TV5 Monde";;
	tv_brasil)                        URL="${URL}/canal/TED"; desc="TV Brasil";;
	tv_brasil_central)                URL="${URL}/canal/TBC"; desc="TV Brasil Central";;
	tv_camara)                        URL="${URL}/canal/CAM"; desc="TV Câmara";;
	tv_escola)                        URL="${URL}/canal/ESC"; desc="TV Escola";;
	tv_justica)                       URL="${URL}/canal/JUS"; desc="TV Justiça";;
	tv_uniao)                         URL="${URL}/canal/TVU"; desc="TV União";;
	universal)                        URL="${URL}/canal/USA"; desc="Universal";;
	vh1)                              URL="${URL}/canal/VH1"; desc="VH1";;
	vh1_hd)                           URL="${URL}/canal/VHD"; desc="VH1 HD";;
	vh1_mega)                         URL="${URL}/canal/MTH"; desc="VH1 Mega Hits";;
	viva)                             URL="${URL}/canal/VIV"; desc="Viva";;
	warner)                           URL="${URL}/canal/WBT"; desc="Warner Channel";;
	warner_hd)                        URL="${URL}/canal/WBH"; desc="Warner Channel HD";;
	woohoo)                           URL="${URL}/canal/WOO"; desc="WooHoo";;
	doc | documentario)               URL="${URL}/categoria/Documentarios"; flag=1; desc="Documentários";;
	esporte | esportes | futebol)     URL="${URL}/categoria/Esportes"; flag=1; desc="Esportes";;
	filmes)                           URL="${URL}/categoria/Filmes"; flag=1; desc="Filmes";;
	infantil)                         URL="${URL}/categoria/Infantil"; flag=1; desc="Infantil";;
	series | seriados)                URL="${URL}/categoria/Series"; flag=1; desc="Séries";;
	variedades)                       URL="${URL}/categoria/Variedades"; flag=1; desc="Variedades";;
	cod)                              URL="${URL}/programa/$2"; flag=2;;
	aberta)                           URL="${URL}/categoria/Aberta"; flag=1; desc="Aberta";;
	todos | agora | *)                URL="${URL}/categoria/Todos"; flag=1; desc="Agora";;
	esac

	case "$2" in
	semana | s)
		zztool eco $desc
		$ZZWWWHTML "$URL" |
		sed -n '/<li class/{N;p;}' |
		sed '/^[[:space:]]*$/d;/.*<\/*li/s/<[^>]*>//g' |
		sed 's/^.*programa\///g;s/".*title="/_/g;s/">//g;s/<span .*//g;s/<[^>]*>/ /g;s/amp;//g' |
		sed 's/^[[:space:]]*/ /g' |
		sed '/^[[:space:]]*$/d' |
		sed "/^ \([STQD].*[0-9][0-9]\/[0-9][0-9]\)/ { x; p ; x; s//\1/; }" |
		sed 's/^ \(.*\)_\(.*\)\([0-9][0-9]h[0-9][0-9]\)/ \3 \2 Cod: \1/g' |
		zzunescape --html |
		awk -F " Cod: " '{ if (NF==2) { printf "%-64s Cod: %s\n", substr($1,1,63), substr($2, 1, index($2, "-")-1) } else print }'
	;;
	*)
		if [ $flag -eq 0 ]
		then
			zztool eco $desc
			$ZZWWWHTML "$URL" |
			sed -n '/<li class/{N;p;}' |
			sed '/^[[:space:]]*$/d;/.*<\/*li/s/<[^>]*>//g' |
			sed 's/^.*programa\///g;s/".*title="/_/g;s/">//g;s/<span .*//g;s/<[^>]*>/ /g;s/amp;//g' |
			sed 's/^[[:space:]]*/ /g' |
			sed '/^[[:space:]]*$/d' |
			sed -n "/, $DATA/,/^ [STQD].*[0-9][0-9]\/[0-9][0-9]/p" |
			sed '$d;1s/^ *//;2,$s/^ \(.*\)_\(.*\)\([0-9][0-9]h[0-9][0-9]\)/ \3 \2 Cod: \1/g' |
			zzunescape --html |
			awk -F " Cod: " '{ if (NF==2) { printf "%-64s Cod: %s\n", substr($1,1,63), substr($2, 1, index($2, "-")-1) } else print }'
		elif [ $flag -eq 1 ]
		then
			zztool eco $desc
			$ZZWWWHTML "$URL" | sed -n '/<li style/{N;p;}' |
			sed '/^[[:space:]]*$/d;/.*<\/*li/s/<[^>]*>//g' |
			sed 's/.*title="//g;s/">.*<br \/>/ | /g;s/<[^>]*>/ /g' |
			sed 's/[[:space:]]\{1,\}/ /g' |
			sed '/^[[:space:]]*$/d' |
			zzunescape --html |
			awk -F "|" '{ printf "%5s%-57s%s\n", $2, substr($1,1,56), $3 }'
		else
			zztool eco "Código: $2"
			$ZZWWWHTML "$URL" | sed -n '/<span class="tit">/,/Compartilhe:/p' |
			sed 's/<span class="tit">/Título: /;s/<span class="tit_orig">/Título Original: /' |
			sed 's/<[^>]*>/ /g;s/amp;//g;s/\&ccedil;/ç/g;s/\&atilde;/ã/g;s/.*str="//;s/";//;s/[\|] //g' |
			sed 's/^[[:space:]]*/ /g' |
			sed '/^[[:space:]]*$/d;/document.write/d;/str == ""/d;$d' |
			zzunescape --html
		fi
	;;
	esac
}
