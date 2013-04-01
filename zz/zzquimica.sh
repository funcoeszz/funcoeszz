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
# Versão: 3
# Licença: GPL
# Requisitos: zzcapitalize zzwikipedia
# ----------------------------------------------------------------------------
zzquimica ()
{

	zzzz -h quimica "$1" && return

	local elemento
	local cache="$ZZTMP.quimica"

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWHTML "http://ptable.com/?lang=pt" |
		sed -n '/"Element /p' |
		sed 's|</*small>| |g;s/<br>/-/g;s/ *<td class="Element \{1,\}//g;s/ \{1,\}[spdf]">/:/g' |
		sed 's/\(.*\):\(.*\)/\2 (\1)/g' |
		sed 's/<[^>]*>//g' | sort -n |
		sed '
			s/(Alkaline/(Metal_Alcalino-Terroso/g
			s/(Alkali/(Metal_Alcalino/g
			s/(Transition/(Metal_de_Transição/g
			s/(Poor/(Metal_Representativo/g
			s/(Metalloid/(Semi-metal/g
			s/(Nonmetal/(Não-Metal/g
			s/(Halogen/(Halogênio/g
			s/(Noble/(Gás_Nobre/g
			s/ Boron)/_[Família_do_Boro])/g
			s/ Carbon)/_[Família_do_Carbono])/g
			s/ Pnictogen)/_[Família_do_Nitrogênio])/g
			s/ Chalcogen)/_[Calcogênio])/g
			s/(Lanthanoid/(Lantanídeo/g
			s/(Actinoid/(Actinídeo/g
			' |
		awk '
			BEGIN {print " N.º       Nome      Símbolo    Massa      Orbital             Classificação" }
			{printf " %-5s %-15s %-7s %-12s %-18s %s\n", $1, $3, $2, $4, $5, $6}
		' > "$cache"
	fi

	if [ "$1" ]
	then
		if zztool testa_numero "$1"
		then
			# Testando se forneceu o número atômico
			elemento=$(sed -n "/^ $1 /p" "$cache" | awk '{ print $2 }')
		else
			# Ou se forneceu o símbolo do elemento químico
			elemento=$(awk '{ if ($3 == "'$(zzcapitalize "$1")'") print $2 }' "$cache")
		fi

		# Se encontrado, pesquisa-o na wikipedia
		if [ ${#elemento} -gt 0 ]
		then
			[ "$elemento" = "Rádio" -o "$elemento" = "Índio" ] && elemento="${elemento}_(elemento_químico)"
			zzwikipedia "$elemento"
		else
			zztool uso quimica
			return 1
		fi

	else
		# Lista todos os elementos químicos
		cat "$cache" | tr '_' ' '
	fi
}
