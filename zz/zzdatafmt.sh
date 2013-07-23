# ----------------------------------------------------------------------------
# Muda o formato de uma data, com várias opções de personalização.
# Reconhece datas em vários formatos, como aaaa-mm-dd, dd.mm.aaaa e dd/mm.
# Obs.: Se você não informar o ano, será usado o ano corrente.
# Para a opção:
#        --en para usar nomes de meses em inglês.
#        --pt para usar nomes de meses em português.
#        --es para usar nomes de meses em espanhol.
#        --de para usar nomes de meses em alemão.
#        --fr para usar nomes de meses em francês.
#        --it para usar nomes de meses em italiano.
# Se não for definido o formato com a opção -f, são fornecidos formatos
# compatíveis com as opções de idioma.
#
# Use a opção -f para mudar o formato de saída (o padrão é DD/MM/AAAA):
#
#      Código   Exemplo     Descrição
#      --------------------------------------
#      AAAA     2003        Ano com 4 dígitos
#      AA       03          Ano com 2 dígitos
#      A        3           Ano sem zeros à esquerda (1 ou 2 dígitos)
#      MES      fevereiro   Nome do mês
#      MMM      fev         Nome do mês com três letras
#      MM       02          Mês com 2 dígitos
#      M        2           Mês sem zeros à esquerda
#      DD       01          Dia com 2 dígitos
#      D        1           Dia sem zeros à esquerda
#
# Uso: zzdatafmt [-f formato] [data]
# Ex.: zzdatafmt 2011-12-31                 # 31/12/2011
#      zzdatafmt 31.12.11                   # 31/12/2011
#      zzdatafmt 31/12                      # 31/12/2011    (ano atual)
#      zzdatafmt -f MES hoje                # maio          (mês atual)
#      zzdatafmt -f MES --en hoje           # May           (em inglês)
#      zzdatafmt -f AAAA 31/12/11           # 2011
#      zzdatafmt -f MM/DD/AA 31/12/2011     # 12/31/11
#      zzdatafmt -f D/M/A 01/02/2003        # 1/2/3
#      zzdatafmt -f "D de MES" 01/05/95     # 1 de maio
#      echo 31/12/2011 | zzdatafmt -f MM    # 12            (via STDIN)
#      zzdatafmt 31 de jan de 2013          # 31/01/2013
#      zzdatafmt --de 19 de março de 2012   # 19. März 2012
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-24
# Versão: 6
# Licença: GPL
# Requisitos: zzdata zzminusculas zznumero
# Tags: data
# ----------------------------------------------------------------------------
zzdatafmt ()
{
	zzzz -h datafmt "$1" && return

	local data data_orig fmt ano mes dia aaaa aa mm dd a m d ano_atual meses
	local meses_pt='janeiro fevereiro março abril maio junho julho agosto setembro outubro novembro dezembro'
	local meses_en='January February March April May June July August September October November December'
	local meses_es='Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre'
	local meses_al='Januar Februar März April Mai Juni Juli August September Oktober November Dezember'
	local meses_fr='Janvier Février Mars Avril Mai Juin Juillet Août Septembre Octobre Novembre Décembre'
	local meses_it='Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre'

	# Idioma padrão
	meses="$meses_pt"

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			--en)
				meses=$meses_en
				[ "$fmt" ] || fmt='MES, DD AAAA'
				shift
			;;
			--it)
				meses=$meses_it
				[ "$fmt" ] || fmt='DD da MES AAAA'
				shift
			;;
			--es)
				meses=$meses_es
				[ "$fmt" ] || fmt='DD de MES de AAAA'
				shift
			;;
			--pt | --ptt)
				meses=$meses_pt
				[ "$fmt" ] || fmt='DD de MES de AAAA'
				[ "$1" = "--ptt" ] && fmt=$(echo "$fmt" | sed 's/DD/DDT/g;s/AAAA/AAAAT/g')
				shift
			;;
			--de)
				meses=$meses_al
				[ "$fmt" ] || fmt='DD. MES AAAA'
				shift
			;;
			--fr)
				meses=$meses_fr
				[ "$fmt" ] || fmt='Le DD MES AAAA'
				shift
			;;
			-f)
				fmt="$2"
				shift
				shift
			;;
			*) break ;;
		esac
	done

	# Data via STDIN ou argumentos
	data=$(zztool multi_stdin "$@")
	data_orig="$data"

	# Data em formato textual
	echo "$data" | grep ' de ' > /dev/null && data=$(echo "$data" | sed 's| de |/|g;')
	data=$(echo "$data" | tr -d ' ' | tr .- //)
	mes=$(echo "$data" | cut -d / -f 2)
	mm=$(echo "$meses_pt" |
		zzminusculas |
		awk '{for (i=1;i<=NF;i++){ if (substr($i,1,3) == substr("'$(echo $mes | zzminusculas)'",1,3) ) printf "%02s\n", i}}')

	zztool testa_numero "$mm" && data=$(echo $data | sed "s/$mes/$mm/")
	unset mes mm

	# Converte datas estranhas para o formato brasileiro ../../..
	case "$data" in
		# apelidos
		hoje | ontem | anteontem | amanh[ãa])
			data=$(zzdata "$data")
		;;
		# aaaa-mm-dd (ISO)
		????-??-??)
			data=$(echo "$data" | sed 's|\(....\)-\(..\)-\(..\)|\3/\2/\1|')
		;;
		# d-m-a, d-m
		# d.m.a, d.m
		*-* | *.*)
			data=$(echo "$data" | tr .- //)
		;;
		# ddmmaaaa
		[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])
			data=$(echo "$data" | sed 's|.|&/|4 ; s|.|&/|2')
		;;
		# ddmmaa
		[0-9][0-9][0-9][0-9][0-9][0-9])
			data=$(echo "$data" | sed 's|.|&/|4 ; s|.|&/|2')
		;;
	esac

	### Aqui só chegam datas com a barra / como delimitador
	### Mas elas podem ser parcias, como: dia/mês

	# Completa elementos que estão faltando na data
	case "$data" in
		# d/m, dd/m, d/mm, dd/mm
		# Adiciona o ano atual
		[0-9]/[0-9] | [0-9][0-9]/[0-9] | [0-9]/[0-9][0-9] | [0-9][0-9]/[0-9][0-9])
			ano_atual=$(zzdata hoje | cut -d / -f 3)
			data="$data/$ano_atual"
		;;
	esac

	### Aqui só chegam datas completas, com os três elementos: n/n/n
	### Devo acertar o padding delas pra nn/nn/nnnn

	# Valida o formato da data
	if ! echo "$data" | grep '^[0-9][0-9]\{0,1\}/[0-9][0-9]\{0,1\}/[0-9]\{1,4\}$' >/dev/null
	then
		echo "Erro: Data em formato desconhecido '$data_orig'"
		return 1
	fi

	# Extrai os valores da data
	dia=$(echo "$data" | cut -d / -f 1)
	mes=$(echo "$data" | cut -d / -f 2)
	ano=$(echo "$data" | cut -d / -f 3)

	# Faz padding nos valores
	case "$ano" in
		?         ) aaaa="200$ano";;  # 2000-2009
		[0-3][0-9]) aaaa="20$ano";;   # 2000-2039
		[4-9][0-9]) aaaa="19$ano";;   # 1940-1999
		???       ) aaaa="0$ano";;    # 0000-0999
		????      ) aaaa="$ano";;
	esac
	case "$mes" in
		?)  mm="0$mes";;
		??) mm="$mes";;
	esac
	case "$dia" in
		?)  dd="0$dia";;
		??) dd="$dia";;
	esac

	# Ok, agora a data está no formato correto: dd/mm/aaaa
	data="$dd/$mm/$aaaa"

	# Valida a data
	zztool -e testa_data "$data" || return 1

	# O usuário especificou um formato novo?
	if test -n "$fmt"
	then
		aaaa="${data##*/}"
		mm="${data#*/}"; mm="${mm%/*}"
		dd="${data%%/*}"
		aa="${aaaa#??}"
		a="${aa#0}"
		m="${mm#0}"
		d="${dd#0}"
		mes=$(echo "$meses" | cut -d ' ' -f "$m" 2>/dev/null)
		mmm=$(echo "$mes" | cut -c 1-3)

		# Percorre o formato e vai expandindo, da esquerda para a direita
		while test -n "$fmt"
		do
			# Atenção à ordem das opções do case: AAAA -> AAA -> AA
			# Sempre do maior para o menor para evitar matches parciais
			case "$fmt" in
				AAAAT*)
					printf "$(zznumero --texto "$aaaa" | sed 's/^ *//;s/ inteiros*//')"
					fmt="${fmt#AAAAT}";;
				AAAA* ) printf %s "$aaaa"; fmt="${fmt#AAAA}";;
				AA*   ) printf %s "$aa"  ; fmt="${fmt#AA}";;
				A*    ) printf %s "$a"   ; fmt="${fmt#A}";;
				MES*  ) printf %s "$mes" ; fmt="${fmt#MES}";;
				MMM*  )
					printf %s "$mmm" | sed 's/ä/är/;s/Fé/Fév/;s/Dé/Déc/' | tr -d '\n'
					fmt="${fmt#MMM}"
				;;
				MM*   ) printf %s "$mm"  ; fmt="${fmt#MM}";;
				M*    ) printf %s "$m"   ; fmt="${fmt#M}";;
				DDT*  )
					printf "$(zznumero --texto "$dd" | sed 's/^ *//;s/ inteiros*//')"
					fmt="${fmt#DDT}";;
				DD*   ) printf %s "$dd"  ; fmt="${fmt#DD}";;
				D*    ) printf %s "$d"   ; fmt="${fmt#D}";;
				*     ) printf %c "$fmt" ; fmt="${fmt#?}";;  # 1char
			esac
		done
		echo

	# Senão, é só mostrar no formato normal
	else
		echo "$data"
	fi
}
