# ----------------------------------------------------------------------------
# Busca o DDD de qualquer cidade do país ou vice-versa.
# Pode-se fornecer apenas o DDD, cidade ou estado.
#
# Usando o argumento -i a pesquisa altera para DDI,
# podendo fornecer apenas o DDI ou o país.
#
# Uso: zzddd <DDD | Cidade | Estado>
# Ex.: zzddd 19
#      zzddd Xique-Xique
#      zzddd -i Brunei
#      zzddd -i 75
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2021-01-06
# Versão: 1
# Requisitos: zzzz zztool zzjuntalinhas zzminusculas zzpad zzsemacento zztrim zzxml
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzddd ()
{
	zzzz -h ddd "$1" && return

	local end dddend pagina1 pages ultima url2 ddd cidade estado
	local url='https://ddd.guiamais.com.br'

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso ddd; return 1; }

	# Com o paramêtro -i altera a consulta para DDI
	if test '-i' == "$1"
	then
		url='https://ddi.guiamais.com.br'
		shift
	fi

	# Testando se parametro é o CEP
	if zztool testa_numero "$1"
	then
		end=0
		dddend="$1"
	else
		end=1
		dddend=$(echo "$*" | zzsemacento | zzminusculas | sed 's/, */-/g' | zztool sedurl)
	fi

	# A primeira página ou endereço das várias páginas
	pagina1=$(zztool source "${url}/busca?word=${dddend}")

	if echo "$pagina1" | grep -F 'nav_pagination">' >/dev/null
	then
		ultima=$(echo "$pagina1" | sed -n '/nav_pagination">/,/ul>/{/\/busca\//{$d;s/.*page=//;s/".*//;p;}}' | sort -n | tail -n 1)
		url2=$(echo "$pagina1" | sed -n '/nav_pagination">/,/ul>/{/\/busca\//{s/.*href="//;s/page=.*/page=/;p;q;}}')
		for pages in $(seq $ultima)
		do
			zztool source "${url}${url2}${pages}"
		done
	else
		echo "$pagina1"
	fi |
		zzxml --tag th --tag td |
		zzjuntalinhas -i '<td' -f 'td>' -d ' ' |
		zzjuntalinhas -i '<th' -f 'th>' -d ' ' |
		zzxml --untag |
		zztrim |
		tr -s ' ' |
		awk '/Saiba como ligar/{print "";next};{printf $0 "|"}' |
		sed '2,${/DDD/d;}' |
		while IFS="|" read -r ddd cidade estado
		do
			echo "$(zzpad 3 $ddd) $(zzpad 40 $cidade) $estado"
		done |
		zztrim
}
