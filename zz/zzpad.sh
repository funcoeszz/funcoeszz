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
# Uso: zzpad [-l|-e|-r|-d|-b|-a] [-x PADDING] <número> texto
# Ex.: zzpad -x "xyz" 32 "Teste"          # Testexyzxyzxyzxyzxyzxyzxyzxyzxyz
#      zzpad -a -x "a" 12 "Teste"         # aaaTesteaaaa
#      echo Teste | zzpad -l -x "abc" 20  # abcabcabcabcabcTeste
#      cat arquivo.txt | zzpad -x "ou" 50
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-05-18
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zzpad ()
{
	zzzz -h pad "$1" && return

	local largura
	local posicao='r'
	local str_pad=' '

	# Opções da posição do padding (left, right, both | esquerda, direita, ambos)
	while test "${1#-}" != "$1"
	do
		case "$1" in
		-l | -e) posicao='l'; shift ;;
		-r | -d) posicao='r'; shift ;;
		-b | -a) posicao='b'; shift ;;
		-x     ) str_pad="$2"; shift; shift ;;
		-*) zztool erro "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
	done

	# Tamanho da string
	if zztool testa_numero "$1" && test $1 -gt 0
	then
		largura="$1"
		shift
	else
		zztool -e uso pad
		return 1
	fi

	if test -z "$str_pad"
	then
		zztool erro "A string de preenchimento está vazia"
		return 1
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
