# ----------------------------------------------------------------------------
# Preenche um texto para um certo tamanho com outra string.
#
# Opções:
#   -d, -r     Preenche à direita (padrão)
#   -e, -l     Preenche à esquerda
#   -a, -b     Preenche em ambos os lados
#   -x STRING  String de preenchimento (padrão=" ")
#
# Uso: zzpad [-d | -e | -a] [-x STRING] <tamanho> [texto]
# Ex.: zzpad -x 'NO' 21 foo     # fooNONONONONONONONONO
#      zzpad -a -x '_' 9 foo    # ___foo___
#      zzpad -d -x '♥' 9 foo    # foo♥♥♥♥♥♥
#      zzpad -e -x '0' 9 123    # 000000123
#      cat arquivo.txt | zzpad -x '_' 99
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-05-18
# Versão: 5
# Licença: GPL
# Tags: texto, manipulação
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
	if zztool testa_numero "$1" && test "$1" -gt 0
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

	# Escapa caracteres especiais no s/// do sed: \ / &
	str_pad=$(echo "$str_pad" | sed 's,\\,\\\\,g; s,/,\\/,g; s,&,\\&,g')

	zztool multi_stdin "$@" |
		zztool nl_eof |
		case "$posicao" in
			l) sed -e ':loop'	-e "/^.\{$largura\}/ b" -e "s/^/$str_pad/" -e 'b loop';;
			r) sed -e ':loop'	-e "/^.\{$largura\}/ b" -e "s/$/$str_pad/" -e 'b loop';;
			b) sed -e ':loop'	-e "/^.\{$largura\}/ b" -e "s/$/$str_pad/" \
								-e "/^.\{$largura\}/ b" -e "s/^/$str_pad/" -e 'b loop';;
		esac

	### Explicação do algoritmo sed
	# Os três comandos são similares, é um loop que só é quebrado quando o
	# tamanho atual do buffer satisfaz o tamanho desejado ($largura).
	# A cada volta do loop, é adicionado o texto de padding $str_pad antes
	# (s/^/…/) e/ou depois (s/$/…/) do texto atual.
}
