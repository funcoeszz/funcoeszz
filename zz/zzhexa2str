# ----------------------------------------------------------------------------
# Converte os bytes em hexadecimal para a string equivalente.
# Uso: zzhexa2str [bytes]
# Ex.: zzhexa2str 40 4d 65 6e 74 65 42 69 6e 61 72 69 61   # sem prefixo
#      zzhexa2str 0x42 0x69 0x6E                           # com prefixo 0x
#      echo 0x42 0x69 0x6E | zzhexa2str
#
# Autor: Fernando Mercês <fernando (a) mentebinaria.com.br>
# Desde: 2012-02-24
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzhexa2str ()
{
	zzzz -h hexa2str "$1" && return

	local hexa

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |

		# Um hexa por linha
		tr -s '\t ' '\n' |

		# Remove o prefixo opcional
		sed 's/^0x//' |

		# hexa -> str
		while read hexa
		do
			printf "\\x$hexa"
		done

	# Quebra de linha final
	echo
}
