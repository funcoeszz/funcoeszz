# Preparação
$ touch /tmp/_tmp1 /tmp/_tmp2 /tmp/_tmp3 /tmp/_tmp4 /tmp/_tmp5
$

$ zzmudaprefixo -a /tmp/_tm -n /tmp/=tm
“/tmp/_tmp1” -> “/tmp/=tmp1”
“/tmp/_tmp2” -> “/tmp/=tmp2”
“/tmp/_tmp3” -> “/tmp/=tmp3”
“/tmp/_tmp4” -> “/tmp/=tmp4”
“/tmp/_tmp5” -> “/tmp/=tmp5”
$

$ zzmudaprefixo -a /tmp/=tm -n /tmp/#tm
“/tmp/=tmp1” -> “/tmp/#tmp1”
“/tmp/=tmp2” -> “/tmp/#tmp2”
“/tmp/=tmp3” -> “/tmp/#tmp3”
“/tmp/=tmp4” -> “/tmp/#tmp4”
“/tmp/=tmp5” -> “/tmp/#tmp5”
$

$ zzmudaprefixo -a /tmp/#tm -n /tmp/_tm
“/tmp/#tmp1” -> “/tmp/_tmp1”
“/tmp/#tmp2” -> “/tmp/_tmp2”
“/tmp/#tmp3” -> “/tmp/_tmp3”
“/tmp/#tmp4” -> “/tmp/_tmp4”
“/tmp/#tmp5” -> “/tmp/_tmp5”
$

# Limpeza
$ rm -f /tmp/_tmp[1-5]
$
