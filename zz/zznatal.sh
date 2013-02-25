# ----------------------------------------------------------------------------
# http://www.ibb.org.br/vidanet
# A mensagem "Feliz Natal" em vários idiomas.
# Uso: zznatal [palavra]
# Ex.: zznatal                   # busca um idioma aleatório
#      zznatal russo             # Feliz Natal em russo
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2004-12-23
# Versão: 1
# Licença: GPL
# Requisitos: zzlinha
# ----------------------------------------------------------------------------
zznatal ()
{
	zzzz -h natal "$1" && return

	local url='http://www.vidanet.org.br/mensagens/feliz-natal-em-varios-idiomas'
	local cache="$ZZTMP.natal"
	local padrao=$1

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" | sed '
			1,10d
			77,179d
			s/^  *//
			s/^(/Chinês  &/
			s/  */: /' > "$cache"
	fi

	# Mostra uma linha qualquer (com o padrão, se informado)
	echo -n '"Feliz Natal" em '
	zzlinha -t "${padrao:-.}" "$cache"
}
