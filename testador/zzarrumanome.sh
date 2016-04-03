# Remove espaços do início e do fim
$ file0="  a  "
$

# Remove aspas
$ file1="don't \"do\" it"
$

# Hífens no início do nome são proibidos
$ file2='--help'
$

# Remove acentos
# $ file3='àáâãäåèéêëìíîïòóôõöùúûüçñß¢Ð£Øø§µÝý¥¹²³' # bugged Terminal
# $

# Qualquer caractere estranho vira sublinhado
$ file4='!@#$%&*( )+=[]{}<>^~,:;?\|'
$

# Remove sublinhados consecutivos
$ file5='a====a'
$

# Remove sublinhados antes e depois de pontos e hífens
$ file6='a - a . a'
$

# Não permite nomes vazios
$ file7="'"
$

# Exemplo da vida real
$ file8="RAMONES  -  I Don't Care (live) .MP3"
$

# Prepara pasta de testes
$ tmp="/tmp/zzarrumanome.test"
$ mkdir "$tmp"; echo $?
0
$ cd "$tmp" && touch -- "$file0" "$file1" "$file2" "$file4" "$file5" "$file6" "$file7" "$file8"
$ cd - > /dev/null
$

# Erros
$ zzarrumanome                                    #→ --regex ^Uso:
$ zzarrumanome -n                                 #→ --regex ^Uso:
$ zzarrumanome -n -d                              #→ --regex ^Uso:
$ zzarrumanome -n -r                              #→ --regex ^Uso:

# File not found: no error, just ignore
$ zzarrumanome -n XXnotfoundXX
$

# Portability: Not using $tmp/* to avoid glob expansion A-Z ordering issues
$ zzarrumanome -n "$tmp"/"$file0"
[-n] /tmp/zzarrumanome.test/  a   -> /tmp/zzarrumanome.test/a
$ zzarrumanome -n "$tmp"/"$file1"
[-n] /tmp/zzarrumanome.test/don't "do" it -> /tmp/zzarrumanome.test/dont_do_it
$ zzarrumanome -n "$tmp"/"$file2"
[-n] /tmp/zzarrumanome.test/--help -> /tmp/zzarrumanome.test/_-help
$ zzarrumanome -n "$tmp"/"$file4"
[-n] /tmp/zzarrumanome.test/!@#$%&*( )+=[]{}<>^~,:;?\| -> /tmp/zzarrumanome.test/_
$ zzarrumanome -n "$tmp"/"$file5"
[-n] /tmp/zzarrumanome.test/a====a -> /tmp/zzarrumanome.test/a_a
$ zzarrumanome -n "$tmp"/"$file6"
[-n] /tmp/zzarrumanome.test/a - a . a -> /tmp/zzarrumanome.test/a-a.a
$ zzarrumanome -n "$tmp"/"$file7"
[-n] /tmp/zzarrumanome.test/' -> /tmp/zzarrumanome.test/_
$ zzarrumanome -n "$tmp"/"$file8"
[-n] /tmp/zzarrumanome.test/RAMONES  -  I Don't Care (live) .MP3 -> /tmp/zzarrumanome.test/ramones-i_dont_care_live.mp3
$

# faxina
$ rm -rf "${tmp:-XXnotfoundXX}"
$
