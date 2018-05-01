# Prevenindo caches anteriores
$ rm -f ${ZZTMP}.pronuncia.{apple,woman,forget,plural,single,computer,yes,seven}.mp3 2>/dev/null
$
$ zzpronuncia apple; ls ${ZZTMP}.pronuncia.apple.mp3 >/dev/null 2>&1; echo $? #→ 0
$ zzpronuncia woman; ls ${ZZTMP}.pronuncia.woman.mp3 >/dev/null 2>&1; echo $? #→ 0
$ zzpronuncia forget; ls ${ZZTMP}.pronuncia.forget.mp3 >/dev/null 2>&1; echo $? #→ 0
$ zzpronuncia plural; ls ${ZZTMP}.pronuncia.plural.mp3 >/dev/null 2>&1; echo $? #→ 0
$ zzpronuncia single; ls ${ZZTMP}.pronuncia.single.mp3 >/dev/null 2>&1; echo $? #→ 0
$ zzpronuncia computer; ls ${ZZTMP}.pronuncia.computer.mp3 >/dev/null 2>&1; echo $? #→ 0
$ zzpronuncia yes; ls ${ZZTMP}.pronuncia.yes.mp3 >/dev/null 2>&1; echo $? #→ 0
$ zzpronuncia seven; ls ${ZZTMP}.pronuncia.seven.mp3 >/dev/null 2>&1; echo $? #→ 0

# Limpeza
$ rm -f ${ZZTMP}.pronuncia.{apple,woman,forget,plural,single,computer,yes,seven}.mp3 2>/dev/null
