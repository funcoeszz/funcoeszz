# ----------------------------------------------------------------------------
# Muda aleatoriamente o background do GNOME.
# A opção -l faz o script entrar em loop.
# ATENÇÃO: o caminho deve conter a última / para que funcione:
#   /wallpaper/ <- funciona
#   /wallpaper  <- não funciona
#
# Uso: zzrandbackground -l <caminho_wallpapers> <segundo>
# Ex.: zzrandbackground /media/wallpaper/
#      zzrandbackground -l /media/wallpaper/ 5
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-12-12
# Versão: 1
# Licença: GPLv2
# Requisitos: zzshuffle gconftool
# ----------------------------------------------------------------------------
zzrandbackground ()
{

	zzzz -h randbackground "$1" && return

	local caminho tempo papeisdeparede background
	local opcao caminho segundos loop

	# Tratando os parametros
	# foi passado -l
	if [ "$1" = "-l" ];then

		# Tem todos os parametros, caso negativo
		# mostra o uso da funcao
		if [ $# != "3" ]; then
			zztool uso randbackground
			return 1
		fi

		# Ok é loop
		loop=1

		# O caminho é valido, caso negativo
		# mostra o uso da funcao
		if test -d $2; then
			caminho=$2
		else
			zztool uso randbackground
			return 1
		fi

		# A quantidade de segundos é inteira
		# caso negativo mostra o uso da funcao
		if zztool testa_numero $3; then
			segundos=$3
		else
			zztool uso randbackground
			return 1
		fi
	else
		# Caso nao seja passado o -l, só tem o camiho
		# caso negativo mostra o uso da funcao
		if [ $# != "1" ]; then
			zztool uso randbackground
			return 1
		fi

		# O caminho é valido, caso negativo
		# mostra o uso da funcao
		if test -d $2; then
			caminho=$1
		else
			zztool uso randbackground
			return 1
		fi
	fi

	# Ok parametros tratados, vamos pegar
	# as imagens dentro do "$caminho"
	papeisdeparede=$(
				find -L $caminho -type f -exec file {} \; |
				grep -i image |
				cut -d: -f1
			)

	# Agora a execução
	# Foi passado -l, então entra em loop infinito
	if [ "$loop" ];then
		while test "1"
		do
			background=$( echo "$papeisdeparede" |
				zzshuffle |
				head -1
				)
			gconftool-2 --type string --set /desktop/gnome/background/picture_filename "$background"
			sleep $segundos
		done

	# não, não foi passado -l, então só troca 1x.
	else
		background=$( echo "$papeisdeparede" |
				zzshuffle |
				head -1
			)
		gconftool-2 --type string --set /desktop/gnome/background/picture_filename "$background"
	fi
}
