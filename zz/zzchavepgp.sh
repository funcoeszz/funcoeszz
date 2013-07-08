# ----------------------------------------------------------------------------
# http://pgp.mit.edu
# Busca a identificação da chave PGP, fornecido o nome ou e-mail da pessoa.
# Uso: zzchavepgp nome|e-mail
# Ex.: zzchavepgp Carlos Oliveira da Silva
#      zzchavepgp carlos@dominio.com.br
#
# Autor: Rodrigo Missiaggia
# Desde: 2001-10-01
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzchavepgp ()
{
	zzzz -h chavepgp "$1" && return

	local url='http://pgp.mit.edu:11371'
	local padrao=$(echo $* | sed "$ZZSEDURL")

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso chavepgp; return 1; }

	$ZZWWWDUMP "http://pgp.mit.edu:11371/pks/lookup?search=$padrao&op=index" |
		sed 1,2d |
		sed '
			# Remove linhas em branco
			/^$/ d
			# Remove linhas ____________________
			/^ *___*$/ d'
}
