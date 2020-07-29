$ regex='$d;s/: -\{,1\}[0-9]\{1,3\}\.[0-9]\{4,\}/: 9.99/'
$ zzgeoip 177.206.16.250 | sed "$regex"
       IP: 177.206.16.250
   Cidade: Osasco
   Estado: SP
     País: BR
 Latitude: 9.99
Longitude: 9.99
$ zzgeoip 200.147.67.142 | sed "$regex"
       IP: 200.147.67.142
   Cidade:  
   Estado:  
     País: BR
 Latitude: 9.99
Longitude: 9.99
$ zzgeoip 200.192.176.65 | sed "$regex"
       IP: 200.192.176.65
   Cidade:  
   Estado:  
     País: BR
 Latitude: 9.99
Longitude: 9.99
$ zzgeoip 104.119.85.90 | sed "$regex"
       IP: 104.119.85.90
   Cidade: Cambridge
   Estado: MA
     País: US
 Latitude: 9.99
Longitude: 9.99
$ zzgeoip 74.6.50.150 | sed "$regex"
       IP: 74.6.50.150
   Cidade: Sunnyvale
   Estado: CA
     País: US
 Latitude: 9.99
Longitude: 9.99
$
