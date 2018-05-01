# ----------------------------------------------------------------------------
# http://www.correios.com.br
# Acompanha encomendas via rastreamento dos Correios.
# Uso: zzrastreamento <código_da_encomenda> ...
# Ex.: zzrastreamento RK995267899BR
#      zzrastreamento RK995267899BR RA995267899CN
#
# Autor: Frederico Freire Boaventura <anonymous (a) galahad com br>
# Desde: 2007-06-25
# Versão: 4
# Licença: GPL
# Requisitos: zztrim zzunescape zzxml zzjuntalinhas
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzrastreamento ()
{
	zzzz -h rastreamento "$1" && return

	test -n "$1" || { zztool -e uso rastreamento; return 1; }

	local url='http://www2.correios.com.br/sistemas/rastreamento/resultado_semcontent.cfm?'

	# Para cada código recebido...
	for codigo
	do
		# Só mostra o código se houver mais de um
		test $# -gt 1 && zztool eco "**** $codigo"

		curl -s $url -d "objetos=$codigo" |
			iconv -f iso-8859-1 -t utf-8 |
			zzxml --tag tr |
			zztrim |
			zzunescape --html |
			sed '/^ *$/d' |
			zzjuntalinhas -i '<tr' -f '</tr>' |
			zzxml --untag |
			tr -s '\t' |
			expand -t 1,13,20 |
			zztrim

		# Linha em branco para separar resultados
		test $# -gt 1 && echo || :
	done
}
