# ----------------------------------------------------------------------------
# Conta o número de vezes que uma palavra aparece num arquivo.
# Obs.: É diferente do grep -c, que não conta várias palavras na mesma linha.
# Opções: -i  ignora a diferença de maiúsculas/minúsculas
#         -p  busca parcial, conta trechos de palavras
# Uso: zzcontapalavra [-i|-p] palavra arquivo(s)
# Ex.: zzcontapalavra root /etc/passwd
#      zzcontapalavra -i -p a /etc/passwd      # Compare com grep -ci a
#      cat /etc/passwd | zzcontapalavra root
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2003-10-02
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzcontapalavra ()
{
	zzzz -h contapalavra "$1" && return

	local padrao ignora
	local inteira=1

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-p) inteira=  ;;
			-i) ignora=1  ;;
			* ) break     ;;
		esac
		shift
	done

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso contapalavra; return 1; }

	padrao=$1
	shift

	# Contorna a limitação do grep -c pesquisando pela palavra
	# e quebrando o resultado em uma palavra por linha (tr).
	# Então pode-se usar o grep -c para contar.
	# Nota: Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" |
		grep -h ${ignora:+-i} ${inteira:+-w} -- "$padrao" |
		tr '\t./ -,:-@[-_{-~' '\n' |
		grep -c ${ignora:+-i} ${inteira:+-w} -- "$padrao"
}
