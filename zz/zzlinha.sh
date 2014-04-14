# ----------------------------------------------------------------------------
# Mostra uma linha de um texto, aleatória ou informada pelo número.
# Obs.: Se passado um argumento, restringe o sorteio às linhas com o padrão.
# Uso: zzlinha [número | -t texto] [arquivo(s)]
# Ex.: zzlinha /etc/passwd           # mostra uma linha qualquer, aleatória
#      zzlinha 9 /etc/passwd         # mostra a linha 9 do arquivo
#      zzlinha -2 /etc/passwd        # mostra a penúltima linha do arquivo
#      zzlinha -t root /etc/passwd   # mostra uma das linhas com "root"
#      cat /etc/passwd | zzlinha     # o arquivo pode vir da entrada padrão
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2004-12-23
# Versão: 2
# Licença: GPL
# Requisitos: zzaleatorio
# ----------------------------------------------------------------------------
zzlinha ()
{
	zzzz -h linha "$1" && return

	local arquivo n padrao resultado num_linhas

	# Opções de linha de comando
	if [ "$1" = '-t' ]
	then
		padrao="$2"
		shift
		shift
	fi

	# Talvez o $1 é o número da linha desejada?
	if zztool testa_numero_sinal "$1"
	then
		n="$1"
		shift
	fi

	# Se informado um ou mais arquivos, eles existem?
	for arquivo in "$@"
	do
		zztool arquivo_legivel "$arquivo" || return 1
	done

	if [ "$n" ]
	then
		# Se foi informado um número, mostra essa linha.
		# Nota: Suporte a múltiplos arquivos ou entrada padrão (STDIN)
		for arquivo in "${@:--}"
		do
			# Usando cat para ler do arquivo ou da STDIN
			cat "$arquivo" |
				if [ "$n" -lt 0 ]
				then
					tail -n "${n#-}" | sed 1q
				else
					sed -n "${n}p"
				fi
		done
	else
		# Se foi informado um padrão (ou nenhum argumento),
		# primeiro grepa as linhas, depois mostra uma linha
		# aleatória deste resultado.
		# Nota: Arquivos via STDIN ou argumentos
		resultado=$(zztool file_stdin "$@" | grep -h -i -- "${padrao:-.}")
		num_linhas=$(echo "$resultado" | sed -n '$=')
		n=$(zzaleatorio 1 $num_linhas)
		echo "$resultado" | sed -n "${n}p"
	fi
}
