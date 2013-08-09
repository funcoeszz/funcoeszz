# Caracteres que serão desacentuados

$ zzsemacento àáâãäåèéêëìíîïòóôõöùúûü     #→ aaaaaaeeeeiiiiooooouuuu
$ zzsemacento ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜ     #→ AAAAAAEEEEIIIIOOOOOUUUU
$ v1='çÇñÑß¢Ðð£Øø§µÝý¥¹²³ªº'
$ v2='cCnNBcDdLOoSuYyY123ao'
$ zzsemacento "$v1"                       #→ --eval echo "$v2"

# Caracteres que não serão alterados

$ zzsemacento abcdefghijklmnopqrstuvwxyz  #→ abcdefghijklmnopqrstuvwxyz
$ zzsemacento ABCDEFGHIJKLMNOPQRSTUVWXYZ  #→ ABCDEFGHIJKLMNOPQRSTUVWXYZ
$ zzsemacento 0123456789                  #→ 0123456789
