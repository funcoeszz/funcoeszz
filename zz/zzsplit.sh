# ----------------------------------------------------------------------------
# Separa um arquivo linha a linha alternadamente em 2 ou mais arquivos.
# Usa o mesmo nome do arquivo, colocando sufixo numérico sequencial.
#
# Opção:
#  -p <relação de linhas> - numero de linhas de cada arquivo de destino.
#    Obs1.: A relação são números de linhas de cada arquivo correspondente na
#           sequência, justapostos separados por vírgula (,).
#    Obs2.: Se a quantidade de linhas na relação for menor que a quantidade de
#           arquivos, os arquivos excedentes adotam a último valor na relação.
#    Obs3.: Os números negativos na relação, saltam as linha informadas
#           sem repassar ao arquivo destino.
#
# Uso: zzsplit -p <relação> [<numero>] | <numero> <arquivo>
# Ex.: zzsplit 3 arq.txt  # Separa em 3: arq.txt.1, arq.txt.2, arq.txt.3
#      zzsplit -p 3,5,4 5 arq.txt  # Separa em 5 arquivos
#        3 linhas no arq.txt.1, 5 linhas no arq.txt.2 e 4 linhas nos demais.
#      zzsplit -p 3,4,2 arq.txt    # Separa em 3 arquivos
#        3 linhas no arq.txt.1, 4 linhas no arq.txt.2 e 2 linhas no arq.txt.3
#      zzsplit -p 2,-3,4 arq.txt   # Separa em 2 arquivos
#        2 linhas no arq.txt.1, pula 3 linhas e 4 linhas no arq.txt.3
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-11-10
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzsplit ()
{
	zzzz -h split "$1" && return

	local passos=1
	local qtde=0

	[ "$1" ] || { zztool uso split; return 1; }

	# Quantidade de arquivo a serem separados
	# Estipulando as quantidades de linhas para cada arquivo de saída
	if [ "$1" = "-p" ]
	then
		passos="$2"
		qtde=$(echo "$passos" | awk -F"," '{ print NF }')
		shift
		shift
	fi
	# Estipilando a quantidade de arquivos de saída diretamente
	if zztool testa_numero $1
	then
		qtde=$1
		shift
	fi

	# Garantindo separar em 2 arquivos ou mais
	test "$qtde" -gt "1" || { zztool uso split; return 1; }

	# Conferindo se arquivo existe e é legível
	zztool arquivo_legivel "$1" || { zztool uso split; return 1; }

	# Onde a "separação" ocorre efetivamente.
	awk -v qtde_awk=$qtde -v passos_awk="$passos" '
		BEGIN {
			tamanho = length(qtde_awk)

			qtde_passos = split(passos_awk, passo, ",")
			if (qtde_passos < qtde_awk) {
				ultimo_valor = passo[qtde_passos]
				for (i = qtde_passos + 1; i <= qtde_awk; i++) {
					passo[i] = ultimo_valor
				}
			}

			ordem = 1
		}

		{
			if (ordem > qtde_awk)
				ordem = 1

			val_abs = passo[ordem] >= 0 ? passo[ordem] : passo[ordem] * -1

			sufixo = sprintf("%0" tamanho "d", ordem)

			if (passo[ordem] > 0)
				print $0 >> FILENAME "." sufixo

			if (val_abs > 1) {
				for (i = 2; i <= val_abs; i++) {
					if (getline > 0) {
						if (passo[ordem] > 0)
							print $0 >> FILENAME "." sufixo
					}
				}
			}

			ordem++
		}
	' "$1"
}
