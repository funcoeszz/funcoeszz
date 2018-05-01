# ----------------------------------------------------------------------------
# Lista alguns dos comandos já traduzidos do banco MariaDB, numerando-os.
# Pesquisa detalhe dos comando, ao fornecer o número na listagem a esquerda.
# E filtra a busca se fornecer um texto.
#
# Uso: zzmariadb [ código | filtro ]
# Ex.: zzmariadb        # Lista os comandos disponíveis
#      zzmariadb 18     # Consulta o comando DROP USER
#      zzmariadb alter  # Filtra os comandos que possuam alter na declaração
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-07-03
# Versão: 4
# Licença: GPL
# Requisitos: zzminusculas zzsemacento zztrim
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zzmariadb ()
{
	zzzz -h mariadb "$1" && return

	local url='https://kb.askmonty.org/pt-br'
	local cache=$(zztool cache mariadb)
	local comando

	if test '--atualiza' = "$1"
	then
		zztool atualiza mariadb
		shift
	fi

	if ! test -s "$cache"
	then
		zztool dump "${url}/mariadb-brazilian-portuguese/" |
			sed -n '/^\( *\* \)\{0,1\}[A-Z]\{4,\}/p' |
			sed 's/  *\* *//' |
			awk '{print NR, $0}'> "$cache"
	fi

	if test -n "$1"
	then
		if zztool testa_numero "$1"
		then
			comando=$(
				sed -n "${1}p" "$cache" |
					sed "
						s/^${1} //
						s| / |-|g
						s/ - /-/g
						s/ /-/g
						s/\.//g
					" |
					zzminusculas |
					zzsemacento
			)
			zztool dump "${url}/${comando}/" |
				sed -n '/^ *Localized Versions/,/\* ←/ p' |
				sed '
					1d
					2d
					/^  *\*.*\]$/d
					/^ *Tweet */d
					/^ *\* *$/d
					$d
				' |
				zztrim -V
		else
			grep -i "$1" "$cache"
		fi
	else
		cat "$cache"
	fi
}
