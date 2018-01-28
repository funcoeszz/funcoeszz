#Previsão do tempo para: Curitiba, Brazil
#
#     \   /     Céu limpo
#      .-.      18 °C          
#   ― (   ) ―   ← 2 km/h       
#      `-’      10 km          
#     /   \     0.0 mm   
$ zztempo -0 -m -l pt curitiba | sed '1 s/Curitiba.*$/Curitiba/g; 2,3 d; s/[0-9][0-9]*/9/g; s/[.-]9\+//g; s/^ .\{14\}//g; s/[↖|↗|↘|↙|←|↑|→|↓]/↑/g; s/ *$//'
Previsão do tempo para: Curitiba
9 °C
↑ 9 km/h
9 km
9 mm
$
