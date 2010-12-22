# ----------------------------------------------------------------------------
# Mostra os filmes da semana na TV aberta.
# Uso: zzfilme
# Ex.: zzfilme
#
# Autor: Vinícius Venâncio Leite <vv.leite (a) gmail com>
# Desde: 2008-01-03
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2010-12-22 Cada dia da semana agora é um link para uma nova URL
zzfilme ()
{
	zzzz -h filme $1 && return

	local URL="http://exclusivo.terra.com.br/interna/0,,OI284815-EI1489,00.html"

	$ZZWWWDUMP "$URL" |
		sed -n '
			s/^ \+//
			/Filmes da semana da TV/,/^$/p' |
		sed -e '
			s/\.$/\n/	
			/^\(\Segunda\|Terça\|Quarta\|Quinta\|Sexta\|Sábado\|Domingo\)/ {
				h
				s/.*/=========================/
				p
				x
			}
			/^\(\Segunda\|Terça\|Quarta\|Quinta\|Sexta\|Sábado\|Domingo\)/ {
				p
				s/.*/=========================/
			}' |
			
		uniq
}
