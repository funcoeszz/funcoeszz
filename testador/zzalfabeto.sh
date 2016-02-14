# Testa todos os tipos de alfabetos

$ zzalfabeto --militar ABC
Alpha
Bravo
Charlie
$ zzalfabeto --radio ABC
Alpha
Bravo
Charlie
$ zzalfabeto --fone ABC
Alpha
Bravo
Charlie
$ zzalfabeto --otan ABC
Alpha
Bravo
Charlie
$ zzalfabeto --nato ABC
Alpha
Bravo
Charlie
$ zzalfabeto --icao ABC
Alpha
Bravo
Charlie
$ zzalfabeto --itu ABC
Alpha
Bravo
Charlie
$ zzalfabeto --imo ABC
Alpha
Bravo
Charlie
$ zzalfabeto --faa ABC
Alpha
Bravo
Charlie
$ zzalfabeto --ansi ABC
Alpha
Bravo
Charlie
$ zzalfabeto --romano ABC
A
B
C
$ zzalfabeto --latino ABC
A
B
C
$ zzalfabeto --royal-navy ABC
Apples
Butter
Charlie
$ zzalfabeto --royal ABC
Apples
Butter
Charlie
$ zzalfabeto --signalese ABC
Ack
Beer
Charlie
$ zzalfabeto --western-front ABC
Ack
Beer
Charlie
$ zzalfabeto --raf24 ABC
Ace
Beer
Charlie
$ zzalfabeto --raf42 ABC
Apple
Beer
Charlie
$ zzalfabeto --raf43 ABC
Able/Affirm
Baker
Charlie
$ zzalfabeto --raf ABC
Able/Affirm
Baker
Charlie
$ zzalfabeto --us41 ABC
Able
Baker
Charlie
$ zzalfabeto --us ABC
Able
Baker
Charlie
$ zzalfabeto --portugal ABC
Aveiro
Bragança
Coimbra
$ zzalfabeto --pt ABC
Aveiro
Bragança
Coimbra
$ zzalfabeto --name ABC
Alan
Bobby
Charlie
$ zzalfabeto --names ABC
Alan
Bobby
Charlie
$ zzalfabeto --lapd ABC
Adam
Boy
Charles
$ zzalfabeto --morse ABC
.-
-...
-.-.
$
$ zzalfabeto --imo --royal XYZ
MILITAR       ROYAL-NAVY
X-ray/Xadrez  Xerxes
Yankee        Yellow
Zulu          Zebra
$ zzalfabeto --pt --signalese --german --radio KWY
SIGNALESE  GERMAN            MILITAR       PORTUGAL
King       Kaufmann/Konrad   Kilo          Kilograma
William    Wilhelm           Whiskey       Washington
Yorker     Ypsilon           Yankee        York
$ zzalfabeto --all
ROMANO  MORSE  MILITAR       ROYAL-NAVY  SIGNALESE  RAF24    RAF42         RAF                 US       NAMES      LAPD     GERMAN            PORTUGAL
A       .-     Alpha         Apples      Ack        Ace      Apple         Able/Affirm         Able     Alan       Adam     Anton             Aveiro
B       -...   Bravo         Butter      Beer       Beer     Beer          Baker               Baker    Bobby      Boy      Berta             Bragança
C       -.-.   Charlie       Charlie     Charlie    Charlie  Charlie       Charlie             Charlie  Charlie    Charles  Casar             Coimbra
D       -..    Delta         Duff        Don        Don      Dog           Dog                 Dog      David      David    Dora              Dafundo
E       .      Echo          Edward      Edward     Edward   Edward        Easy                Easy     Edward     Edward   Emil              Évora
F       ..-.   Foxtrot       Freddy      Freddie    Freddie  Freddy        Fox                 Fox      Frederick  Frank    Friedrich         Faro
G       --.    Golf          George      Gee        George   George        George              George   George     George   Gustav            Guarda
H       ....   Hotel         Harry       Harry      Harry    Harry         How                 How      Howard     Henry    Heinrich          Horta
I       ..     India         Ink         Ink        Ink      In            Item/Interrogatory  Item     Isaac      Ida      Ida               Itália
J       .---   Juliet        Johnnie     Johnnie    Johnnie  Jug/Johnny    Jig/Johnny          Jig      James      John     Julius            José
K       -.-    Kilo          King        King       King     King          King                King     Kevin      King     Kaufmann/Konrad   Kilograma
L       .-..   Lima          London      London     London   Love          Love                Love     Larry      Lincoln  Ludwig            Lisboa
M       --     Mike          Monkey      Emma       Monkey   Mother        Mike                Mike     Michael    Mary     Martha            Maria
N       -.     November      Nuts        Nuts       Nuts     Nuts          Nab/Negat           Nan      Nicholas   Nora     Nordpol           Nazaré
O       ---    Oscar         Orange      Oranges    Orange   Orange        Oboe                Oboe     Oscar      Ocean    Otto              Ovar
P       .--.   Papa          Pudding     Pip        Pip      Peter         Peter/Prep          Peter    Peter      Paul     Paula             Porto
Q       --.-   Quebec        Queenie     Queen      Queen    Queen         Queen               Queen    Quincy     Queen    Quelle            Queluz
R       .-.    Romeo         Robert      Robert     Robert   Roger/Robert  Roger               Roger    Robert     Robert   Richard           Rossio
S       ...    Sierra        Sugar       Esses      Sugar    Sugar         Sugar               Sugar    Stephen    Sam      Samuel/Siegfried  Setúbal
T       -      Tango         Tommy       Toc        Toc      Tommy         Tare                Tare     Trevor     Tom      Theodor           Tavira
U       ..-    Uniform       Uncle       Uncle      Uncle    Uncle         Uncle               Uncle    Ulysses    Union    Ulrich            Unidade
V       ...-   Victor        Vinegar     Vic        Vic      Vic           Victor              Victor   Vincent    Victor   Viktor            Viseu
W       .--    Whiskey       Willie      William    William  William       William             William  William    William  Wilhelm           Washington
X       -..-   X-ray/Xadrez  Xerxes      X-ray      X-ray    X-ray         X-ray               X-ray    Xavier     X-ray    Xanthippe/Xavier  Xavier
Y       -.--   Yankee        Yellow      Yorker     Yorker   Yoke/Yorker   Yoke                Yoke     Yaakov     Young    Ypsilon           York
Z       --..   Zulu          Zebra       Zebra      Zebra    Zebra         Zebra               Zebra    Zebedee    Zebra    Zacharias/Zurich  Zulmira
$

# Se o texto não for informado, mostra o alfabeto completo

$ zzalfabeto
A
B
C
D
E
F
G
H
I
J
K
L
M
N
O
P
Q
R
S
T
U
V
W
X
Y
Z
$ zzalfabeto --militar
Alpha
Bravo
Charlie
Delta
Echo
Foxtrot
Golf
Hotel
India
Juliet
Kilo
Lima
Mike
November
Oscar
Papa
Quebec
Romeo
Sierra
Tango
Uniform
Victor
Whiskey
X-ray/Xadrez
Yankee
Zulu
$

# Pegadinhas

$ zzalfabeto 'A B C'
A

B

C
$ zzalfabeto --otan A-B.C
Alpha
-
Bravo
.
Charlie
$ zzalfabeto --otan 1234
1
2
3
4
$ zzalfabeto --otan '.[+*({\!'
.
[
+
*
(
{
\
!
$
