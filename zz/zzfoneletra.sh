# ----------------------------------------------------------------------------
# Conversão de telefones contendo letras para apenas números.
# Uso: zzfoneletra telefone
# Ex.: zzfoneletra 2345-LINUX              # Retorna 2345-54689
#      echo 5555-HELP | zzfoneletra        # Retorna 5555-4357
#
# Autor: Rodolfo de Faria <rodolfo faria (a) fujifilm com br>
# Desde: 2006-10-17
# Versão: 1
# Licença: GPL
# Requisitos: zzmaiusculas
# ----------------------------------------------------------------------------
zzfoneletra ()
{
	zzzz -h foneletra "$1" && return

	# Dados via STDIN ou argumentos
	zztool multi_stdin "$@" |
		zzmaiusculas |
		sed y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/22233344455566677778889999/
		# Um Sed faz tudo, é uma tradução letra a letra
}
