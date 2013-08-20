# ----------------------------------------------------------------------------
# Lista alguns dos comandos já traduzidos do banco MariaDB, numerando-os.
# Pesquisa detalhe dos comando, ao fornecer o número na listagem a esquerda.
# E filtra a busca se fornecer um texto.
#
# Uso: zzmariadb [ código | filtro ]
# Ex.: zzmariadb        # Lista os comandos disponíveis
#      zzmariadb 18     # Consulta o comando CREATE DATABASE
#      zzmariadb alter  # Filtra os comandos que possuam alter na declaração
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-07-03
# Versão: 1
# Licença: GPL
# Requisitos: zzminusculas zzsemacento
# ----------------------------------------------------------------------------
zzmariadb ()
{
	zzzz -h mariadb "$1" && return

	local url='https://kb.askmonty.org/pt-br'
	local cache="$ZZTMP.mariadb"
	local comando

	if ! test -s "$cache"
	then
		$ZZWWWDUMP "${url}/mariadb-brazilian-portuguese" | sed -n '/Localized Versions/,/Recent Changes/p' |
		sed '
			1d
			/^ *$/d
			/\*/d
			/^ *Comunidade/d
			/^ *Downloads/d
			s/^  *//g
		'| uniq | awk '{print NR, $0}'> $cache
	fi

	if [ "$1" ]
	then
		if zztool testa_numero $1
		then
			comando=$(sed -n "${1}p" $cache | sed "s/^${1} //;s| / |-|g;s/ - /-/g;s/ /-/g;s/\.//g" | zzminusculas | zzsemacento)
			$ZZWWWDUMP "${url}/${comando}" | sed -n '/^Localized Versions/,/^Comments/p' | sed '1d;2d;/^  *\*.*\]$/d;$d'
		else
			grep -i $1 $cache
		fi
	else
		cat "$cache"
	fi
}
