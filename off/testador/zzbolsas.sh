$ zzbolsas

americas :
 ^MERV ^BVSP ^MXX

europe :
 ^BFX ^FCHI ^GDAXI ^OSEAX ^OMXSPI ^SSMI ^FTSE

asia :
 ^HSI ^JKSE ^KLSE ^STI

africa :
 ^TA100

Dow Jones :
 ^DJI ^IXIC

NYSE :
 ^NYA ^NYI ^NYY ^NY ^NYL ^NYK

Nasdaq :
 ^IXIC ^BANK ^NBI ^IXCO ^IXF ^INDS ^INSR ^OFIN ^IXTC ^TRAN ^NDX

Standard & Poors :
 ^GSPC ^OEX ^MID ^SPSUPX ^SP600

Amex :
 ^XAX ^NWX ^XMI ^SPHYDA

Outros Índices Nacionais :
 ^IBX50 ^IVBX ^IGCX ^IEE INDX.SA
$

$ zzbolsas -l

americas :
^MERV     MerVal
^BVSP     Bovespa
^MXX      IPC

europe :
^BFX      BEL-20
^FCHI     CAC 40
^GDAXI    DAX
^OSEAX    OSE All Share
^OMXSPI   Stockholm General
^SSMI     Swiss Market
^FTSE     FTSE 100

asia :
^HSI      Hang Seng
^JKSE     Jakarta Composite Index
^KLSE     KLSE Composite
^STI      Straits Times

africa :
^TA100

Dow Jones :
 ^DJI      30 Industrials
 ^IXIC     Composite

NYSE :
 ^NYA       NYSE COMPOSITE (DJ)
 ^NYI       NYSE INTL 100 INDEX
 ^NYY       NYSE TMT INDEX
 ^NY        NYSE US 100 INDEX
 ^NYL       NYSE WORLD LEADERS INDEX
 ^NYK       NYSE FINANCIAL INDEX

Nasdaq :
 ^IXIC      NASDAQ Composite
 ^BANK      NASDAQ Bank
 ^NBI       NASDAQ Biotechnology
 ^IXCO      NASDAQ Computer
 ^IXF       NASDAQ Financial 100
 ^INDS      NASDAQ Industrial
 ^INSR      NASDAQ Insurance
 ^OFIN      NASDAQ Other Finance
 ^IXTC      NASDAQ Telecommunications
 ^TRAN      NASDAQ Transportation
 ^NDX       NASDAQ-100

Standard & Poors :
 ^GSPC      S&P 500
 ^OEX       S&P 100 INDEX
 ^MID       S&P MID CAP 400 INDEX
 ^SPSUPX    S&P COMP1500
 ^SP600     S&P 600

Amex :
 ^XAX       NYSE AMEX COMPOSITE INDEX
 ^NWX       NYSE ARCA NETWORKING INDEX
 ^XMI       NYSE ARCA MAJOR MARKET INDEX
 ^SPHYDA    AMEX SPHYDA INDEX

Outros Índices Nacionais :
 ^IBX50     IBRX 50
 ^IVBX      IVBX2
 ^IGCX      IGOVERNANCA
 ^IEE       IEELETRICA
 INDX.SA    INDUSTRIAL
$

$ zzbolsas ^bvsp 04/05/2005
IBOVESPA (^BVSP)
Data               4/mai/2005
Abertura            24.738,00
Alta                25.560,00
Baixa               24.738,00
Fechar              25.474,00
Volume                      0
Enc ajustado*       25.474,00
$

$ zzbolsas ^bvsp 04/05/2005 05/05/2015
IBOVESPA (^BVSP)
Data               4/mai/2005      5/mai/2015    Variação (%)
Abertura            24.738,00       57.350,00      32612 (131.83%)
Alta                25.560,00       58.147,00      32587 (127.49%)
Baixa               24.738,00       57.096,00      32358 (130.80%)
Fechar              25.474,00       58.052,00      32578 (127.89%)
Volume                      0               0          0
Enc ajustado*       25.474,00       58.052,00      32578 (127.89%)
$

$ zzbolsas petr3.sa 11/12/2013
Petroleo Brasileiro SA Petrobras (PETR3.SA)
Data              11/dez/2013
Abertura                16,19
Alta                    16,20
Baixa                   15,64
Fechar                  15,66
Volume              6.572.300
Enc ajustado*           15,10
$

$ zzbolsas vale3.sa 12/11/2010
Vale SA (VALE3.SA)
Data              12/nov/2010
Abertura                55,00
Alta                    56,50
Baixa                   54,52
Fechar                  55,00
Volume              2.691.600
Enc ajustado*           42,24
$

$ zzbolsas vs petr3.sa vale3.sa 09/09/2009
Petroleo Brasileiro SA Petrobras (PETR3.SA) Vale SA (VALE3.SA)
Data               9/set/2009               9/set/2009
Abertura                39,71               38,20
Alta                    39,95               38,29
Baixa                   39,28               37,95
Fechar                  39,80               38,15
Volume              3.731.500               2.701.500
Enc ajustado*           36,85               28,49
$

$ zzbolsas ^bvsp paulo | sed '1d;s/^\(.\{68\}\).*/\1/'
CESP6.SA       CESP - Cia Energetica de Sao Paulo                   
SBSP3.SA       Companhia de Saneamento Basico do Estado de Sao Paulo
$

$ zzbolsas commodities     #→ --lines 18
$ zzbolsas moedas          #→ --lines 18
$ zzbolsas moedas latina   #→ --lines 14
$ zzbolsas moedas europa   #→ --lines 16
$ zzbolsas taxas_cruzadas  #→ --lines 9
$ zzbolsas volume | head -n 90          #→ --lines 90
$ zzbolsas alta | head -n 90            #→ --lines 90
$ zzbolsas baixa | head -n 90           #→ --lines 90
