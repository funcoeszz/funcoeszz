# ----------------------------------------------------------------------------
# Desordena as linhas de um texto (ordem aleatória).
# Uso: zzshuffle [arquivo(s)]
# Ex.: zzshuffle /etc/passwd         # desordena o arquivo de usuários
#      cat /etc/passwd | zzshuffle   # o arquivo pode vir da entrada padrão
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-06-19
# Versão: 1
# Requisitos: zzzz zztool zzaleatorio
# Tags: shuffle, emulação
# ----------------------------------------------------------------------------
zzshuffle ()
{
	zzzz -h shuffle "$1" && return

	local linha

	# Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" |

		# Um número aleatório é colocado no início de cada linha,
		# depois o sort ordena numericamente, bagunçando a ordem
		# original. Então os números são removidos.
		while read -r linha
		do
			echo "$(zzaleatorio) $linha"
		done |
		sort |
		cut -d ' ' -f 2-
}
