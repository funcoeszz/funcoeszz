# ----------------------------------------------------------------------------
# http://m.horoscopovirtual.bol.uol.com.br/horoscopo/
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
# Requisitos: zzsemacento zzminusculas zztrim zzxml
# Tags: internet, distração, consulta
# ----------------------------------------------------------------------------
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
	local signo=$(zzsemacento "$1" | zzminusculas)

	# Lista de signos válidos
	local signos='aquario peixes aries touro gemeos cancer leao virgem libra escorpiao sagitario capricornio'

	# Se o signo informado pelo usuário for válido faz a consulta ao serviço
	if zztool grep_var $signo "$signos"
	then
		# Endereço do serviço de consulta do horóscopo
		local url="http://m.horoscopovirtual.bol.uol.com.br/horoscopo/$signo"

		# Faz a mágica acontecer
		zztool source -u 'Mozilla/5.0' "$url" |
			sed -n '/title-sign/p;/date-sign/{s/&.*//;p;};/text-pred/,/<span/p' |
			zzxml --untag |
			zztrim
	else
		return 1
	fi
}
