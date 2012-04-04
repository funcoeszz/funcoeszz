# ----------------------------------------------------------------------------
# Calculadora.
# Wrapper para o comando bc, que funciona no formato brasileiro: 1.234,56.
# Obs.: Números fracionados podem vir com vírgulas ou pontos: 1,5 ou 1.5.
# Use a opção --soma para somar uma lista de números vindos da STDIN.
#
# Uso: zzcalcula operação|--soma
# Ex.: zzcalcula 2,20 + 3.30          # vírgulas ou pontos, tanto faz
#      zzcalcula '2^2*(4-1)'          # 2 ao quadrado vezes 4 menos 1
#      echo 2 + 2 | zzcalcula         # lendo da entrada padrão (STDIN)
#      zzseq 5 | zzcalcula --soma     # soma números da STDIN
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-05-04
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzcalcula ()
{
	zzzz -h calcula "$1" && return

	local soma

	# Opção de linha de comando
	if test "$1" = '--soma'
	then
		soma=1
		shift
	fi

	# A opção --soma só lê dados da STDIN, não deve ter argumentos
	if test -n "$soma" -a $# -gt 0
	then
		zztool uso calcula
		return 1
	fi

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |

	# Limpeza nos dados para chegarem bem no bc
	sed '
		# Espaços só atrapalham (tab+espaço)
		s/[	 ]//g

		# Remove separador de milhares
		s/\.\([0-9][0-9][0-9]\)/\1/g
		' |

	# Temos dados multilinha para serem somados?
	if test -n "$soma"
	then
		sed '
			# Remove linhas em branco
			/^$/d

			# Números sem sinal são positivos
			s/^[0-9]/+&/

			# Se o primeiro da lista tiver sinal + dá erro no bc
			1 s/^+//' |
		# Junta as linhas num única tripa, exemplo: 5+7-3+1-2
		#tr -d '\n'
		paste -s -d ' ' - | sed 's/ //g'
	else
		cat -
	fi |

	# O resultado deve ter somente duas casas decimais
	sed 's/^/scale=2;/' |

	# Entrada de números com vírgulas ou pontos, saída sempre com vírgulas
	sed y/,/./ | bc | sed y/./,/ |

	# Adiciona separador de milhares
	sed '
		s/\([0-9]\)\([0-9][0-9][0-9]\)$/\1.\2/

		:loop
		s/\([0-9]\)\([0-9][0-9][0-9][,.]\)/\1.\2/
		t loop
	'
}
