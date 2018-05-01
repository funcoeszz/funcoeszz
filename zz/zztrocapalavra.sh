# ----------------------------------------------------------------------------
# Troca uma palavra por outra, nos arquivos especificados.
# Obs.: Além de palavras, é possível usar expressões regulares.
# Uso: zztrocapalavra antiga nova arquivo(s)
# Ex.: zztrocapalavra excessão exceção *.txt
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-05-04
# Versão: 2
# Licença: GPL
# Tags: texto, conversão
# ----------------------------------------------------------------------------
zztrocapalavra ()
{
	zzzz -h trocapalavra "$1" && return

	local arquivo antiga_escapada nova_escapada
	local antiga="$1"
	local nova="$2"

	# Precisa do temporário pois nem todos os Sed possuem a opção -i
	local tmp=$(zztool mktemp trocapalavra)

	# Verificação dos parâmetros
	test -n "$3" || { zztool -e uso trocapalavra; return 1; }

	# Escapando a barra "/" dentro dos textos de pesquisa
	antiga_escapada=$(echo "$antiga" | sed 's,/,\\/,g')
	nova_escapada=$(  echo "$nova"   | sed 's,/,\\/,g')

	shift; shift

	# Para cada arquivo que o usuário informou...
	for arquivo
	do
		# O arquivo existe?
		zztool -e arquivo_legivel "$arquivo" || continue

		# Um teste rápido para saber se o arquivo tem a palavra antiga,
		# evitando gravar o temporário desnecessariamente
		grep "$antiga" "$arquivo" >/dev/null 2>&1 || continue

		# Uma seqüência encadeada de comandos para garantir que está OK
		cp "$arquivo" "$tmp" &&
		sed "s/$antiga_escapada/$nova_escapada/g" "$tmp" > "$arquivo" && {
			echo "Feito $arquivo" # Está retornando 1 :/
			continue
		}

		# Em caso de erro, recupera o conteúdo original
		zztool erro "Ops, deu algum erro no arquivo $arquivo"
		zztool erro "Uma cópia dele está em $tmp"
		cat "$tmp" > "$arquivo"
		return 1
	done
	rm -f "$tmp"
}
