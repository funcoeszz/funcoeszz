# ----------------------------------------------------------------------------
# Mostra a programação da Rede Globo do dia.
# Uso: zzglobo
# Ex.: zzglobo
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2017-11-29
# Versão: 9
# Requisitos: zzzz zztv
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzglobo ()
{
		zzzz -h globo "$1" && return

		zztv grd |
			sed 's/ *cod:.*//'
}
