# ----------------------------------------------------------------------------
# Calcula o código MD5 dos arquivos informados, ou de um texto via STDIN.
# Obs.: Wrapper portável para os comandos md5 (Mac) e md5sum (Linux).
#
# Uso: zzmd5 [arquivo(s)]
# Ex.: zzmd5 arquivo.txt
#      cat arquivo.txt | zzmd5
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-06
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzmd5 ()
{
	zzzz -h md5 "$1" && return

	local tab=$(printf '\t')

	# Testa se o comando existe
	if type md5 >/dev/null 2>&1
	then
		comando="md5"

	elif type md5sum >/dev/null 2>&1
	then
		comando="md5sum"
	else
		echo "Erro: Não encontrei um comando para cálculo MD5 em seu sistema"
		return 1
	fi


	##### Diferenças na saída dos comandos
	###
	### $comando_md5 /a/www/favicon.*
	#
	# Linux (separador é 2 espaços):
	# d41d8cd98f00b204e9800998ecf8427e  /a/www/favicon.gif
	# 902591ef89dbe5663dc7ae44a5e3e27a  /a/www/favicon.ico
	#
	# Mac:
	# MD5 (/a/www/favicon.gif) = d41d8cd98f00b204e9800998ecf8427e
	# MD5 (/a/www/favicon.ico) = 902591ef89dbe5663dc7ae44a5e3e27a
	#
	# zzmd5 (separador é Tab):
	# d41d8cd98f00b204e9800998ecf8427e	/a/www/favicon.gif
	# 902591ef89dbe5663dc7ae44a5e3e27a	/a/www/favicon.ico
	#
	###
	### echo abcdef | $comando_md5
	#
	# Linux:
	# 5ab557c937e38f15291c04b7e99544ad  -
	#
	# Mac:
	# 5ab557c937e38f15291c04b7e99544ad
	#
	# zzmd5:
	# 5ab557c937e38f15291c04b7e99544ad
	#
	###
	### CONCLUSÃO
	### A zzmd5 usa o formato do Mac quando o texto vem pela STDIN,
	### que é mostrar somente o hash e mais nada. Já quando os arquivos
	### são informados via argumentos na linha de comando, a zzmd5 usa
	### um formato parecido com o do Linux, com o hash primeiro e depois
	### o nome do arquivo. A diferença é no separador: um Tab em vez de
	### dois espaços em branco.
	###
	### Considero que a saída da zzmd5 é a mais limpa e fácil de extrair
	### os dados usando ferramentas Unix.


	# Executa o comando do cálculo MD5 e formata a saída conforme
	# explicado no comentário anterior: HASH ou HASH-Tab-Arquivo
	$comando "$@" |
		sed "
			# Mac
			s/^MD5 (\(.*\)) = \(.*\)$/\2$tab\1/

			# Linux
			s/^\([0-9a-f]\{1,\}\)  -$/\1/
			s/^\([0-9a-f]\{1,\}\)  \(.*\)$/\1$tab\2/
		"
}
