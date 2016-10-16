$ zzhoracerta | head
UTC -- (UTC/GMT)
AF -- Afghanistan
AX -- Åland Islands
AL -- Albania
DZ -- Algeria
AS -- American Samoa
AD -- Andorra
AO -- Angola
AI -- Anguilla
AG -- Antigua and Barbuda
$ zzhoracerta | tail
VE -- Venezuela
VN -- Viet Nam
VG -- Virgin Islands (British)
VI -- Virgin Islands (U.S.)
UM3 -- Wake Island (U.S.)
WF -- Wallis and Futuna
EH -- Western Sahara
YE -- Yemen
ZM -- Zambia
ZW -- Zimbabwe
$ zzhoracerta rio grande do sul | sed 's/[0-9]/N/g; s/^N:/NN:/; s/ [AP]M$//; s/.* N\{1,2\}, NNNN$/DATA/; s/ Summer//; s/BRST/BRT/'
Rio Grande do Sul, Brazil
The current time and date right now
NN:NN:NN
DATA
Brasília Time (BRT) -NNNN UTC
DATA
$
# Exemplo de saída:
#Rio Grande do Sul, Brazil
#The current time and date right now
#8:10 PM
#Friday, February 27, 2015
#Brasilia Time (BRT) -0300 UTC
#UTC/GMT is 23:10 on Friday, February 27, 2015
