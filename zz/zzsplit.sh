# ----------------------------------------------------------------------------
# Separa um arquivo linha a linha alternadamente em 2 ou mais arquivos.
# Usa o mesmo nome do arquivo, colocando sufixo numérico sequencial.
#
# Uso: zzsplit <numero> <arquivo>
# Ex.: zzsplit 3 arq.txt  # Separa em 3: arq.txt.1, arq.txt.2, arq.txt.3
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-11-10
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzsplit ()
{
	zzzz -h split "$1" && return

	local qtde

	[ "$1" ] || { zztool uso split; return 1; }

	# Quantidade de arquivo a serem separados
	zztool testa_numero $1 && test "$1" -gt "1" || { zztool uso split; return 1; }
	qtde=$1

	# Conferindo se arquivo existe e é legível
	zztool arquivo_legivel "$2" || { zztool uso split; return 1; }

	# Onde a "separação" ocorre efetivamente.
	awk -v qtde_awk=$qtde '
		BEGIN { tamanho=length(qtde_awk) }
		{
			ordem = (NR % qtde_awk==0 ? qtde_awk : NR % qtde_awk)
			sufixo = sprintf("%0" tamanho "d", ordem)
			print $0 >> FILENAME "." sufixo
		}
	' "$2"
}
