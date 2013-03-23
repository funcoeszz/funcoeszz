# ----------------------------------------------------------------------------
# Exibe a relação dos elementos químicos.
# Pesquisa na Wikipédia se informado o número atômico ou símbolo do elemento.
#
# Uso: zzquimica [número|símbolo]
# Ex.: zzquimica       # Lista de todos os elementos químicos
#      zzquimica He    # Pesquisa o Hélio na Wikipédia
#      zzquimica 12    # Pesquisa o Magnésio na Wikipédia
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-03-22
# Versão: 2
# Licença: GPL
# Requisitos: zzcapitalize zzwikipedia
# ----------------------------------------------------------------------------
zzquimica ()
{

	zzzz -h quimica "$1" && return

	local elemento

	if [ "$1" ]
	then
		if zztool testa_numero "$1"
		then
			# Testando se forneceu o número atômico
			elemento=$(zzquimica | sed -n "/^ $1 /p" | awk '{ print $2 }')
		else
			# Ou se forneceu o símbolo do elemento químico
			elemento=$(zzquimica | awk '{ if ($3 == "'$(zzcapitalize "$1")'") print $2 }')
		fi

		# Se encontrado, pesquisa-o na wikipedia
		[ ${#elemento} -gt 0 ] && zzwikipedia "$elemento" || { zztool uso quimica; return 1; }

	else
		# Lista todos os elementos químicos
		$ZZWWWHTML "http://ptable.com/?lang=pt" | sed -n '/"Element /p' |
		sed '
			s|</*acronym[^>]*>||g
			s|</*a[^>]*>||g
			s|</*big[^>]*>||g
			s|</*em[^>]*>||g
			s|</*i[^>]*>||g
			s|</*strong[^>]*>||g
			s|</*td[^>]*>||g' |
		sed 's|</*small>| |g;s/<br>/-/g' | sort -n |
		awk '
			BEGIN {print " N.º       Nome      Símbolo    Massa    Orbital" }
			{printf " %-5s %-15s %-7s %-12s %s\n", $1, $3, $2, $4, $5}
		'
	fi
}
