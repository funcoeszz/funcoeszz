# ----------------------------------------------------------------------------
# http://www.significado.origem.nom.br/
# Dicionário de nomes, com sua origem, numerologia e arcanos do tarot.
# Pode-se filtrar por significado, origem, letra (primeira letra), tarot
# marca (no mundo), numerologia ou tudo - como segundo argumento (opcional).
# Por padrão lista origem e significado.
#
# Uso: zznome nome [significado|origem|letra|marca|numerologia|tarot|tudo]
# Ex.: zznome maria
#      zznome josé origem
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2011-04-22
# Versão: 4
# Licença: GPL
# Requisitos: zzsemacento zzminusculas
# ----------------------------------------------------------------------------
zznome ()
{
	zzzz -h nome "$1" && return

	local url='http://www.significado.origem.nom.br'
	local ini='Qual a origem do nome '
	local fim='Analise da Primeira Letra do Nome:'
	local nome=$(echo "$1" | zzminusculas | zzsemacento)

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso nome; return 1; }

	case "$2" in
		origem)
			ini='Qual a origem do nome '
			fim='^ *$'
		;;
		significado)
			ini='Qual o significado do nome '
			fim='^ *$'
		;;
		letra)
			ini='Analise da Primeira Letra do Nome:'
			fim='Sua marca no mundo!'
		;;
		marca)
			ini='Sua marca no mundo!'
			fim='Significado - Numerologia - Expressão'
		;;
		numerologia)
			ini='Significado - Numerologia - Expressão'
			fim=' - Arcanos do Tarot'
		;;
		tarot)
			ini=' - Arcanos do Tarot'
			fim='^VEJA TAMBÉM'
		;;
		tudo)
			ini='Qual a origem do nome '
			fim='^VEJA TAMBÉM'
		;;
	esac

	$ZZWWWDUMP "$url/nomes/?q=$nome" |
		sed -n "
		/$ini/,/$fim/ {
			/$fim/d
			/\[[0-9]\{1,\}\.jpg\]/d
			s/^ *//g
			s/^Qual a origem/Origem/
			s/^Qual o significado/Significado/
			/^Significado de / {
				N
				d
			}
			p
		}" 2>/dev/null
		# Escondendo erros pois a codificação do site é estranha
		# https://github.com/funcoeszz/funcoeszz/issues/27
}
