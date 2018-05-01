# ----------------------------------------------------------------------------
# Converte arquivos texto no formato Unix (LF) para o Windows/DOS (CR+LF).
# Uso: zzunix2dos arquivo(s)
# Ex.: zzunix2dos frases.txt
#      cat arquivo.txt | zzunix2dos
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-02-22
# Versão: 2
# Licença: GPL
# Tags: texto, conversão
# ----------------------------------------------------------------------------
zzunix2dos ()
{
	zzzz -h unix2dos "$1" && return

	local arquivo tmp
	local control_m=$(printf '\r')  # ^M, CR, \r

	# Sem argumentos, lê/grava em STDIN/STDOUT
	if test $# -eq 0
	then
		sed "s/$control_m*$/$control_m/"

		# Facinho, terminou já
		return
	fi

	# Definindo arquivo temporário quando há argumentos.
	tmp=$(zztool mktemp unix2dos)

	# Usuário passou uma lista de arquivos
	# Os arquivos serão sobrescritos, todo cuidado é pouco
	for arquivo
	do
		# O arquivo existe?
		zztool -e arquivo_legivel "$arquivo" || continue

		# Adiciona um único CR no final de cada linha
		cp "$arquivo" "$tmp" &&
		sed "s/$control_m*$/$control_m/" "$tmp" > "$arquivo"

		# Segurança
		if test $? -ne 0
		then
			zztool erro "Ops, algum erro ocorreu em $arquivo"
			zztool erro "Seu arquivo original está guardado em $tmp"
			return 1
		fi

		echo "Convertido $arquivo"
	done

	# Remove o arquivo temporário
	rm -f "$tmp"
}
