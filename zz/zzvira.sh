# ----------------------------------------------------------------------------
# Vira um texto, de trás pra frente (rev) ou de ponta-cabeça.
# Ideia original de: http://www.revfad.com/flip.html (valeu @andersonrizada)
#
# Uso: zzvira [-X] texto
# Ex.: zzvira Inverte tudo             # odut etrevnI
#      zzvira -X De pernas pro ar      # ɹɐ oɹd sɐuɹǝd ǝp
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2010-05-24
# Versão: 2
# Licença: GPL
# Requisitos: zzsemacento zzminusculas
# ----------------------------------------------------------------------------
zzvira ()
{
	zzzz -h vira "$1" && return

	local rasteira

	if test "$1" = '-X'
	then
		rasteira=1
		shift
	fi

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |

	# Vira o texto de trás pra frente (rev)
	sed '
		/\n/!G
		s/\(.\)\(.*\n\)/&\2\1/
		//D
		s/.//' |

	if [ "$rasteira" ]
	then
		zzsemacento |
		zzminusculas |
			sed 'y@abcdefghijklmnopqrstuvwxyz._!?(){}<>@ɐqɔpǝɟƃɥıɾʞlɯuodbɹsʇnʌʍxʎz˙‾¡¿)(}{><@' |
			sed "y/'/,/" |
			sed 's/\[/X/g ; s/]/[/g ; s/X/]/g'
	else
		cat -
	fi
}
