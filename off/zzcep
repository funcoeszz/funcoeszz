# ----------------------------------------------------------------------------
# http://www.correios.com.br/servicos/cep
# Busca o CEP de qualquer rua de qualquer cidade do país ou vice-versa.
# Uso: zzcep estado cidade rua
# Ex.: zzcep PR curitiba rio gran
#      zzcep RJ 'Rio de Janeiro' Vinte de
#
# Autor: Aurélio Marinho Jargas, www.aurelio.net
# Desde: 2000-11-08
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2008-03-01 Agora o site dos Correios usa AJAX :(
zzcep ()
{
	zzzz -h cep $1 && return

	local r c
	local url='http://www.correios.com.br/servicos/cep'
	local e="$1"

	# Verificação dos parâmetros
	[ "$3" ] || { zztool uso cep; return; }

	c=$(echo "$2"| sed "$ZZSEDURL")
	shift
	shift
	r=$(echo "$*"| sed "$ZZSEDURL")
	echo "UF=$e&Localidade=$c&Tipo=&Logradouro=$r" |
		$ZZWWWPOST "$url" |
		sed -n '
			/^ *UF:/,/^$/ {
				/Página Anter/d
				s/.*óxima Pág.*/...CONTINUA/
				p
			}'
}
