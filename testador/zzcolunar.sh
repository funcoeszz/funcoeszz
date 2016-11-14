# Tomando emprestado os arquivos _numeros.txt, _dados.txt e zzmoneylog.in.txt
# Preparando arquivo de nome incomun
$ cat _numeros.txt _dados.txt > "-_tmp1"
$

$ cat _numeros.txt _dados.txt | zzcolunar 3
1             5             4:quatro:four
2             1:um:one      5:cinco:five
3             2:dois:two
4             3:tres:three
$

$ zzcolunar 3 -- -_tmp1
1             5             4:quatro:four
2             1:um:one      5:cinco:five
3             2:dois:two
4             3:tres:three
$

$ cat _numeros.txt _dados.txt | zzcolunar -z 3
1             2             3
4             5             1:um:one
2:dois:two    3:tres:three  4:quatro:four
5:cinco:five
$

$ cat _numeros.txt _dados.txt | zzcolunar -c -z 2
      1             2
      3             4
      5         1:um:one
 2:dois:two   3:tres:three
4:quatro:four 5:cinco:five
$

$ zzcolunar -c -z 2 -- -_tmp1
      1             2
      3             4
      5         1:um:one
 2:dois:two   3:tres:three
4:quatro:four 5:cinco:five
$

$ cat _numeros.txt _dados.txt | zzcolunar -r 4
            1             4    2:dois:two  5:cinco:five
            2             5  3:tres:three
            3      1:um:one 4:quatro:four
$

$ awk '/-/{print $1, $2}' zzmoneylog.in.txt | tr '-' ' ' | zzcolunar -c 3
 2009 05 01  100       2009 07 15     2009 05 07  20,00
2009 05 15  74,23  2009 08 20  10,00  2009 06 07  17,80
    2009 05 15       2009 05 05 500   2009 07 07  32,37
2009 05 23  39,90    2009 06 05 500   2009 08 07  30,00
2009 06 03  342,59   2009 07 05 500   2009 12 31 +99,99
 2009 06 11 30,00    2009 08 05 500   2009 08 05  500/5
2009 06 12  35,00  2009 05 07  25,00   2009 11 25 100/2
    2009 06 15     2009 06 07  20,00  2009 05 05  200*6
2009 06 29  95,67  2009 07 07  29,00   2009 09 10 100*4
2009 07 12  199,90 2009 08 07  25,00
$

$ awk '/-/{print $1, $2}' zzmoneylog.in.txt | tr '-' ' ' | zzcolunar -z -r -w 25 4
          2009 05 01  100         2009 05 15  74,23                2009 05 15         2009 05 23  39,90
       2009 06 03  342,59          2009 06 11 30,00         2009 06 12  35,00                2009 06 15
        2009 06 29  95,67        2009 07 12  199,90                2009 07 15         2009 08 20  10,00
           2009 05 05 500            2009 06 05 500            2009 07 05 500            2009 08 05 500
        2009 05 07  25,00         2009 06 07  20,00         2009 07 07  29,00         2009 08 07  25,00
        2009 05 07  20,00         2009 06 07  17,80         2009 07 07  32,37         2009 08 07  30,00
        2009 12 31 +99,99         2009 08 05  500/5          2009 11 25 100/2         2009 05 05  200*6
         2009 09 10 100*4
$

$ awk '/-/{print $1, $2}' zzmoneylog.in.txt | tr '-' ' ' | zzcolunar -j -w 20 4
2009   05   01   100 2009  06  29   95,67 2009  05  07   25,00 2009  12  31  +99,99
2009  05  15   74,23 2009  07  12  199,90 2009  06  07   20,00 2009  08  05   500/5
2009      05      15 2009      07      15 2009  07  07   29,00 2009  11  25   100/2
2009  05  23   39,90 2009  08  20   10,00 2009  08  07   25,00 2009  05  05   200*6
2009  06  03  342,59 2009   05   05   500 2009  05  07   20,00 2009  09  10   100*4
2009  06  11   30,00 2009   06   05   500 2009  06  07   17,80
2009  06  12   35,00 2009   07   05   500 2009  07  07   32,37
2009      06      15 2009   08   05   500 2009  08  07   30,00
$

