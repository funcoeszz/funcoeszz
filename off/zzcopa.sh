# ----------------------------------------------------------------------------
# Mostra a classificação e jogos da Copa de Mundo.
# Opções:
#  <fase>: Mostra jogos da fase selecionada
#
# Obs.: Na fase de grupos pode filtrar por mostrar um grupo específico.
#       Pode-se escolher exibir apenas a classificação dos grupos.
#       Pode-se escolher exibir os jogos de todas as fases e grupos.
#
# As fases podem ser:
#  grupos
#  oitavas
#  quartas
#  semi, semi-final
#  final
#
# Os grupos podem ser qualqer letra entre A e H, inclusive minúscula
#
# Sem argumento mostra tudo (fases, grupos, classificação e jogos).
#
# Nomenclatura na fas de grupos:
#	PG  - Pontos Ganhos
#	J   - Jogos
#	V   - Vitórias
#	E   - Empates
#	D   - Derrotas
#	GP  - Gols Pró
#	GC  - Gols Contra
#	SG  - Saldo de Gols
#	(%) - Aproveitamento (pontos)
#
# Uso: zzcopa [fase |grupo | classificação | jogos | realizados]
# Ex.: zzcopa
#      zzcopa A             # Classificação e jogos do grupo A
#      zzcopa oitava        # Todos os jogos das oitavas de final
#      zzcopa classificação # Classificação de todos os grupos.
#      zzcopa jogos         # Todos os jogos, sem a classificação.
#      zzcopa realizados    # Todos os jogos já terminados.
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-12-07
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
# DESATIVADA: 2014-06-30 Não funciona mais, site usando AJAX :/
zzcopa ()
{
	zzzz -h copa "$1" && return

	local url="http://oglobo.globo.com/esportes/tabela-copa-do-mundo-2014"
	local sed_ini="^Grupo A"
	local sed_fim="Fornecido por Tabela Fácil"
	local letra

	case "$1" in
	[Gg]rupo | [Gg]rupos)
		sed_fim="^Oitavas de Final"
	;;
	[Oo]itava | [Oo]itavas)
		sed_ini="^Oitavas de Final"
		sed_fim="^Quartas de Final"
	;;
	[Qq]uarta | [Qq]uartas)
		sed_ini="^Quartas de Final"
		sed_fim="^SemiFinal"
	;;
	[Ss]emi-final | [Ss]emi)
		sed_ini="^SemiFinal"
		sed_fim="^Final"
	;;
	[Ff]inal)
		sed_ini="^Final"
	;;
	[a-hA-H])
		letra=$(echo "$1" | tr '[a-h]' '[A-H]')
		sed_ini="^Grupo $letra"
		[ "$letra" = "H" ] && sed_fim="^Oitavas de Final" || sed_fim="^Grupo [^${letra}]"
	;;
	[Cc]lassifica[cç][aã]o)
		sed_ini="^Grupo "
		sed_fim="^Jogos"
	;;
	[Jj]ogo | [Jj]ogos)
		sed_ini="^Jogos"
		sed_fim="^Grupo "
	;;
	[Rr]ealizado | [Rr]ealizados)
		sed_ini="^Jogos"
		sed_fim="^Grupo "
		letra="z"
	;;
	esac

	$ZZWWWDUMP "$url" | sed -n "/$sed_ini/,/$sed_fim/p" | sed "/$sed_fim/d;s/ *Links//;/^ *$/d;/([12].T)/d" |
	awk '
		no_print=0
		/Fornecido por Tabela Fácil/ { exit }
		/^Grupo [A-H]/               { print;getline;getline; no_print=1 }
		/^Classificação/             { print;getline;getline; no_print=1 }
		/^Jogos/                     { print;getline;getline; no_print=1 }
		/^Oitavas de Final/          { print;getline;getline; no_print=1 }
		/^Quartas de Final/          { print;getline;getline; no_print=1 }
		/^SemiFinal/                 { print;getline;getline; no_print=1 }
		/^Final/                     { print;getline;getline; no_print=1 }
		{
			if (no_print == 0) {
				if ($0 ~ /[0-9]:00/ && $0 !~ / x / && $0 !~ /0x0/ && $0 !~ /[1-9]x[0-9].*$/) {
					if ($0 !~ /0x/) {
						printf "%s", $0
						getline
					}
					if ($0 !~ /[0-9]x[0-9]/) sub(/^[[:blank:]]*/, " ")
					printf "%s", $0
					if($0 !~ /x0/) {
						getline
						sub(/^[[:blank:]]*/, " ")
						printf "%s", $0
					}
					print ""
				}
				else
					print
			}
		}
		' |
		sed 's/  *\([0-9]\)x\([0-9]\)  */ \1x\2 /g' |
		if test "$letra" = "z"
		then
			grep '[0-9]x[0-9]'
		else
			cat -
		fi
}
