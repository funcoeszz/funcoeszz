# ----------------------------------------------------------------------------
# Vira um texto, de trás pra frente (rev) ou de ponta-cabeça.
# Ideia original de: http://www.revfad.com/flip.html (valeu @andersonrizada)
#
# Uso: zzvira [-X|-E] texto
# Ex.: zzvira Inverte tudo             # odut etrevnI
#      zzvira -X De pernas pro ar      # ɹɐ oɹd sɐuɹǝd ǝp
#      zzvira -E De pernas pro ar      # pǝ dǝɹuɐs dɹo ɐɹ
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2010-05-24
# Versão: 3
# Licença: GPL
# Requisitos: zzsemacento zzminusculas
# Tags: rev, emulação
# ----------------------------------------------------------------------------
zzvira ()
{
	zzzz -h vira "$1" && return

	local rasteira

	if test '-X' = "$1"
	then
		rasteira=1
		shift
	elif test '-E' = "$1"
	then
		rasteira=2
		shift
	fi

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |

	# Vira o texto de trás pra frente (rev)
	if test -z "$rasteira" || test "$rasteira" -ne 2
	then
		sed '
		/\n/!G
		s/\(.\)\(.*\n\)/&\2\1/
		//D
		s/.//'
	else
		cat -
	fi |

	if test -n "$rasteira"
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
