# ----------------------------------------------------------------------------
# Elimina espaços excedentes no início, mantendo alinhamento.
# por padrão transforma todos os TABs em 4 espaços para uniformização.
# Um número como argumento especifica a quantidade de espaços para cada TAB.
# Caso use a opção -s, apenas espaços iniciais serão considerados.
# Caso use a opção -t, apenas TABs iniciais serão considerados.
#  Obs.: Com as opções -s e -t não há a conversão de tabs para espaço.
#
# Uso: zzlblank [-s|-t|<número>] arquivo.txt
# Ex.: zzlblank arq.txt     # Espaços e tabs iniciais
#      zzlblank -s arq.txt  # Apenas espaços iniciais
#      zzlblank -t arq.txt  # Apenas tabs iniciais
#      zzlblank 12 arq.txt  # Tabs são convertidos em 12 espaços
#      cat arq.txt | zzlblank
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2014-05-11
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzlblank ()
{
	zzzz -h lblank "$1" && return

	local tipo_blank=0
	local tab_spa=4

	while test "${1#-}" != "$1"
	do
		case "$1" in
			-s) tipo_blank=1; shift;;
			-t) tipo_blank=2; shift;;
			* ) break;;
		esac
	done

	if test -n $1
	then
		zztool testa_numero $1 && { tab_spa=$1; shift; }
	fi

	zztool file_stdin "$@" |
	awk -v tipo=$tipo_blank '
		function subs() {
			if (tipo == 2) { sub(/^\t*/, "", $0) }
			else { sub(/^ */, "", $0) }
		}

		BEGIN {
			for (i=1; i<='$tab_spa'; i++)
				espacos = espacos " "
		}

		{
			if ( tipo == 0 ) gsub(/\t/, espacos)
			linha[NR] = $0
			if ( length($0) > 0 ) {
				if ( length(qtde) == 0 ) {
					subs()
					qtde = length(linha[NR]) - length($0)
				}
				else {
					subs()
					qtde_temp = length(linha[NR]) - length($0)
					qtde = qtde <= qtde_temp ? qtde : qtde_temp
				}
			}
		}

		END {
			for (j=1; j<=NR; j++) {
				for (k=1; k<=qtde; k++) {
					if ( tipo == 2 )
						sub(/^\t/, "", linha[j])
					else
						sub(/^ /, "", linha[j])
				}
				print linha[j]
			}
		}
	'
}
