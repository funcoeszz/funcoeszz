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
# Versão: 2
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
		-*) zztool erro "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
		shift
	done

	# Tamanho da string
	if zztool testa_numero "$1" && test $1 -gt 0
	then
		largura="$1"
	else
		zztool -e uso pad
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
		zztool nl_eof |
		case "$posicao" in
			l) sed -e ':loop' -e "/^.\{$largura\}/ b" -e "s/^/$str_pad/" -e 'b loop';;
			r) sed -e ':loop' -e "/^.\{$largura\}/ b" -e "s/$/$str_pad/" -e 'b loop';;
			b) sed -e ':loop' -e "/^.\{$largura\}/ b" -e "s/$/$str_pad/" \
			                  -e "/^.\{$largura\}/ b" -e "s/^/$str_pad/" -e 'b loop';;
		esac

	### Explicação do algoritmo sed
	# Os três comandos são similares, é um loop que só é quebrado quando o
	# tamanho atual do buffer satisfaz o tamanho desejado ($largura).
	# A cada volta do loop, é adicionado o texto de padding $str_pad antes
	# (s/^/…/) e/ou depois (s/$/…/) do texto atual.
}
