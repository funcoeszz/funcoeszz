# ----------------------------------------------------------------------------
# Busca os últimos tweets de um usuário.
# Uso: zztweets @username
# Ex.: zztweets @oreio
#
# Autor: Eri Ramos Bastos <bastos.eri (a) gmail.com>
# Desde: 2009-07-30
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zztweets ()
{
	zzzz -h tweets "$1" && return

	[ "$1" ] || { zztool uso tweets; return 1; }

	local url="https://twitter.com"
	local name=$(echo $1 | tr -d "@")
	
	$ZZWWWDUMP $url/$name | 
	sed -n '/ .*[0-9]\{1,2\}\./{n;p}' | 
	sed 's/\[DEL: \(.\) :DEL\] /\1/g;s/^ */ /g'
	
	#Se quiser manter apenas 5 último tweets, substituir a segunda linha por essa:
	#sed -n '/ .*[1-5]\./{n;p}'
}
