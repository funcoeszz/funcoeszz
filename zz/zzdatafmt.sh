# ----------------------------------------------------------------------------
# Muda o formato de uma data, com várias opções de personalização.
# Reconhece datas em vários formatos, como aaaa-mm-dd, dd.mm.aaaa e dd/mm.
# Obs.: Se você não informar o ano, será usado o ano corrente.
#
# Use a opção -f para mudar o formato de saída (o padrão é DD/MM/AAAA):
#
#      Código   Exemplo     Descrição
#      --------------------------------------------------------------
#      AAAA     2003        Ano com 4 dígitos
#      AA       03          Ano com 2 dígitos
#      A        3           Ano sem zeros à esquerda (1 ou 2 dígitos)
#      MM       02          Mês com 2 dígitos
#      M        2           Mês sem zeros à esquerda
#      DD       01          Dia com 2 dígitos
#      D        1           Dia sem zeros à esquerda
#      --------------------------------------------------------------
#      ANO      dois mil    Ano por extenso
#      MES      fevereiro   Nome do mês
#      MMM      fev         Nome do mês com três letras
#      DIA      vinte um    Dia por extenso
#
# Use as opções de idioma para alterar os nomes dos meses. Estas opções também
# mudam o formato padrão da data de saída, caso a opção -f não seja informada.
#     --pt para português     --de para alemão
#     --en para inglês        --fr para francês
#     --es para espanhol      --it para italiano
#
# Uso: zzdatafmt [-f formato] [data]
# Ex.: zzdatafmt 2011-12-31                 # 31/12/2011
#      zzdatafmt 31.12.11                   # 31/12/2011
#      zzdatafmt 31/12                      # 31/12/2011     (ano atual)
#      zzdatafmt -f MES hoje                # maio           (mês atual)
#      zzdatafmt -f MES --en hoje           # May            (em inglês)
#      zzdatafmt -f AAAA 31/12/11           # 2011
#      zzdatafmt -f MM/DD/AA 31/12/2011     # 12/31/11       (BR -> US)
#      zzdatafmt -f D/M/A 01/02/2003        # 1/2/3
#      zzdatafmt -f "D de MES" 01/05/95     # 1 de maio
#      echo 31/12/2011 | zzdatafmt -f MM    # 12             (via STDIN)
#      zzdatafmt 31 de jan de 2013          # 31/01/2013     (entrada textual)
#      zzdatafmt --de 19/03/2012            # 19. März 2012  (Das ist gut!)
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-24
# Versão: 9
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
	local meses_de='Januar Februar März April Mai Juni Juli August September Oktober November Dezember'
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
			--pt)
				meses=$meses_pt
				[ "$fmt" ] || fmt='DD de MES de AAAA'
				shift
			;;
			--ptt)
				meses=$meses_pt
				[ "$fmt" ] || fmt='DIA de MES de ANO'
				shift
			;;
			--de)
				meses=$meses_de
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

	# Converte datas estranhas para o formato brasileiro ../../..
	case "$data" in
		# apelidos
		hoje | ontem | anteontem | amanh[ãa])
			data=$(zzdata "$data")
		;;
		# data possivelmente em formato textual
		*[A-Za-z]*)
			# 31 de janeiro de 2013
			# 31 de jan de 2013
			# 31/jan/2013
			# 31-jan-2013
			# 31.jan.2013
			# 31 jan 2013

			# Primeiro converte tudo pra 31/jan/2013 ou 31/janeiro/2013
			data=$(echo "$data" | zzminusculas | sed 's| de |/|g' | tr ' .-' ///)

			# Agora converte o nome do mês para número
			mes=$(echo "$data" | cut -d / -f 2)
			mm=$(echo "$meses_pt" |
				zzminusculas |
				awk '{for (i=1;i<=NF;i++){ if (substr($i,1,3) == substr("'$mes'",1,3) ) printf "%02s\n", i}}')
			zztool testa_numero "$mm" && data=$(echo "$data" | sed "s/$mes/$mm/")
			unset mes mm
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
		mmm=$(echo "$mes" | sed 's/\(...\).*/\1/')

		# Percorre o formato e vai expandindo, da esquerda para a direita
		while test -n "$fmt"
		do
			# Atenção à ordem das opções do case: AAAA -> AAA -> AA
			# Sempre do maior para o menor para evitar matches parciais
			case "$fmt" in
				ANO*  )
					printf "$(zznumero --texto $aaaa)"
					fmt="${fmt#ANO}";;
				DIA*  )
					printf "$(zznumero --texto $dd)"
					fmt="${fmt#DIA}";;
				MES*  ) printf %s "$mes" ; fmt="${fmt#MES}";;
				AAAA* ) printf %s "$aaaa"; fmt="${fmt#AAAA}";;
				AA*   ) printf %s "$aa"  ; fmt="${fmt#AA}";;
				A*    ) printf %s "$a"   ; fmt="${fmt#A}";;
				MMM*  ) printf %s "$mmm" ; fmt="${fmt#MMM}";;
				MM*   ) printf %s "$mm"  ; fmt="${fmt#MM}";;
				M*    ) printf %s "$m"   ; fmt="${fmt#M}";;
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
