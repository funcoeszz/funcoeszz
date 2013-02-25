# ----------------------------------------------------------------------------
# Acha as funções de uma biblioteca da linguagem C (arquivos .h).
# Obs.: O diretório padrão de procura é o /usr/include.
# Uso: zzcinclude nome-biblioteca
# Ex.: zzcinclude stdio
#      zzcinclude /minha/rota/alternativa/stdio.h
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-12-15
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzcinclude ()
{
	zzzz -h cinclude "$1" && return

	local arquivo="$1"

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso cinclude; return 1; }

	# Se não começar com / (caminho relativo), coloca path padrão
	[ "${arquivo#/}" = "$arquivo" ] && arquivo="/usr/include/$arquivo.h"

	# Verifica se o arquivo existe
	zztool arquivo_legivel "$arquivo" || return

	# Saída ordenada, com um Sed mágico para limpar a saída do cpp
	cpp -E "$arquivo" |
		sed '
			/^ *$/d
			/^# /d
			/^typedef/d
			/^[^a-z]/d
			s/ *(.*//
			s/.* \*\{0,1\}//' |
		sort
}
