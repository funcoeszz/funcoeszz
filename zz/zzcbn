# ----------------------------------------------------------------------------
# http://cbn.globoradio.com.br
# Busca e toca os últimos comentários dos comentaristas da radio CBN.
# Uso: zzcbn [-mp3] [-c COMENTARISTA] [-d data]  ou  zzcbn -lista
# Ex.: zzcbn -c max -d ontem
#      zzcbn -c mauro -d tudo
#      zzcbn -c juca -d 13/05/09
#      zzcbn -c miriam
#      zzcbn -mp3 -c max
#
# Autor: Rafael Machado Casali <rmcasali (a) gmail com>
# Desde: 2009-04-16
# Versão: 1
# Licença: GPL
# Requisitos: zzecho
# ----------------------------------------------------------------------------
zzcbn ()
{
	zzzz -h cbn "$1" && return

	local COMENTARISTAS MP3 RSS data comentarista datafile

#Comentaristas;RSS;Download
COMENTARISTAS="André_Trigueiro;andretrigueiro;andre-trigueiro;mundo
Arnaldo_Jabor;arnaldojabor;arnaldo-jabor;jabor
Carlos_Alberto_Sardenberg;carlosalbertosardenberg;sardenberg
Cony_&_Xexéo;conyxexeo;conyxexeo
Ethevaldo_Siqueira;ethevaldosiqueira;digital
Gilberto_Dimenstein;gilbertodimenstein;dimenstein
Juca_Kfouri;jucakfouri;jkfouri
Lucia_Hippolito;luciahippolito;lucia
Luis_Fernando_Correia;luisfernandocorreia;saudefoco
Mara_Luquet;maraluquet;mara
Marcos_Petrucelli;marcospetrucelli;petrucelli
Mauro_Halfeld;maurohalfeld;halfeld
Max_Gehringer;maxgehringer;max
Merval_Pereira;mervalpereira;merval
Miriam_Leitão;miriamleitao;mleitao
Renato_Machado;renatomachado;rmachado
Sérgio_Abranches;sergioabranches;ecopolitica"

RSS="http://imagens.globoradio.globo.com/cbn/rss/comentaristas/"
#MP3="http://download3.globo.com/sgr-$EXT/cbn/"
#EXT="mp3"
MP3="mms://wm-sgr-ondemand.globo.com/_aberto/sgr/1/cbn/"
EXT="wma"

#Verificacao dos parâmetros
[ "$1" ] || { zztool uso cbn; return 1; }

if [ "$1" == "-lista" ]
then
	for i in $COMENTARISTAS
	do
		echo `echo $i | sed 's/;/ ou /g' # cut -d';' -f1`
	done
	return
fi

# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-c)
				shift
				comentarista="$1"
				;;
			-d)
				shift
				data="$1"
				;;
			-mp3)
				EXT="mp3"
				#MP3="http://download3.globo.com/sgr-$EXT/cbn/"
				MP3="http://download.sgr.globo.com/sgr-$EXT/cbn/"
				;;
			*)
				zzecho -l vermelha "Opção inválida!!"
				return 1
				;;
		esac
		shift
	done

	linha=`echo $COMENTARISTAS | tr ' ' '\n' | sed  "/$comentarista/!d"`
	autor=`echo $linha | cut -d';' -f 3`
#	[ "$data" ] || data=`LANG=en.US date "+%d %b %Y"`
#	echo "$RSS`echo $linha | cut -d';' -f 2`.xml"
	$ZZWWWHTML "$RSS`echo $linha | cut -d';' -f 2`.xml"  | sed -n "/title/p;/pubDate/p" | sed "s/.*A\[\(.*\)]].*/\1/g" | sed "s/.*>\(.*\)<\/.*/\1/g" | sed "2d" > "$ZZTMP.comentarios"

	zzecho -l ciano `cat "$ZZTMP.comentarios" | sed -n '1p'`

	case  "$data" in
		"ontem")
			datafile=`date -d "yesterday" +%y%m%d`
			data=`LANG=en date -d "yesterday" "+%d %b %Y"`
			cat "$ZZTMP.comentarios" | sed -n "/$data/{H;x;p;};h" > "$ZZTMP.coment"
		;;
		"tudo")
			cat "$ZZTMP.comentarios" | sed '1d' > "$ZZTMP.coment"
		;;
		"")
			datafile=`date '+%y%m%d'`
			data=`LANG=en date "+%d %b %Y"`
			cat "$ZZTMP.comentarios" | sed -n "/$data/{H;x;p;};h" > "$ZZTMP.coment"
		;;
		*)
			if ! ( zztool testa_data "$data" || zztool testa_numero "$data" )
			then
				echo "Data inválida '$data', deve ser dd/mm/aaaa"
				return 1
			fi
			data="`echo $data | sed 's/\([0-9]*\)\/\([0-9]*\)\/\([0-9]*\)/\3-\2-\1/g'`"
			datafile=`date -d $data +%y%m%d`
			data=`LANG=en date -d $data "+%d %b %Y"`
			cat "$ZZTMP.comentarios" | sed -n "/$data/{H;x;p;};h" > "$ZZTMP.coment"


	esac
	Tlinhas=`cat "$ZZTMP.coment"| sed -n '$='`
	[ "$Tlinhas" ] ||  { zzecho -l vermelho "Sem comentários"; return; }
	for ((l=1;$l<=$Tlinhas;l=$l+2))
	do
		P=`expr $l + 1`
		titulo=`cat "$ZZTMP.coment"| sed "$l!d"`
		data=`cat "$ZZTMP.coment"| sed "$P!d"`
		datafile=`date -d "$data" "+%y%m%d"`
		hora=`LANG=en date -d "$data" "+%p"`
		data=`LANG=en date -d "$data" "+%d %b %Y %H:%m"`
		dois="_"
		if [ "$hora" == "PM" ]
		then
			case "$autor" in
			"sardenberg"|"mleitao"|"halfeld")
				dois="2_"
				;;
			esac
		fi
		zzecho -l verde "(q) para próximo; CTRL+C para sair"
		#echo $MP3`date +%Y`/colunas/$autor$dois$datafile.$EXT
		echo $titulo - $data
		mplayer $MP3`date +%Y`/colunas/$autor$dois$datafile.$EXT 1>/dev/null 2>/dev/null || return
	done
	if [ "$Tlinhas" == "0" ]
	then
		zzecho -l vermelho "Sem comentários"
	fi
	rm -f "$ZZTMP.comentarios"
	rm -f "$ZZTMP.coment"
}
