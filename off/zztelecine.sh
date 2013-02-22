# ----------------------------------------------------------------------------
# http://globosat.globo.com/telecine
# Mostra a programação dos cinco canais do Telecine.
# Uso: zztelecine
# Ex.: zztelecine
#
# Autor: Frederico Freire Boaventura <anonymous (a) galahad com br>
# Desde: 2005-04-02
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2010-12-22 Filtro quebrado. A saída aparece bagunçada.
zztelecine ()
{
	zzzz -h telecine $1 && return

	local URL="http://globosat.globo.com/telecine/servicos/programacao.asp"

	$ZZWWWDUMP "$URL" |
	 	sed '
			1,2d
			/^$/d
			s/^  \+//g
			/^.\(prog_\|[0-9]\)/!d
			s/.prog_\(.*\)\..*$/\ntelecine \1\n/g
			s/\[i_noar.gif\]/\*\*\*/' |
		uniq
}
