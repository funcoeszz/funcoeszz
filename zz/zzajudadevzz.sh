# ----------------------------------------------------------------------------
# Mostra lista colorida de monitoração das funcoeszz desativadas (off/*).
# Obs.: Deverá ser coleção de utilitários para desenvolvedores de funcoeszz.
#
# Uso: zzajudadevzz
# Ex.: zzajudadevzz
#
# Autor: Alexandre Magno <alexandre.mbm (a) gmail com>
# Desde: 2013-07-07
# Versão: 1
# Licença: GPLv2
# ----------------------------------------------------------------------------
zzajudadevzz ()
{
	zzzz -h ajudadevzz "$1" && return
	
	[ $# -ne 0 ] && zztool uso ajudadevzz && return

	local ZZOFFDIR="$ZZDIR/../off"
	
	local grepcores='--color=always'
	local grepcontexto='-C 10000'
	local grepcolorido="grep $grepcores $grepcontexto"
	
	# http://www.debian-administration.org/articles/460

	grep -i '# *DESATIVADA' "$ZZOFFDIR"/zz* | 
		sed -e 's/^[^\/]*\///' -e 's/\.sh[^:]*:[^:]*:/:/' \
			-e 's/^.*\/off\/zz\([^:\/]*\):\(.*\)/\1:\2/' \
			-e 's/^\([^:]*:\) *\([0-9]*-[0-9]*-[0-9]*\)\(.*\)$/\2 \1\3/' |
		sort |
		( export GREP_COLORS='ms=01;37'; $grepcolorido ^[0-9]*-[0-9]*-[0-9]* ) |
		( export GREP_COLORS='ms=01;34'; $grepcolorido [0-9a-zA-Z]*[0-9a-zA-Z]: ) |
		( export GREP_COLORS='ms=00;33'; $grepcolorido [\[\(]' '*issue[s]*' '*\#[0-9]*' '*[\]\)] ) |
		( export GREP_COLORS='ms=00;31'; $grepcolorido \(' '*[0-9]*' '*\) ) |
		less -R

	export GREP_COLORS=

# Abaixo, seguem ideias para essa função.
#
# TODO  1º : transformá-la em zzdevzz, para chamar util/* e outros
#
# TODO  !  : fazer alternativa para NÃO colorir (portabilidade)
#
# TODO     : -c|--criar-nova
# TODO     : -l|--listar-off  (é o que a versão inicial já faz sem escolha)
# TODO     : -n|--nany
# TODO (?) : -t zzfuncao | --testar zzfuncao  (nany + testador)
#
# Atenção! O grep não está considerando metadados defeituosos.
# Nesta versão inicial está pressuposta a sanidade dos metadados. nany!
# O que segue abaixo seriam melhorias fora desta função mas "para ela":
#
# TODO (?) : acrescentar teste em nany para validar o campo DESATIVADA
# TODO (?) : acrescentar campo em metadata.sh

}
