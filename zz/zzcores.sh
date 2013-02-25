# ----------------------------------------------------------------------------
# Mostra todas as combinações de cores possíveis no console.
# Também mostra os códigos ANSI para obter tais combinações.
# Uso: zzcores
# Ex.: zzcores
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2001-12-11
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzcores ()
{
	zzzz -h cores "$1" && return

	local frente fundo negrito cor

	for frente in 0 1 2 3 4 5 6 7
	do
		for negrito in '' ';1' # alterna entre linhas sem e com negrito
		do
			for fundo in 0 1 2 3 4 5 6 7
			do
				# Compõe o par de cores: NN;NN
				cor="4$fundo;3$frente"

				# Mostra na tela usando caracteres de controle: ESC[ NN m
				printf "\033[$cor${negrito}m $cor${negrito:-  } \033[m"
			done
			echo
		done
	done
}
