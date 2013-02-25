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
# ----------------------------------------------------------------------------
zztrocaextensao ()
{
	zzzz -h trocaextensao "$1" && return

	local ext1 ext2 arquivo base novo nao

	# Opções de linha de comando
	if [ "$1" = '-n' ]
	then
		nao='[-n] '
		shift
	fi

	# Verificação dos parâmetros
	[ "$3" ] || { zztool uso trocaextensao; return 1; }

	# Guarda as extensões informadas
	ext1="$1"
	ext2="$2"
	shift; shift

	# Tiro no pé? Não, obrigado
	[ "$ext1" = "$ext2" ] && return

	# Para cada arquivo que o usuário informou...
	for arquivo
	do
		# O arquivo existe?
		zztool arquivo_legivel "$arquivo" || continue

		base="${arquivo%$ext1}"
		novo="$base$ext2"

		# Testa se o arquivo possui a extensão antiga
		[ "$base" != "$arquivo" ] || continue

		# Mostra o que será feito
		echo "$nao$arquivo -> $novo"

		# Se não tiver -n, vamos renomear o arquivo
		if [ ! "$nao" ]
		then
			# Não sobrescreve arquivos já existentes
			zztool arquivo_vago "$novo" || return

			# Vamos lá
			mv -- "$arquivo" "$novo"
		fi
	done
}
