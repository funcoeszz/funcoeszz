# ----------------------------------------------------------------------------
# Protetor de tela (Screen Saver) para console, com cores e temas.
# Temas: mosaico, espaco, olho, aviao, jacare, alien, rosa, peixe, siri.
# Obs.: Aperte Ctrl+C para sair.
# Uso: zzss [--rapido|--fundo] [--tema <tema>] [texto]
# Ex.: zzss
#      zzss fui ao banheiro
#      zzss --rapido /
#      zzss --fundo --tema peixe
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2003-06-12
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzss ()
{
	zzzz -h ss "$1" && return

	local mensagem tamanho_mensagem mensagem_colorida
	local cor_fixo cor_muda negrito codigo_cores fundo
	local linha coluna dimensoes
	local linhas=25
	local colunas=80
	local tema='mosaico'
	local pausa=1

	local temas='
		mosaico	#
		espaco	.
		olho	00
		aviao	--o-0-o--
		jacare	==*-,,--,,--
		alien	/-=-\\
		rosa	--/--\-<@
		peixe	>-)))-D
		siri	(_).-=''=-.(_)
	'

	# Tenta obter as dimensões atuais da tela/janela
	dimensoes=$(stty size 2>/dev/null)
	if [ "$dimensoes" ]
	then
		linhas=${dimensoes% *}
		colunas=${dimensoes#* }
	fi

	# Opções de linha de comando
	while [ $# -ge 1 ]
	do
		case "$1" in
			--fundo)
				fundo=1
			;;
			--rapido)
				unset pausa
			;;
			--tema)
				[ "$2" ] || { zztool uso ss; return 1; }
				tema=$2
				shift
			;;
			*)
				mensagem="$*"
				unset tema
				break
			;;
		esac
		shift
	done

	# Extrai a mensagem (desenho) do tema escolhido
	if [ "$tema" ]
	then
		mensagem=$(
			echo "$temas" |
				grep -w "$tema" |
				zztool trim |
				cut -f2
		)

		if ! [ "$mensagem" ]
		then
			echo "Tema desconhecido '$tema'"
			return 1
		fi
	fi

	# O 'mosaico' é um tema especial que precisa de ajustes
	if [ "$tema" = 'mosaico' ]
	then
		# Configurações para mostrar retângulos coloridos frenéticos
		mensagem=' '
		fundo=1
		unset pausa
	fi

	# Define se a parte fixa do código de cores será fundo ou frente
	if [ "$fundo" ]
	then
		cor_fixo='30;4'
	else
		cor_fixo='40;3'
	fi

	# Então vamos começar, primeiro limpando a tela
	clear

	# O 'trap' mapeia o Ctrl-C para sair do Screen Saver
	( trap "clear;return" 2

	tamanho_mensagem=${#mensagem}

	while :
	do
		# Posiciona o cursor em um ponto qualquer (aleatório) da tela (X,Y)
		# Detalhe: A mensagem sempre cabe inteira na tela ($coluna)
		linha=$((RANDOM % linhas + 1))
		coluna=$((RANDOM % (colunas - tamanho_mensagem + 1) + 1))
		printf "\033[$linha;${coluna}H"

		# Escolhe uma cor aleatória para a mensagem (ou o fundo): 1 - 7
		cor_muda=$((RANDOM % 7 + 1))

		# Usar negrito ou não também é escolhido ao acaso: 0 - 1
		negrito=$((RANDOM % 2))

		# Podemos usar cores ou não?
		if [ "$ZZCOR" = 1 ]
		then
			codigo_cores="$negrito;$cor_fixo$cor_muda"
			mensagem_colorida="\033[${codigo_cores}m$mensagem\033[m"
		else
			mensagem_colorida="$mensagem"
		fi

		# Mostra a mensagem/desenho na tela e (talvez) espera 1s
		printf "$mensagem_colorida"
		${pausa:+sleep 1}
	done )
}
