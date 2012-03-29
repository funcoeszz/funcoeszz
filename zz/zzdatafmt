# ----------------------------------------------------------------------------
# Muda o formato de uma data, com várias opções de personalização.
# Reconhece datas em vários formatos, como aaaa-mm-dd, dd.mm.aaaa e dd/mm.
# Obs.: Se você não informar o ano, será usado o ano corrente.
# Use a opção -f para mudar o formato de saída (o padrão é DD/MM/AAAA):
#
#      Código   Exemplo     Descrição
#      --------------------------------------
#      AAAA     2003        Ano com 4 dígitos
#      AA       03          Ano com 2 dígitos
#      A        3           Ano sem zeros à esquerda (1 ou 2 dígitos)
#      MES      fevereiro   Nome do mês
#      MM       02          Mês com 2 dígitos
#      M        2           Mês sem zeros à esquerda
#      DD       01          Dia com 2 dígitos
#      D        1           Dia sem zeros à esquerda
#
# Uso: zzdatafmt [-f formato] [data]
# Ex.: zzdatafmt 2011-12-31                 # 31/12/2011
#      zzdatafmt 31.12.11                   # 31/12/2011
#      zzdatafmt 31/12                      # 31/12/2011 (ano atual)
#      zzdatafmt -f MES hoje                # maio (mês atual)
#      zzdatafmt -f AAAA 31/12/11           # 2011
#      zzdatafmt -f MM/DD/AA 31/12/2011     # 12/31/11
#      zzdatafmt -f D/M/A 01/02/2003        # 1/2/3
#      zzdatafmt -f "D de MES" 01/05/95     # 1 de maio
#      echo 31/12/2011 | zzdatafmt -f MM    # 12 (via STDIN)
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-24
# Versão: 1
# Licença: GPL
# Requisitos: zzdata
# Tags: data
# ----------------------------------------------------------------------------
zzdatafmt ()
{
	zzzz -h datafmt "$1" && return

	local data data_orig fmt ano mes dia aaaa aa mm dd a m d ano_atual
	local meses='janeiro fevereiro março abril maio junho julho agosto setembro outubro novembro dezembro'

	# Opção de linha de comando
	if test "$1" = '-f'
	then
		fmt="$2"
		shift
		shift
	fi

	# Data via STDIN ou argumentos
	data=$(zztool multi_stdin "$@")
	data_orig="$data"

	# Converte datas estranhas para o formato brasileiro ../../..
	case "$data" in
		# apelidos
		hoje|ontem|anteontem|amanh[ãa])
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

		echo "$fmt" | sed "
			s/AAAA/$aaaa/g;
			s/AA/$aa/g;
			s/A/$a/g;
			s/MES/$mes/g;
			s/MM/$mm/g;
			s/M/$m/g;
			s/DD/$dd/g;
			s/D/$d/g;
			"
	# Senão, é só mostrar no formato normal
	else
		echo "$data"
	fi
}
