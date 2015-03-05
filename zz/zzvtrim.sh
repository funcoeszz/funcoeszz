# ----------------------------------------------------------------------------
# Elimina linhas em branco no começo e/ou no final, como um trim vertical.
# Também reduzir/eliminar as linhas em branco consecutivas no meio do texto.
#
# Por padrão:
#  - elimina espaços em branco ao final de cada linha.
#  - elimina os espaços em branco no início da linha, mantendo alinhamento.
#
# Pode-se alinhar à esquerda, tirando todos os espaços iniciais das linhas.
#
# Opções:
#  -t  | --top     => Apaga apenas as linhas em branco no começo do texto.
#  -b  | --bottom  => Apaga apenas as linhas em branco no final do texto.
#  -m  | --middle  => Junta as linhas em branco seguidas no meio do texto.
#  -m0 | --middle0 => Elimina as linhas em branco no meio do texto.
#  -l  | --left    => Elimina espaços à esquerda, mantendo alinhamento.
#  -ll             => Apagar todos os espaços à esquerda sem alinhar.
#  -n <número>     => Espaços em substituição aos TABs (padrão 4).
#  -all:           => Mistura de -m -l.
#
# Uso: zzvtrim [-t|-b] [-m|-n] [-l|-d] arquivo
# Ex.: zzvtrim -t arq.txt   # Tira linhas em branco no início.
#      zzvtrim -b arq.txt   # Tira linhas em branco no final.
#      zzvtrim -m arq.txt   # Funde as linhas em branco no meio em uma.
#      zzvtrim -m0 arq.txt  # Exclui as linhas em branco no meio.
#      zzvtrim -l arq.txt   # Remove o excesso de espaços à esquerda.
#      cat arq.txt | zztrim -all 
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2015-03-05
# Versão: 1
# Licença: GPL
# Requisitos: zzlblank
# ----------------------------------------------------------------------------
zzvtrim ()
{

	zzzz -h vtrim "$1" && return

	local vtrim=0
	local middle=0
	local left=0
	local tab_spa=4
	local var_awk

	while test "${1#-}" != "$1"
	do
		case "$1" in
			-t  | --top)     vtrim=1;  shift;;
			-b  | --bottom)  vtrim=2;  shift;;
			-m  | --middle)  middle=1; shift;;
			-m0 | --middle0) middle=2; shift;;
			-l  | --left)    left=1;   shift;;
			-ll)             left=2;   shift;;
			-n)
				shift
				if zztool testa_numero "$1"
				then
					tab_spa=$1
					shift
				fi
			;;
			--all)
				vtrim=0
				middle=1
				left=1
				shift
				break
			;;
			*) break;;
		esac
	done

	zztool file_stdin "$@" |
	zztool rtrim |
	case "$left" in
		1) zzlblank $tab_spa;;
		2) zztool ltrim;;
		*) cat -;;
	esac |
	awk -v vtrim_awk="$vtrim" -v middle_awk="$middle" '
		BEGIN { branco=0 }

		NR == 1 {
			# Retira linhas em banco no começo
			if ( (vtrim_awk==0 || vtrim_awk==1) && $0 ~ /^$/ )
			{
				while ( $0 ~ /^$/ ) getline
				print; getline
			}
			else {
				while ($0 ~ /^$/) {
					print;getline
				}
			}
		}

		NR > 1 {
			if ( $0 ~ /^$/ ) { branco++ }

			if ( $0 !~ /^$/ ) {
				# Se 1: Várias linha em branco no meio tornam-se apenas 1
				# Se 2: As linhas em branco no meio são eliminadas
				# Outros valores: As linhas em branco no meio são mantidas
				if ( middle_awk != 1 && middle_awk !=2 ) {
					for ( i=1; i<=branco; i++ )
						print ""
				}
				if (middle_awk==1 && branco>0) print ""
				branco=0
				print
			}
		}

		END {
			# Retorna linha em branco no final
			if ( vtrim_awk !=0 && vtrim_awk != 2 ) {
				for ( i=1; i<=branco; i++ )
					print ""
			}
		}
	'
}
