# ----------------------------------------------------------------------------
# http://www.itautrade.com.br e http://www.bovespa.com.br
# Busca a cotação de uma ação na Bovespa.
# Obs.: As cotações têm delay de 15 min em relação ao preço atual no pregão
#       Com a opção -i, é mostrado o índice bovespa
# Uso: zzbovespa [-i] código-da-ação
# Ex.: zzbovespa petr4
#      zzbovespa -i
#      zzbovespa
#
# Autor: Denis Dias de Lima <denis (a) concatenum com>
# Desde: 2004-05-18
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2008-03-01 Agora os sites usam AJAX :(
zzbovespa ()
{
	zzzz -h bovespa $1 && return

	local url='http://www.bovespa.com.br/'

	[ "$1" ] || {
		$ZZWWWDUMP "$url/Indices/CarteiraP.asp?Indice=Ibovespa" |
			sed '/^ *Cód/,/^$/!d'
		return
	}
	[ "$1" = "-i" ] && {
		$ZZWWWHTML "$url/Home/HomeNoticias.asp" |
			sed -n '
				/Ibovespa -->/,/IBrX/ {
					//d
					s/<[^>]*>//g
					s/[[:space:]]*//g
					s/^&.*\;//
					/^$/d
					p
				}' |
			sed '
				/^Pon/ {
					N
					s/^/		   /
					s/\n/   /
					b
				}

				/^IBO/ N
				N
				s/\n/  /g
				/^<.-- /d

				:a
				s/^\([^0-9]\{1,10\}\)\([0-9][0-9]*\)/\1 \2/
				ta'
		return
	}
	url='http://www.itautrade.com.br/itautradenet/Finder/Finder.aspx?Papel='
	$ZZWWWDUMP "$url$1" |
		sed '
			/Ação/,/Oferta/!d
			/Fracionário/,/Oferta/!d
			//d
			/\.gif/d
			s/^ *//
			/Milhares/q'
}
