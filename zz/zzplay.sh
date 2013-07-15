# ----------------------------------------------------------------------------
# Toca o arquivo de audio, escolhendo o player mais adequado instalado.
#
# Uso: zzplay <audio1> [audio2] ...
# Ex.: zzplay os_seminovos_escolha_ja_seu_nerd.mp3 
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-13
# Versão: 1
# Licença: GPL
# Requisitos: zzextensao zzminusculas
# ----------------------------------------------------------------------------
zzplay ()
{
	zzzz -h play "$1" && return

	local tipo play_cmd player

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso play; return 1; }

	while [ "$1" ]
	do
		tipo=$(zzextensao "$1" | zzminusculas)

		# Para cada tipo de arquivo de audio, seleciona o player disponivel
		case $tipo in
		wav | au | aiff )
			for play_cmd in play mplayer cvlc
			do
				if type $play_cmd >/dev/null 2>&1
				then
					player="$play_cmd"
					break
				fi
			done
		;;
		mp2 | mp3 )
			for play_cmd in mpg321 mpg123 mplayer cvlc
			do
				if type $play_cmd >/dev/null 2>&1
				then
					player="$play_cmd"
					break
				fi
			done
		;;
		ogg )
			for play_cmd in ogg123 mplayer cvlc
			do
				if type $play_cmd >/dev/null 2>&1
				then
					player="$play_cmd"
					break
				fi
			done
		;;
		aac | wma | mka )
			for play_cmd in mplayer cvlc
			do
				if type $play_cmd >/dev/null 2>&1
				then
					player="$play_cmd"
					break
				fi
			done
		;;
		esac

		[ "$player" ] && $player "$1" >/dev/null 2>&1

		shift
	done
}