$ awk '/-/{print $1, $2}' zzmoneylog.in.txt | tr '-' ' ' | zzcolunar -w 30 2
2009 05 01  100                2009 08 05 500
2009 05 15  74,23              2009 05 07  25,00
2009 05 15                     2009 06 07  20,00
2009 05 23  39,90              2009 07 07  29,00
2009 06 03  342,59             2009 08 07  25,00
2009 06 11 30,00               2009 05 07  20,00
2009 06 12  35,00              2009 06 07  17,80
2009 06 15                     2009 07 07  32,37
2009 06 29  95,67              2009 08 07  30,00
2009 07 12  199,90             2009 12 31 +99,99
2009 07 15                     2009 08 05  500/5
2009 08 20  10,00              2009 11 25 100/2
2009 05 05 500                 2009 05 05  200*6
2009 06 05 500                 2009 09 10 100*4
2009 07 05 500
$

$ awk 'BEGIN {print "numeros"}{print}' zzromanos.in.txt | zzcolunar --header 4
numeros        numeros        numeros        numeros
1:I            14:XIV         60:LX          600:DC
2:II           15:XV          70:LXX         700:DCC
3:III          16:XVI         80:LXXX        800:DCCC
4:IV           17:XVII        90:XC          900:CM
5:V            18:XVIII       99:XCIX        990:CMXC
6:VI           19:XIX         100:C          999:CMXCIX
7:VII          20:XX          101:CI         1000:M
8:VIII         25:XXV         111:CXI        1100:MC
9:IX           30:XXX         199:CXCIX      1110:MCX
10:X           35:XXXV        200:CC         1111:MCXI
11:XI          40:XL          300:CCC        2000:MM
12:XII         45:XLV         400:CD         3000:MMM
13:XIII        50:L           500:D          3999:MMMCMXCIX
$

$ awk 'BEGIN {print "numeros"}{print}' zzromanos.in.txt | zzcolunar -c -s '|'  -H 4
   numeros    |   numeros    |   numeros    |   numeros
     1:I      |    14:XIV    |    60:LX     |    600:DC
     2:II     |    15:XV     |    70:LXX    |   700:DCC
    3:III     |    16:XVI    |   80:LXXX    |   800:DCCC
     4:IV     |   17:XVII    |    90:XC     |    900:CM
     5:V      |   18:XVIII   |   99:XCIX    |   990:CMXC
     6:VI     |    19:XIX    |    100:C     |  999:CMXCIX
    7:VII     |    20:XX     |    101:CI    |    1000:M
    8:VIII    |    25:XXV    |   111:CXI    |   1100:MC
     9:IX     |    30:XXX    |  199:CXCIX   |   1110:MCX
     10:X     |   35:XXXV    |    200:CC    |  1111:MCXI
    11:XI     |    40:XL     |   300:CCC    |   2000:MM
    12:XII    |    45:XLV    |    400:CD    |   3000:MMM
   13:XIII    |     50:L     |    500:D     |3999:MMMCMXCIX
$

$ zzbicho | awk 'BEGIN {print "NN Bicho"}{print}' | zzcolunar -z -H 4
NN Bicho     NN Bicho     NN Bicho     NN Bicho
01 Avestruz  02 Águia     03 Burro     04 Borboleta
05 Cachorro  06 Cabra     07 Carneiro  08 Camelo
09 Cobra     10 Coelho    11 Cavalo    12 Elefante
13 Galo      14 Gato      15 Jacaré    16 Leão
17 Macaco    18 Porco     19 Pavão     20 Peru
21 Touro     22 Tigre     23 Urso      24 Veado
25 Vaca
$

$ zzbicho | awk 'BEGIN {print "NN Bicho"}{print}' | zzcolunar -s ' >.< ' -H 4
NN Bicho     >.< NN Bicho     >.< NN Bicho     >.< NN Bicho
01 Avestruz  >.< 08 Camelo    >.< 15 Jacaré    >.< 22 Tigre
02 Águia     >.< 09 Cobra     >.< 16 Leão      >.< 23 Urso
03 Burro     >.< 10 Coelho    >.< 17 Macaco    >.< 24 Veado
04 Borboleta >.< 11 Cavalo    >.< 18 Porco     >.< 25 Vaca
05 Cachorro  >.< 12 Elefante  >.< 19 Pavão
06 Cabra     >.< 13 Galo      >.< 20 Peru
07 Carneiro  >.< 14 Gato      >.< 21 Touro
$

# Limpeza
$ rm -f ./-_tmp1
$
