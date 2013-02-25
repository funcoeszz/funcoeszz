# ----------------------------------------------------------------------------
# http://aurelio.net/doc/ramones.txt
# Mostra uma frase aleatória, das letras de músicas da banda punk Ramones.
# Obs.: Informe uma palavra se quiser frases sobre algum assunto especifico.
# Uso: zzramones [palavra]
# Ex.: zzramones punk
#      zzramones
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2001-07-24
# Versão: 1
# Licença: GPL
# Requisitos: zzlinha
# ----------------------------------------------------------------------------
zzramones ()
{
	zzzz -h ramones "$1" && return

	local url='http://aurelio.net/doc/ramones.txt'
	local cache="$ZZTMP.ramones"
	local padrao=$1

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" > "$cache"
	fi

	# Mostra uma linha qualquer (com o padrão, se informado)
	zzlinha -t "${padrao:-.}" "$cache"
}
