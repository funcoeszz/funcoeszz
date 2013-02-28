# ----------------------------------------------------------------------------
# http://registro.br
# Mostra informações sobre domínios brasileiros (.com.br, .org.br, etc).
# Uso: zzwhoisbr domínio
# Ex.: zzwhoisbr abc.com.br
#      zzwhoisbr www.abc.com.br
#
# Autor: Marcelo Subtil Marçal
# Desde: 2001-12-14
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-27 Hoje o comando whois pega domínios .br (issue #37)
zzwhoisbr ()
{
	zzzz -h whoisbr "$1" && return

	local url='http://registro.br/cgi-bin/whois/'
	local dominio="${1#www.}" # tira www do início

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso whoisbr; return 1; }

	# Faz a consulta e filtra o resultado
	$ZZWWWDUMP "$url?qr=$dominio" |
		sed '
			s/^  *//
			1,/^%/d
			/^remarks/,$d
			/^%/d
			/^alterado/d
			/atualizado /d
			/^$/d'
}
