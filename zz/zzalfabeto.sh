# ----------------------------------------------------------------------------
# Central de alfabetos (romano, militar, radiotelefônico, OTAN, RAF, etc).
# Obs.: Sem argumentos mostra a tabela completa, senão traduz uma palavra.
#
# Tipos reconhecidos:
#
#    --militar | --radio | --fone | --otan | --icao | --ansi
#                                   Radiotelefônico internacional
#    --romano | --latino            A B C D E F...
#    --royal-navy | --royal         Marinha Real - Reino Unido, 1914-1918
#    --signalese | --western-front  Primeira Guerra, 1914-1918
#    --raf24                        Força Aérea Real - Reino Unido, 1924-1942
#    --raf42                        Força Aérea Real - Reino Unido, 1942-1943
#    --raf | --raf43                Força Aérea Real - Reino Unido, 1943-1956
#    --us | --us41                  Militar norte-americano, 1941-1956
#    --portugal | --pt              Lugares de Portugal
#    --name | --names               Nomes de pessoas, em inglês
#    --lapd                         Polícia de Los Angeles (EUA)
#    --morse                        Código Morse
#    --german                       Nomes de pessoas, em alemão
#    --all | --todos                Todos os códigos lado a lado
#
# Uso: zzalfabeto [--TIPO] [palavra]
# Ex.: zzalfabeto --militar
#      zzalfabeto --militar cambio
#      zzalfabeto --us --german prossiga
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-07-23
# Versão: 6
# Licença: GPL
# Requisitos: zzmaiusculas zztrim
# Tags: texto, tabela
# ----------------------------------------------------------------------------
zzalfabeto ()
{
	zzzz -h alfabeto "$1" && return

	local char letra colunas cab tam
	local awk_code='
				BEGIN {FS=":"; if (length(cab)>0) { print cab }}
				function campo(campos,  i, arr_camp) {
					split("", arr_camp)
					qtd_camp = split(campos, arr_camp, " ")
					for (i=1;i<=qtd_camp;i++) {
						printf $(arr_camp[i]) (i<qtd_camp?" ":"")
					}
					print ""
				}
				{ if (length(colunas)>0) { campo(colunas) } else print }'
	local coluna=1
	local dados="\
A:Alpha:Apples:Ack:Ace:Apple:Able/Affirm:Able:Aveiro:Alan:Adam:.-:Anton
B:Bravo:Butter:Beer:Beer:Beer:Baker:Baker:Bragança:Bobby:Boy:-...:Berta
C:Charlie:Charlie:Charlie:Charlie:Charlie:Charlie:Charlie:Coimbra:Charlie:Charles:-.-.:Casar
D:Delta:Duff:Don:Don:Dog:Dog:Dog:Dafundo:David:David:-..:Dora
E:Echo:Edward:Edward:Edward:Edward:Easy:Easy:Évora:Edward:Edward:.:Emil
F:Foxtrot:Freddy:Freddie:Freddie:Freddy:Fox:Fox:Faro:Frederick:Frank:..-.:Friedrich
G:Golf:George:Gee:George:George:George:George:Guarda:George:George:--.:Gustav
H:Hotel:Harry:Harry:Harry:Harry:How:How:Horta:Howard:Henry:....:Heinrich
I:India:Ink:Ink:Ink:In:Item/Interrogatory:Item:Itália:Isaac:Ida:..:Ida
J:Juliet:Johnnie:Johnnie:Johnnie:Jug/Johnny:Jig/Johnny:Jig:José:James:John:.---:Julius
K:Kilo:King:King:King:King:King:King:Kilograma:Kevin:King:-.-:Kaufmann/Konrad
L:Lima:London:London:London:Love:Love:Love:Lisboa:Larry:Lincoln:.-..:Ludwig
M:Mike:Monkey:Emma:Monkey:Mother:Mike:Mike:Maria:Michael:Mary:--:Martha
N:November:Nuts:Nuts:Nuts:Nuts:Nab/Negat:Nan:Nazaré:Nicholas:Nora:-.:Nordpol
O:Oscar:Orange:Oranges:Orange:Orange:Oboe:Oboe:Ovar:Oscar:Ocean:---:Otto
P:Papa:Pudding:Pip:Pip:Peter:Peter/Prep:Peter:Porto:Peter:Paul:.--.:Paula
Q:Quebec:Queenie:Queen:Queen:Queen:Queen:Queen:Queluz:Quincy:Queen:--.-:Quelle
R:Romeo:Robert:Robert:Robert:Roger/Robert:Roger:Roger:Rossio:Robert:Robert:.-.:Richard
S:Sierra:Sugar:Esses:Sugar:Sugar:Sugar:Sugar:Setúbal:Stephen:Sam:...:Samuel/Siegfried
T:Tango:Tommy:Toc:Toc:Tommy:Tare:Tare:Tavira:Trevor:Tom:-:Theodor
U:Uniform:Uncle:Uncle:Uncle:Uncle:Uncle:Uncle:Unidade:Ulysses:Union:..-:Ulrich
V:Victor:Vinegar:Vic:Vic:Vic:Victor:Victor:Viseu:Vincent:Victor:...-:Viktor
W:Whiskey:Willie:William:William:William:William:William:Washington:William:William:.--:Wilhelm
X:X-ray/Xadrez:Xerxes:X-ray:X-ray:X-ray:X-ray:X-ray:Xavier:Xavier:X-ray:-..-:Xanthippe/Xavier
Y:Yankee:Yellow:Yorker:Yorker:Yoke/Yorker:Yoke:Yoke:York:Yaakov:Young:-.--:Ypsilon
Z:Zulu:Zebra:Zebra:Zebra:Zebra:Zebra:Zebra:Zulmira:Zebedee:Zebra:--..:Zacharias/Zurich"

	# Escolhe o(s) alfabeto(s) a ser(em) utilizado(s)
	while test "${1#--}" != "$1"
	do
		case "$1" in
			--militar | --radio | --fone | --telefone | --otan | --nato | --icao | --itu | --imo | --faa | --ansi)
				coluna=2 ; shift ;;
			--romano | --latino           ) coluna=1     ; shift ;;
			--royal | --royal-navy        ) coluna=3     ; shift ;;
			--signalese | --western-front ) coluna=4     ; shift ;;
			--raf24                       ) coluna=5     ; shift ;;
			--raf42                       ) coluna=6     ; shift ;;
			--raf43 | --raf               ) coluna=7     ; shift ;;
			--us41 | --us                 ) coluna=8     ; shift ;;
			--pt | --portugal             ) coluna=9     ; shift ;;
			--name | --names              ) coluna=10    ; shift ;;
			--lapd                        ) coluna=11    ; shift ;;
			--morse                       ) coluna=12    ; shift ;;
			--german                      ) coluna=13    ; shift ;;
			--all | --todos               )
				colunas='1 12 2 3 4 5 6 7 8 10 11 13 9'
				coluna="0"
				shift
				break
			;;
			*) break ;;
		esac
		colunas=$(echo "$colunas $coluna" | zztrim | tr -s ' ,')
	done

	if test "$colunas" != "$coluna" -a -n "$colunas"
	then
		cab='ROMANO MILITAR ROYAL-NAVY SIGNALESE RAF24 RAF42 RAF US PORTUGAL NAMES LAPD MORSE GERMAN'
		tam='8 14 12 11 9 14 20 9 0 11 9 7 18'

		# Colocando portugal, quando presente, na última coluna sempre
		# devido a presença dos caracteres especiais nos nomes
		if zztool grep_var 9 "$colunas"
		then
			colunas=$(echo "$colunas" | zztrim | tr -d 9)' 9'
			colunas=$(echo "$colunas" | tr -s ' ')
		fi

		# Definindo cabeçalho e espaçamento
		cab=$(echo "$cab" | tr ' ' ':' | awk -v colunas="$colunas" "$awk_code")
		tam=$(echo "$tam" | tr ' ' ':' | awk -v colunas="$colunas" "$awk_code" |
			awk '{ if (NF > 1){ tot=$1;for(i=2;i<=NF;i++) { printf tot ","; tot+=$i } } } END {print ++tot}'
		)

	fi

	if test -n "$1"
	then
		# Texto informado, vamos fazer a conversão
		# Deixa uma letra por linha e procura seu código equivalente
		echo "$*" |
			zzmaiusculas |
			sed 's/./&\
/g' |
			while IFS='' read -r char
			do
				letra=$(echo "$char" | sed 's/[^A-Z]//g;s/[ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÇÑÐ£Ø§Ý]//g')
				if test -n "$letra"
				then
					echo "$dados" | grep "^$letra" |
					awk -v colunas="${colunas:-$coluna}" "$awk_code"
				else
					test -n "$char" && echo "$char"
				fi
			done
	else
		# Apenas mostre a tabela
		echo "$dados" |
		awk -v colunas="${colunas:-$coluna}" "$awk_code"
	fi |
	awk -v cab="$cab" "$awk_code" | tr ' ' '\t' |
	expand -t "${tam:-8}" | zztrim
}
