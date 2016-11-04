#Porto Alegre Aero-Porto , Brazil
#
#   (SBPA) 30-00S 051-11W 3M
#
#   Conditions at [Feb 27, 2015 - 06:00 PM EST]
#   2015.02.27 2300 UTC
#   Wind from the SE (140 degrees) at 7 MPH (6 KT) (direction variable)
#   Visibility greater than 7 mile(s)
#   Sky conditions mostly cloudy
#   Temperature 77 F (25 C)
#   Dew Point 71 F (22 C)
#   Relative Humidity 83%
#   Pressure (altimeter) 29.88 in. Hg (1012 hPa)
#   ob SBPA 272300Z 14006KT 100V180 9999 BKN015 BKN083 25/22 Q1012
#
$ zztempo brazil sbco | sed 's/[0-9][0-9]*/9/g; / [AP]M .[DS]T/d; s/[A-Z]\{1,\} (/X (/; s/ KT).*//; s/Visibility.* [0-9].*/Visibility 9/; / conditions/d; /^ *ob /d; /Heat index/d; /Wind /d' | sed -n '1p; /9/p'
Porto Alegre, Brazil
   (SBCO) 9-9S 9-9W
   9.9.9 9 UTC
   Visibility 9
   Temperature 9 X (9 C)
   Dew Point 9 X (9 C)
   Relative Humidity 9%
   Pressure (altimeter) 9.9 in. Hg (9 hPa)
$ zztempo
Afghanistan
Albania
Algeria
Angola
Anguilla
Antarctica
Antigua and Barbuda
Argentina
Aruba
Australia
Austria
Azerbaijan
Bahamas, The
Bahrain
Bangladesh
Barbados
Belarus
Belgium
Belize
Benin
Bermuda
Bolivia
Bosnia and Herzegovina
Botswana
Brazil
British Indian Ocean Territory
British Virgin Islands
Brunei
Bulgaria
Burkina Faso
Cambodia
Cameroon
Canada
Cape Verde
Cayman Islands
Central African Republic
Chad
Chile
China
Christmas Island
Colombia
Comoros
Congo, Democratic Republic of the
Congo, Republic of the
Cook Islands
Costa Rica
Cote d'Ivoire
Croatia
Cuba
Cyprus
Czech Republic
Denmark
Djibouti
Dominica
Dominican Republic
Ecuador
Egypt
El Salvador
Estonia
Ethiopia
Fiji
Finland
France
French Guiana
French Polynesia
Gabon
Gambia, The
Germany
Ghana
Gibraltar
Greece
Greenland
Grenada
Guadeloupe
Guatemala
Guinea-Bissau
Guyana
Honduras
Hong Kong
Hungary
Iceland
India
Indonesia
Iran
Ireland
Israel
Italy
Jamaica
Japan
Jordan
Kazakhstan
Kenya
Korea, South
Kuwait
Kyrgyzstan
Laos
Latvia
Lebanon
Liberia
Libya
Lithuania
Luxembourg
Macau
Macedonia, The Republic of
Madagascar
Malaysia
Maldives
Mali
Malta
Marshall Islands
Martinique
Mauritania
Mauritius
Mexico
Micronesia, Federated States of
Moldova
Mongolia
Morocco
Mozambique
Myanmar
Nepal
Netherlands
Netherlands Antilles
New Caledonia
New Zealand
Nicaragua
Niger
Nigeria
Norway
Oman
Pakistan
Palau
Panama
Papua New Guinea
Paraguay
Peru
Philippines
Poland
Portugal
Qatar
Reunion
Romania
Russia
Saint Helena
Saint Kitts and Nevis
Saint Lucia
Saint Pierre and Miquelon
Saint Vincent and the Grenadines
Samoa
Sao Tome and Principe
Saudi Arabia
Senegal
Serbia and Montenegro
Seychelles
Sierra Leone
Singapore
Slovakia
Slovenia
Solomon Islands
South Africa
South Georgia and the Islands
Spain
Sri Lanka
Sudan
Suriname
Swaziland
Sweden
Switzerland
Syria
Taiwan
Tajikistan
Tanzania
Thailand
Togo
Tonga
Trinidad and Tobago
Tunisia
Turkey
Turkmenistan
Tuvalu
Uganda
Ukraine
United Arab Emirates
United Kingdom
Uruguay
Uzbekistan
Vanuatu
Venezuela
Vietnam
Yemen
Zambia
Zimbabwe
$
