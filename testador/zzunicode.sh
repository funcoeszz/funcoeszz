$ zzunicode | head -n 10
  1 - 0000 a 007F - Basic Latin
  2 - 0080 a 00FF - Latin-1 Supplement
  3 - 0100 a 017F - Latin Extended-A
  4 - 0180 a 024F - Latin Extended-B
  5 - 0250 a 02AF - IPA Extensions
  6 - 02B0 a 02FF - Spacing Modifier Letters
  7 - 0300 a 036F - Combining Diacritical Marks
  8 - 0370 a 03FF - Greek and Coptic
  9 - 0400 a 04FF - Cyrillic
 10 - 0500 a 052F - Cyrillic Supplement
$ zzunicode 8 | head -n 6
Greek and Coptic
0370	Ͱ
0371	ͱ
0372	Ͳ
0373	ͳ
0374	ʹ
$ zzunicode -n 36 | head -n 10
Georgian
10A0	Ⴀ	Georgian Capital Letter An
10A1	Ⴁ	Georgian Capital Letter Ban
10A2	Ⴂ	Georgian Capital Letter Gan
10A3	Ⴃ	Georgian Capital Letter Don
10A4	Ⴄ	Georgian Capital Letter En
10A5	Ⴅ	Georgian Capital Letter Vin
10A6	Ⴆ	Georgian Capital Letter Zen
10A7	Ⴇ	Georgian Capital Letter Tan
10A8	Ⴈ	Georgian Capital Letter In
$ zzunicode -c 3 3
Latin Extended-A
0100	Ā          012B	ī          0156	Ŗ
0101	ā          012C	Ĭ          0157	ŗ
0102	Ă          012D	ĭ          0158	Ř
0103	ă          012E	Į          0159	ř
0104	Ą          012F	į          015A	Ś
0105	ą          0130	İ          015B	ś
0106	Ć          0131	ı          015C	Ŝ
0107	ć          0132	Ĳ          015D	ŝ
0108	Ĉ          0133	ĳ          015E	Ş
0109	ĉ          0134	Ĵ          015F	ş
010A	Ċ          0135	ĵ          0160	Š
010B	ċ          0136	Ķ          0161	š
010C	Č          0137	ķ          0162	Ţ
010D	č          0138	ĸ          0163	ţ
010E	Ď          0139	Ĺ          0164	Ť
010F	ď          013A	ĺ          0165	ť
0110	Đ          013B	Ļ          0166	Ŧ
0111	đ          013C	ļ          0167	ŧ
0112	Ē          013D	Ľ          0168	Ũ
0113	ē          013E	ľ          0169	ũ
0114	Ĕ          013F	Ŀ          016A	Ū
0115	ĕ          0140	ŀ          016B	ū
0116	Ė          0141	Ł          016C	Ŭ
0117	ė          0142	ł          016D	ŭ
0118	Ę          0143	Ń          016E	Ů
0119	ę          0144	ń          016F	ů
011A	Ě          0145	Ņ          0170	Ű
011B	ě          0146	ņ          0171	ű
011C	Ĝ          0147	Ň          0172	Ų
011D	ĝ          0148	ň          0173	ų
011E	Ğ          0149	ŉ          0174	Ŵ
011F	ğ          014A	Ŋ          0175	ŵ
0120	Ġ          014B	ŋ          0176	Ŷ
0121	ġ          014C	Ō          0177	ŷ
0122	Ģ          014D	ō          0178	Ÿ
0123	ģ          014E	Ŏ          0179	Ź
0124	Ĥ          014F	ŏ          017A	ź
0125	ĥ          0150	Ő          017B	Ż
0126	Ħ          0151	ő          017C	ż
0127	ħ          0152	Œ          017D	Ž
0128	Ĩ          0153	œ          017E	ž
0129	ĩ          0154	Ŕ          017F	ſ
012A	Ī          0155	ŕ
$

# Opção inválida
$ zzunicode -j
Uso: zzunicode [-n|-c <número>] [número]
$

# Argumento não numérico
$ zzunicode asas
Uso: zzunicode [-n|-c <número>] [número]
$
