# Preparação
$ touch /tmp/_tmp1 /tmp/_tmp2 /tmp/_tmp3 /tmp/_tmp4 /tmp/_tmp5
$

$ zzmudaprefixo -a /tmp/_tm -n /tmp/=tm >/dev/null; echo $?	#→ 0
$ zzmudaprefixo -a /tmp/=tm -n /tmp/#tm >/dev/null; echo $?	#→ 0
$ zzmudaprefixo -a /tmp/#tm -n /tmp/_tm >/dev/null; echo $?	#→ 0
# Limpeza
$ rm -f /tmp/_tmp[1-5]
$
