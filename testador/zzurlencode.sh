$ zzurlencode '!@#$%"&*()¹²³£¢¬{[]}\§'	#→ %21%40%23%24%25%22%26%2A%28%29%B9%B2%B3%A3%A2%AC%7B%5B%5D%7D%5C%A7
$ zzurlencode '€®ŧ←↓→øþªºłĸħŋđðßæ'		#→ %20AC%AE%167%2190%2193%2192%F8%FE%AA%BA%142%138%127%14B%111%F0%DF%E6
$ zzurlencode '«»©“”nµ·̣°'				#→ %AB%BB%A9%201C%201Dn%B5%B7%323%B0
$ zzurlencode '/\' '"`^:?\<>,./|*'		#→ %22%60%5E%3A%3F\%3C%3E%2C./%7C%2A
$ zzurlencode '| | |'					#→ %7C%20%7C%20%7C

# Estes não devem ser convertidos

$ zzurlencode ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-
ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-
$

# Testa caracteres especiais

$ n="$(printf '.\n.')"
$ t="$(printf '.\t.')"
$ zzurlencode	"$t"		#→ .%09.
$ zzurlencode	"$n"		#→ .%0A.
$ unset n
$ unset t
