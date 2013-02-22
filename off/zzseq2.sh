# ----------------------------------------------------------------------------
# Mostra uma seqüência numérica, um número por linha.
# Obs.: Emulação do comando seq, presente no Linux, com melhorias adicionais.
# Uso: zzseq2 [número-inicial [step]] número-final [prefixo [sufixo]]
# Ex.: zzseq2 5
#      zzseq2 10 2 5 "Numero " ")"
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2009-10-04
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2010-12-21 Funcionalidades implementadas na zzseq original.
zzseq2 ()
{
	zzzz -h seq2 $1 && return

	local inicio=1
	local fim=$1
	local step=1
	local saida prefixo sufixo

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso seq2; return; }
	
	# Se houver dois números, vai "do primeiro ao segundo"
	[ "$2" ] && inicio=$1 fim=$2
	
	# Se houver três números, vai "do primeiro ao segundo em saltos"
	[ "$3" ] && inicio=$1 fim=$3 step=$2

	# Se houver um quarto arqumento é tratado como prefixo
	[ "$4" ] && prefixo="$4"

	# Se houver um quito arqumento é tratado como sufixo
	[ "$5" ] && sufixo="$5"
	
	# Verificações básicas
	if ! (zztool testa_numero_sinal "$inicio" &&
	      zztool testa_numero_sinal "$fim" &&
	      zztool testa_numero_sinal "$step")
	then
		zztool uso seq2
		return
	fi
	
	# Se o primeiro for maior que o segundo, a contagem é regressiva
	if ([ $inicio -gt $fim ])
	then
		for ((saida=$inicio;saida>=$fim;saida-=$step))
		do
			echo ${prefixo}${saida}${sufixo}
		done
	else
		for ((saida=$inicio;saida<=$fim;saida+=$step))
		do
			echo ${prefixo}${saida}${sufixo}
		done
	fi
}
