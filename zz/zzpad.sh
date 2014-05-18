# ----------------------------------------------------------------------------
# Preenche um texto para um certo tamanho com outra string.
# Pode-se especificar a posição a ser preenchida com os seguintes argumentos:
#  -l ou -e : Preenche a esquerda
#  -r ou -d : Preenche a direita (padrão)
#  -b ou -a : Preenche em ambos os lados
#
# Minimamente é necessário fornecer um número inteiro positivo como tamanho.
#
# Se não for definida a string, adota-se um simples espaço " ".
#
# Uso: zzpad [-l|-e|-r|-d|-b|-a] <número> [string] texto
# Ex.: zzpad 35 "xyz" "Teste"
#      zzpad -a 12 "a" "Teste"
#      echo Teste | zzpad -l 20 "abc"
#      cat arquivo.txt | zzpad 50 "ou"
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-05-18
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzpad ()
{
	zzzz -h pad "$1" && return

	local posicao='r'
	local largura str_pad

	# Opções da posição do padding (left, right, both | esquerda, direita, ambos)
	while test "${1#-}" != "$1"
	do
		case "$1" in
		-l | -e) posicao='l' ;;
		-r | -d) posicao='r' ;;
		-b | -a) posicao='b' ;;
		-*) zztool eco "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
		shift
	done

	# Tamanho da string
	if zztool testa_numero "$1" && test $1 -gt 0
	then
		largura="$1"
	else
		zztool uso pad
		return 1
	fi

	# Caracteres a serem usados no padding
	if test -n "$2"
	then
		str_pad="$2"
		shift
		shift
	else
		str_pad=" "
		shift
	fi

	zztool multi_stdin "$@" |
	awk -v awk_larg=$largura -v awk_pad="$str_pad" -v awk_pos=$posicao '
		function repetir(texto, tamanho, sentido) {
			if (length(texto) > 0) {
				if (sentido == 1) {
					tamanho = tamanho + (int(tamanho) == tamanho ? 0 : 1)
				}
				while (length(texto) < tamanho ) {
					texto = texto texto
				}
				return substr(texto, 1, tamanho)
			}
		}
		{
			if (length < awk_larg) {
				if (awk_pos == "r") { print $0 repetir(awk_pad, awk_larg - length, 0) }
				if (awk_pos == "l") { print repetir(awk_pad, awk_larg - length, 0) $0 }
				if (awk_pos == "b") {
					print repetir(awk_pad, (awk_larg - length)/2, 0) $0 repetir(awk_pad, (awk_larg - length)/2, 1)
				}
			}
			else { print }
		}
	'
}
