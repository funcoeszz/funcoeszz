# ---------------------------------------------------------------------------
# http://developers.agenciaideias.com.br/horoscopo
# Consulta o horóscopo do dia.
# Deve ser informado o signo que se deseja obter a previsão.
# 
# Signos: aquário, peixes, áries, touro, gêmeos, câncer, leão,
#         virgem, libra, escorpião, sagitário, capricórnio
# 
# Uso: zzhoroscopo <signo>
# Ex.: zzhoroscopo sagitário    # exibe a previsão para o signo de sagitário
# 
# Autor: Juliano Fernandes, http://julianofernandes.com.br
# Desde: 2016-05-07
# Versão: 1
# Licença: GPL
# Requisitos: zztrim zzunicode2ascii zzcapitalize
# ---------------------------------------------------------------------------
zzhoroscopo ()
{
	zzzz -h horoscopo "$1" && return

	# Verifica se o usuário informou um possível signo
	if test -z "$1"
	then
		zztool -e uso horoscopo
		return 1
	fi

	# Normaliza o signo para pacilitar sua busca
	local signo=$(zztrim "$1" | zzunicode2ascii | zzcapitalize)

	# Lista de signos válidos
	local signos='Aquario Peixes Aries Touro Gemeos Cancer Leao Virgem Libra Escorpiao Sagitario Capricornio'

	# Se o signo informado pelo usuário for válido faz a consulta ao serviço
	if test "${signos#*$signo}" != "$signos"
	then
		# Define as regras para remover tudo que não se refere ao signo desejado
		local padrao_signo='[ACEGLPSTV][a-z]\{3,10\}'
		local padrao_data='[0123][0-9]\/[01][0-9]'
		local remove_ini="s/^.*$signo de $padrao_data a $padrao_data //"
		local remove_fim="s/ $padrao_signo de $padrao_data a $padrao_data .*$//"

		# Endereço do serviço de consulta do horóscopo
		local url='http://developers.agenciaideias.com.br/horoscopo/xml'

		# Faz a mágica acontecer
		zztool dump -i 'utf-8' "$url" |
			tr -ds '\011\012\015' ' ' |
			zzunicode2ascii |
			sed "$remove_ini;$remove_fim"
	else
		return 1
	fi
}