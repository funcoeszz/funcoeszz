# ----------------------------------------------------------------------------
# Inverte a ordem das linhas, mostrando da última até a primeira.
# É uma emulação (portável) do comando tac, presente no Linux.
#
# Uso: zztac [arquivos]
# Ex.: zztac /etc/passwd
#      zztac arquivo.txt outro.txt
#      cat /etc/passwd | zztac
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2013-02-24
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zztac ()
{
	zzzz -h tac "$1" && return

	# Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" | sed '1!G;h;$!d'

	# Explicação do sed:
	#   A versão simplificada dele é: G;h;d. Esta sequência de comandos
	#   vai empilhando as linhas na ordem inversa no buffer reserva.
	#
	# Supondo o arquivo:
	#   um
	#   dois
	#   três
	#
	# Funcionará assim:
	#                            [principal]            [reserva]
	# --------------------------------------------------------------
	#   Lê a linha 1             um
	#   h                        um                     um
	#   d                                               um
	#   Lê a linha 2             dois
	#   G                        dois\num
	#   h                        dois\num               dois\num
	#   d                                               dois\num
	#   Lê a linha 3             três
	#   h                        três\ndois\num         dois\num
	#   FIM DO ARQUIVO
	#   Mostra o conteúdo do [principal], as linhas invertidas.
}
