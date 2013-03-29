# ----------------------------------------------------------------------------
# http://www.dict.org
# Busca definições em inglês de palavras da língua inglesa em DICT.org.
# Uso: zzenglish palavra-em-inglês
# Ex.: zzenglish momentum
#
# Autor: Luciano ES
# Desde: 2008-09-07
# Versão: 5
# Licença: GPL
# ----------------------------------------------------------------------------
zzenglish ()
{
	zzzz -h english "$1" && return

	[ "$1" ] || { zztool uso english; return 1; }

	local cinza verde amarelo fecha
	local url="http://www.dict.org/bin/Dict/"
	local query="Form=Dict1&Query=$1&Strategy=*&Database=*&submit=Submit query"

	if [ $ZZCOR -eq 1 ]
	then
		cinza=$(  printf '\033[0;34m')
		verde=$(  printf '\033[0;32;1m')
		amarelo=$(printf '\033[0;33;1m')
		fecha=$(  printf '\033[m')
	fi

	echo "$query" |
		$ZZWWWPOST "$url" |
		sed "
			# pega o trecho da página que nos interessa
			/[0-9]\{1,\} definitions\{0,1\} found/,/_______________/!d
			s/____*//

			# protege os colchetes dos sinônimos contra o cinza escuro
			s/\[syn:/@SINONIMO@/g

			# aplica cinza escuro em todos os colchetes (menos sinônimos)
			s/\[/$cinza[/g

			# aplica verde nos colchetes dos sinônimos
			s/@SINONIMO@/$verde[syn:/g

			# 'fecha' as cores de todos os sinônimos
			s/\]/]$fecha/g

			# # pinta a pronúncia de amarelo - pode estar delimitada por \\ ou //
			s/\\\\[^\\]\{1,\}\\\\/$amarelo&$fecha/g
			s|/[^/]\{1,\}/|$amarelo&$fecha|g

			# cabeçalho para tornar a separação entre várias consultas mais visível no terminal
			/[0-9]\{1,\} definitions\{0,1\} found/ {
				H
				s/.*/==================== DICT.ORG ====================/
				p
				x
			}"
}
