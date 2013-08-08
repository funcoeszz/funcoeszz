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
$ zzhoracerta rio grande do sul | sed 's/[0-9]/N/g; s/^N:/NN:/; s/ [AP]M$//; s/.* NN, NNNN$/DATA/'
The current time and date right now in Rio Grande do Sul, Brazil is
NN:NN
DATA
Brasilia Time (BRT) -NNNN UTC
$
# Exemplo de saída:
#    The current time and date right now in Rio Grande do Sul, Brazil is
#    2:35 PM
#    Thursday, August 08, 2013
#    Brasilia Time (BRT) -0300 UTC
# ou
#    Brasilia Summer Time (BRST) -0200 UTC
