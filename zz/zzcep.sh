# ----------------------------------------------------------------------------
# http://www.achecep.com.br
# Busca o CEP de qualquer rua de qualquer cidade do país ou vice-versa.
# Pode-se fornecer apenas o CEP, ou o endereço com estado.
# Uso: zzcep <endereço estado| CEP>
# Ex.: zzcep Rua Santa Ifigênia, SP
#      zzcep 01310-000
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-11-08
# Versão: 3
# Licença: GPL
# Requisitos: zzxml zzlimpalixo zzjuntalinhas zzsemacento zzminusculas
# ----------------------------------------------------------------------------
zzcep ()
{
	zzzz -h cep "$1" && return

	local end
	local url='http://cep.guiamais.com.br'

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso cep; return 1; }

	# Testando se parametro é o CEP
	if echo "$1" | grep -E '^[0-9]{5}-[0-9]{3}$' > /dev/null
	then
		url="${url}/cep/$1"
	else
		end=$(echo "$*" | zzsemacento | zzminusculas | sed "s/, */-/g;$ZZSEDURL")
		url="${url}/busca/$end"
	fi

	zztool source "$url" |
	zzxml --tag tbody --untag=a --untag=br --untag=label |
	zzlimpalixo | zzjuntalinhas -i '<tr' -f 'tr>' |
	sed '
		s|</*tr[^>]*>[[:blank:]]*||g
		s|[[:blank:]]*</td>[[:blank:]]*||g
		s/<td[^>]*>//g
		s/[[:blank:]]*Ver$//
		s/^[[:blank:]]*//
		1d
		$d
		/^[[:blank:]]*$/d'
}
