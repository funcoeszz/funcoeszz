# ----------------------------------------------------------------------------
# Mostra uma sugestão de sanduíche para pedir na lanchonete Subway.
# Obs.: Se não gostar da sugestão, chame a função novamente para ter outra.
# Uso: zzsubway
# Ex.: zzsubway
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-12-02
# Versão: 1
# Licença: GPL
# Requisitos: zzshuffle
# ----------------------------------------------------------------------------
zzsubway ()
{
	zzzz -h subway "$1" && return

	local linha quantidade categoria opcoes

	# O formato é quantidade:categoria:opção1:...:opçãoN
	cardapio="\
	1:recheio:(1) B.M.T. Italiano:(2) Atum:(3) Vegetariano:(4) Frutos do Mar Subway:(5) Frango Teriaki:(6) Peru, Presunto & Bacon:(7) Almôndegas:(8) Carne e Queijo:(9) Peru, Presunto & Roast Beef:(10) Peito de Peru:(11) Rosbife:(12) Peito de Peru e Presunto
	1:pão:italiano branco:integral:parmesão e orégano:três queijos:integral aveia e mel
	1:tamanho:15 cm:30 cm
	1:queijo:suíço:prato:cheddar
	1:extra:nenhum:bacon:tomate seco:cream cheese
	1:tostado:sim:não
	*:salada:alface:tomate:pepino:cebola:pimentão:azeitona preta:picles:rúcula
	1:molho:mostarda e mel:cebola agridoce:barbecue:parmesão:chipotle:mostarda:maionese
	*:tempero:sal:vinagre:azeite de oliva:pimenta calabresa:pimenta do reino"

	echo "$cardapio" | while read linha; do
		quantidade=$(echo "$linha" | cut -d : -f 1 | tr -d '\t')
		categoria=$( echo "$linha" | cut -d : -f 2)
		opcoes=$(    echo "$linha" | cut -d : -f 3- | tr : '\n')

		# Que tipo de ingrediente mostraremos agora? Recheio? Pão? Tamanho? ...
		printf "%s\t: " "$categoria"

		# Quantos ingredientes opcionais colocaremos no pão?
		# O asterisco indica "qualquer quantidade", então é escolhido um
		# número qualquer dentre as opções disponíveis.
		if test "$quantidade" = '*'
		then
			quantidade=$(echo "$opcoes" | sed -n '$=')
			quantidade=$((RANDOM % quantidade + 1))
		fi

		# Hora de mostrar os ingredientes.
		# Escolhidos ao acaso (zzshuffle), são pegos N itens ($quantidade).
		# Obs.: Múltiplos itens são mostrados em uma única linha (paste+sed).
		echo "$opcoes" |
			zzshuffle |
			head -n $quantidade |
			paste -s -d : - |
			sed 's/:/, /g'
	done
}
