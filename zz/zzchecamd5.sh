# ----------------------------------------------------------------------------
# Checa o md5sum de arquivos baixados da net.
# Nota: A função checa o arquivo no diretório corrente (./)
# Uso: zzchecamd5 arquivo md5sum
# Ex.: zzchecamd5 ./ubuntu-8.10.iso f9e0494e91abb2de4929ef6e957f7753
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-10-31
# Versão: 3
# Licença: GPLv2
# Requisitos: zzmd5
# Tags: arquivo, consulta
# ----------------------------------------------------------------------------
zzchecamd5 ()
{

	# Variaveis locais
	local arquivo valor_md5 md5_site

	# Help da funcao zzchecamd5
	zzzz -h checamd5 "$1" && return

	# Faltou argumento mostrar como se usa a zzchecamd5
	if test $# != "2";then
		zztool -e uso checamd5
		return 1
	fi

	# Foi passado o caminho errado do arquivo
	if test ! -f $1 ;then
		zztool erro "Nao foi encontrado: $1"
		return 1
	fi

	# Setando variaveis
	arquivo=./$1
	md5_site=$2
	valor_md5=$(cat "$arquivo" | zzmd5)

	# Verifica se o arquivo nao foi corrompido
	if test "$md5_site" = "$valor_md5"; then
		echo "Imagem OK"
	else
		zztool erro "O md5sum nao confere!!"
		return 1
	fi
}
