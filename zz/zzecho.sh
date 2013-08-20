# ----------------------------------------------------------------------------
# Mostra textos coloridos, sublinhados e piscantes no terminal (códigos ANSI).
# Opções: -f, --fundo       escolhe a cor de fundo
#         -l, --letra       escolhe a cor da letra
#         -p, --pisca       texto piscante
#         -s, --sublinhado  texto sublinhado
#         -N, --negrito     texto em negrito (brilhante em alguns terminais)
#         -n, --nao-quebra  não quebra a linha no final, igual ao echo -n
# Cores: preto vermelho verde amarelo azul roxo ciano branco
# Obs.: \t, \n e amigos são sempre interpretados (igual ao echo -e).
# Uso: zzecho [-f cor] [-l cor] [-p] [-s] [-N] [-n] [texto]
# Ex.: zzecho -l amarelo Texto em amarelo
#      zzecho -f azul -l branco -N Texto branco em negrito, com fundo azul
#      zzecho -p -s Texto piscante e sublinhado
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2008-09-02
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzecho ()
{
	zzzz -h echo "$1" && return

	local letra fundo negrito cor pisca sublinhado
	local quebra_linha='\n'

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-l | --letra)
				case "$2" in
					# Permite versões femininas também (--letra preta)
					pret[oa]       ) letra=';30' ;;
					vermelh[oa]    ) letra=';31' ;;
					verde          ) letra=';32' ;;
					amarel[oa]     ) letra=';33' ;;
					azul           ) letra=';34' ;;
					rox[oa] | rosa ) letra=';35' ;;
					cian[oa]       ) letra=';36' ;;
					branc[oa]      ) letra=';37' ;;
					*) zztool uso echo; return 1 ;;
				esac
				shift
			;;
			-f | --fundo)
				case "$2" in
					preto       ) fundo='40' ;;
					vermelho    ) fundo='41' ;;
					verde       ) fundo='42' ;;
					amarelo     ) fundo='43' ;;
					azul        ) fundo='44' ;;
					roxo | rosa ) fundo='45' ;;
					ciano       ) fundo='46' ;;
					branco      ) fundo='47' ;;
					*) zztool uso echo; return 1 ;;
				esac
				shift
			;;
			-N | --negrito    ) negrito=';1'    ;;
			-p | --pisca      ) pisca=';5'      ;;
			-s | --sublinhado ) sublinhado=';4' ;;
			-n | --nao-quebra ) quebra_linha='' ;;
			*) break ;;
		esac
		shift
	done

	[ "$1" ] || { zztool uso echo; return 1; }

	# Mostra códigos ANSI somente quando necessário (e quando ZZCOR estiver ligada)
	if [ "$ZZCOR" != '1' -o "$fundo$letra$negrito$pisca$sublinhado" = '' ]
	then
		printf -- "$*$quebra_linha"
	else
		printf -- "\033[$fundo$letra$negrito$pisca${sublinhado}m$*\033[m$quebra_linha"
	fi
}
