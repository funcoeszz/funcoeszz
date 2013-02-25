# ----------------------------------------------------------------------------
# http://www.nextel.com.br
# Envia uma mensagem para um telefone NEXTEL (via rádio).
# Obs.: O número especificado é o número próprio do telefone (não o ID!).
# Uso: zznextel de para mensagem
# Ex.: zznextel aurélio 554178787878 minha mensagem mala
#
# Autor: Aurélio Marinho Jargas, www.aurelio.net
# Desde: 2002-03-15
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2008-03-01 Agora a consulta é travada com CAPTCHA
zznextel ()
{
	zzzz -h nextel $1 && return
	
	local msg
	local url=http://page.nextel.com.br/cgi-bin/sendPage_v3.cgi
	local subj=zznextel
	local from="$1"
	local to="$2"

	# Verificação dos parâmetros
	[ "$3" ] || { zztool uso nextel; return; }

	shift; shift
	msg=$(echo "$*" | sed "$ZZSEDURL")

	echo "to=$to&from=$from&subject=$subj&message=$msg&count=0&Enviar=Enviar" |
		$ZZWWWPOST "$url" |
		sed '1,/^ *CENTRAL/d ; s/.*Individual/ / ; N ; q'
}
