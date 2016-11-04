# ----------------------------------------------------------------------------
# Envia email via ssmtp.
# Opções:
#   -h, --help     exibe a ajuda.
#   -v, --verbose  exibe informações para debug durante o processamento.
#   -V, --version  exibe a versão.
#   -f, --from     email do remetente.
#   -t, --to       email dos destinatários (separe com vírgulas, sem espaço).
#   -c, --cc       email dos destinatários em cópia (vírgulas, sem espaço).
#   -b, --bcc      emails em cópia oculta (vírgulas, sem espaço).
#   -s, --subject  o assunto do email.
#   -e, --mensagem arquivo que contém a mensagem/corpo do email.
# Uso: zzenviaemail -f email -t email [-c email] [-b email] -s assunto -m msg
# Ex.: zzenviaemail -f quem_envia@dominio.com -t quem_recebe@dominio.com \
#      -s "Teste de e-mail" -m "./arq_msg.eml"
#
# Autor: Lauro Cavalcanti de Sa <lauro (a) ecdesa com>
# Desde: 2009-09-17
# Versão: 2
# Licença: GPLv2
# Nota: requer ssmtp
# ----------------------------------------------------------------------------
# DESATIVADA: 2016-05-21 comando ssmtp não funciona (veja issue #298)
zzenviaemail ()
{
	zzzz -h enviaemail "$1" && return

	# Declara variaveis.
	local fromail tomail ccmail bccmail subject msgbody
	local envia_data=`date +"%Y%m%d_%H%M%S_%N"`
	local script_eml=$(zztool cache enviaemail "${envia_data}.eml")
	local nparam=0

	# Opcoes de linha de comando
	while test $# -ge 1
	do
		case "$1" in
			-f | --from)
				test -n "$2" || { zztool -e uso enviaemail; set +x; return 1; }
				fromail=$2
				nparam=$(($nparam + 1))
				shift
				;;
			-t | --to)
				test -n "$2" || { zztool -e uso enviaemail; set +x; return 1; }
				tomail=$2
				nparam=$(($nparam + 1))
				shift
				;;
			-c | --cc)
				test -n "$2" || { zztool -e uso enviaemail; set +x; return 1; }
				ccmail=$2
				shift
				;;
			-b | --bcc)
				test -n "$2" || { zztool -e uso enviaemail; set +x; return 1; }
				bccmail=$2
				shift
				;;
			-s | --subject)
				test -n "$2" || { zztool -e uso enviaemail; set +x; return 1; }
				subject=$2
				nparam=$(($nparam + 1))
				shift
				;;
			-m | --mensagem)
				test -n "$2" || { zztool -e uso enviaemail; set +x; return 1; }
				mensagem=$2
				nparam=$(($nparam + 1))
				shift
				;;
			-v | --verbose)
				set -x
				;;
			*) { zztool -e uso enviaemail; set +x; return 1; } ;;
		esac
		shift
	done

	# Verifica numero minimo de parametros.
	if test "${nparam}" != 4 ; then
		{ zztool -e uso enviaemail; set +x; return 1; }
	fi

	# Verifica se o arquivo existe.
	zztool arquivo_existe "${mensagem}"

	# Monta e-mail padrao para envio via SMTP.
	echo "From: ${fromail} <${fromail}>" > ${script_eml}
	echo "To: ${tomail}" >> ${script_eml}
	echo "Cc: ${ccmail}" >> ${script_eml}
	echo "Bcc: ${bccmail}" >> ${script_eml}
	echo "Subject: ${subject}" >> ${script_eml}
	cat ${mensagem} >> ${script_eml}
	ssmtp -F ${fromail} ${tomail} ${ccmail} ${bccmail} < ${script_eml}
	if test -s "${script_eml}" ; then
		zztool cache rm enviaemail
	fi

	set +x
}
