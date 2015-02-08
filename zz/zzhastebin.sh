# ----------------------------------------------------------------------------
# http://hastebin.com/
# Gera link para arquivos de texto em geral.
#
# Uso: zzhastebin [arquivo]
# Ex.: zzhastebin helloworld.sh
#
# Autor: Jones Dias <diasjones07 (a) gmail.com>
# Desde: 2013-03-07
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------

zzhastebin ()
{

  zzzz -h hastebin "$1" && return

  local hst="http://hastebin.com/"
  local uri
  local ext=$(basename $1 | cut -d\. -f2)

  # Verifica o parametro da função
  if ! zztool arquivo_legivel "$1"
  then
    zztool uso hastebin
    return 1
  fi

  # Retorna o ID
  uri="$(curl -s --data-binary @$1 ${hst}documents |
  cut -d\" -f 4)"

  # Imprime link
  echo "$hst$uri.$ext"
}
