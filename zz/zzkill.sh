# ----------------------------------------------------------------------------
# Mata processos pelo nome do seu comando de origem.
# Com a opção -n, apenas mostra o que será feito, mas não executa.
# Se nenhum argumento for informado, mostra a lista de processos ativos.
# Uso: zzkill [-n] [comando [comando2 ...]]
# Ex.: zzkill
#      zzkill netscape
#      zzkill netsc soffice startx
#
# Autor: Ademar de Souza Reis Jr.
# Desde: 2000-05-15
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzkill ()
{
	zzzz -h kill "$1" && return

	local nao comandos comando processos pid chamada

	# Opções de linha de comando
	if [ "$1" = '-n' ]
	then
		nao='[-n]\t'
		shift
	fi

	while :
	do
		comando="$1"

		# Tenta obter a lista de processos nos formatos Linux e BSD
		processos=$(ps xw --format pid,comm 2>/dev/null) ||
		processos=$(ps xw -o pid,command 2>/dev/null)

		# Diga não ao suicídio
		processos=$(echo "$processos" | grep -vw '\(zz\)*kill')

		# Sem argumentos, apenas mostra a listagem e sai
		if ! [ "$1" ]
		then
			echo "$processos"
			return 0
		fi

		# Filtra a lista, extraindo e matando os PIDs
		echo "$processos" |
			grep -i "$comando" |
			while read pid chamada
			do
				echo -e "$nao$pid\t$chamada"
				[ "$nao" ] || kill $pid
			done

		# Próximo da fila!
		shift
		[ "$1" ] || break
	done
}
