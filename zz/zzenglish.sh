# ----------------------------------------------------------------------------
# http://www.dict.org
# Busca definições em inglês de palavras da língua inglesa em DICT.org.
# Uso: zzenglish palavra-em-inglês
# Ex.: zzenglish momentum
#
# Autor: Luciano ES
# Desde: 2008-09-07
# Versão: 7
# Licença: GPL
# Requisitos: zztrim zzutf8 zzsqueeze
# Tags: internet, dicionário
# ----------------------------------------------------------------------------
zzenglish ()
{
	zzzz -h english "$1" && return

	test -n "$1" || { zztool -e uso english; return 1; }

	local cinza verde amarelo fecha
	local url="http://www.dict.org/bin/Dict?Form=Dict2&Database=*&Query=$1"

	if test 1 -eq $ZZCOR
	then
		cinza=$(  printf '\033[0;34m')
		verde=$(  printf '\033[0;32;1m')
		amarelo=$(printf '\033[0;33;1m')
		fecha=$(  printf '\033[m')
	fi

	zztool dump "$url" | zzutf8 |
		sed "
			/Questions or comments about this site./d

			# pega o trecho da página que nos interessa
			/[0-9]\{1,\} definitions\{0,1\} found/,/ *[_-][_-][_-][_-][_-]* *$/!d
			s/_____*//
			s/-----*//

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
			}" |
		zztrim -V -r |
		zzsqueeze -l
}
