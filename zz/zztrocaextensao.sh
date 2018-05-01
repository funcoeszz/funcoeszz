# ----------------------------------------------------------------------------
# Troca a extensão dos arquivos especificados.
# Com a opção -n, apenas mostra o que será feito, mas não executa.
# Uso: zztrocaextensao [-n] antiga nova arquivo(s)
# Ex.: zztrocaextensao -n .doc .txt *          # tire o -n para renomear!
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-05-15
# Versão: 1
# Licença: GPL
# Tags: arquivo, manipulação
# ----------------------------------------------------------------------------
zztrocaextensao ()
{
	zzzz -h trocaextensao "$1" && return

	local ext1 ext2 arquivo base novo nao

	# Opções de linha de comando
	if test '-n' = "$1"
	then
		nao='[-n] '
		shift
	fi

	# Verificação dos parâmetros
	test -n "$3" || { zztool -e uso trocaextensao; return 1; }

	# Guarda as extensões informadas
	ext1="$1"
	ext2="$2"
	shift; shift

	# Tiro no pé? Não, obrigado
	test "$ext1" = "$ext2" && return

	# Para cada arquivo que o usuário informou...
	for arquivo
	do
		# O arquivo existe?
		zztool -e arquivo_legivel "$arquivo" || continue

		base="${arquivo%$ext1}"
		novo="$base$ext2"

		# Testa se o arquivo possui a extensão antiga
		test "$base" != "$arquivo" || continue

		# Mostra o que será feito
		echo "$nao$arquivo -> $novo"

		# Se não tiver -n, vamos renomear o arquivo
		if test ! -n "$nao"
		then
			# Não sobrescreve arquivos já existentes
			zztool -e arquivo_vago "$novo" || return

			# Vamos lá
			mv -- "$arquivo" "$novo"
		fi
	done
}
