# ----------------------------------------------------------------------------
# Decodifica uma URL em texto.
# Uso: zzurldecode [string]
# Ex.: zzurldecode '%21%40%23%24_%2B%7B%7D%5E%2Babcd'
#      echo 'http%3A%2F%2F' | zzurldecode
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-03-14
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzurldecode ()
{
	zzzz -h urldecode "$1" && return

	zztool multi_stdin "$@" |
	sed '
	s/+/ /g;	s/%20/ /g;	s/%21/!/g;	s/%22/"/g;	s/%23/#/g;
	s/%24/$/g;	s/%25/%/g;	s/%26/&/g;	s/%28/(/g;	s/%29/)/g;
	s/%2A/*/g;	s/%2B/+/g;	s/%2C/,/g;	s/%2D/-/g;	s/%2E/./g;
	s|%2F|/|g;	s/%30/0/g;	s/%31/1/g;	s/%32/2/g;	s/%33/3/g;
	s/%34/4/g;	s/%35/5/g;	s/%36/6/g;	s/%37/7/g;	s/%38/8/g;
	s/%39/9/g;	s/%3A/:/g;	s/%3B/;/g;	s/%3C/</g;	s/%3D/=/g;
	s/%3E/>/g;	s/%3F/?/g;	s/%40/@/g;	s/%41/A/g;	s/%42/B/g;
	s/%43/C/g;	s/%44/D/g;	s/%45/E/g;	s/%46/F/g;	s/%47/G/g;
	s/%48/H/g;	s/%49/I/g;	s/%4A/J/g;	s/%4B/K/g;	s/%4C/L/g;
	s/%4D/M/g;	s/%4E/N/g;	s/%4F/O/g;	s/%50/P/g;	s/%51/Q/g;
	s/%52/R/g;	s/%53/S/g;	s/%54/T/g;	s/%55/U/g;	s/%56/V/g;
	s/%57/W/g;	s/%58/X/g;	s/%59/Y/g;	s/%5A/Z/g;	s/%5B/[/g;
	s/%5C/\\/g;	s/%5D/]/g;	s/%5E/^/g;	s/%5F/_/g;	s/%60/`/g;
	s/%61/a/g;	s/%62/b/g;	s/%63/c/g;	s/%64/d/g;	s/%65/e/g;
	s/%66/f/g;	s/%67/g/g;	s/%68/h/g;	s/%69/i/g;	s/%6A/j/g;
	s/%6B/k/g;	s/%6C/l/g;	s/%6D/m/g;	s/%6E/n/g;	s/%6F/o/g;
	s/%70/p/g;	s/%71/q/g;	s/%72/r/g;	s/%73/s/g;	s/%74/t/g;
	s/%75/u/g;	s/%76/v/g;	s/%77/w/g;	s/%78/x/g;	s/%79/y/g;
	s/%7A/z/g;	s/%7B/{/g;	s/%7C/|/g;	s/%7D/}/g;	s/%7E/~/g;
	s/%A1/¡/g;	s/%A2/¢/g;	s/%A3/£/g;	s/%A4/¤/g;	s/%A5/¥/g;
	s/%A6/¦/g;	s/%A7/§/g;	s/%A8/¨/g;	s/%A9/©/g;	s/%AA/ª/g;
	s/%AB/«/g;	s/%AC/¬/g;	s/%AD/­/g;	s/%AE/®/g;	s/%AF/¯/g;
	s/%B0/°/g;	s/%B1/±/g;	s/%B2/²/g;	s/%B3/³/g;	s/%B4/´/g;
	s/%B5/µ/g;	s/%B6/¶/g;	s/%B7/·/g;	s/%B8/¸/g;	s/%B9/¹/g;
	s/%BA/º/g;	s/%BB/»/g;	s/%BC/¼/g;	s/%BD/½/g;	s/%BE/¾/g;
	s/%BF/¿/g;	s/%C0/À/g;	s/%C1/Á/g;	s/%C2/Â/g;	s/%C3/Ã/g;
	s/%C4/Ä/g;	s/%C5/Å/g;	s/%C6/Æ/g;	s/%C7/Ç/g;	s/%C8/È/g;
	s/%C9/É/g;	s/%CA/Ê/g;	s/%CB/Ë/g;	s/%CC/Ì/g;	s/%CD/Í/g;
	s/%CE/Î/g;	s/%CF/Ï/g;	s/%D0/Ð/g;	s/%D1/Ñ/g;	s/%D2/Ò/g;
	s/%D3/Ó/g;	s/%D4/Ô/g;	s/%D5/Õ/g;	s/%D6/Ö/g;	s/%D7/×/g;
	s/%D8/Ø/g;	s/%D9/Ù/g;	s/%DA/Ú/g;	s/%DB/Û/g;	s/%DC/Ü/g;
	s/%DD/Ý/g;	s/%DE/Þ/g;	s/%DF/ß/g;	s/%E0/à/g;	s/%E1/á/g;
	s/%E2/â/g;	s/%E3/ã/g;	s/%E4/ä/g;	s/%E5/å/g;	s/%E6/æ/g;
	s/%E7/ç/g;	s/%E8/è/g;	s/%E9/é/g;	s/%EA/ê/g;	s/%EB/ë/g;
	s/%EC/ì/g;	s/%ED/í/g;	s/%EE/î/g;	s/%EF/ï/g;	s/%F0/ð/g;
	s/%F1/ñ/g;	s/%F2/ò/g;	s/%F3/ó/g;	s/%F4/ô/g;	s/%F5/õ/g;
	s/%F6/ö/g;	s/%F7/÷/g;	s/%F8/ø/g;	s/%F9/ù/g;	s/%FA/ú/g;
	s/%FB/û/g;	s/%FC/ü/g;	s/%FD/ý/g;	s/%FE/þ/g;	s/%FF/ÿ/g
	' | sed "s/%27/'/g"
}
