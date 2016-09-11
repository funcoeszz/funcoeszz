# ----------------------------------------------------------------------------
# Combina 2 arquivos, frentes.pdf e versos.pdf, em um único frenteverso.pdf.
# Nota: requer o programa "pdftk"!
# Opções:
#   -rf, --frentesreversas  informa ordem reversa no arquivo frentes.pdf.
#   -rv, --versosreversos   informa ordem reversa no arquivo versos.pdf.
#    -d, --diretorio        informa o diretório de entrada/saída. Padrão=".".
#    -v, --verbose          exibe informações de debug durante a execução.
# Uso: zzfrenteverso2pdf [-rf] [-rv] [-d diretorio]
# Ex.: zzfrenteverso2pdf
#      zzfrenteverso2pdf -rf
#      zzfrenteverso2pdf -rv -d "/tmp/dir_teste"
#
# Autor: Lauro Cavalcanti de Sa <laurocdesa (a) gmail com>
# Desde: 2009-09-17
# Versão: 4
# Licença: GPLv2
# ----------------------------------------------------------------------------
zzfrenteverso2pdf ()
{
	zzzz -h frenteverso2pdf "$1" && return

	# Declara variaveis.
	local n_frentes n_versos dif n_pag_frente n_pag_verso
	local sinal_frente="+"
	local sinal_verso="+"
	local dir="."
	local arq_frentes="frentes.pdf"
	local arq_versos="versos.pdf"
	local ini_frente=0
	local ini_verso=0
	local numberlist=""
	local n_pag=1

	# Determina o diretorio que estao os arquivos a serem mesclados.
	# Opcoes de linha de comando
	while test $# -ge 1
	do
		case "$1" in
			-rf | --frentesreversas) sinal_frente="-" ;;
			-rv | --versosreversos) sinal_verso="-" ;;
			-d | --diretorio)
				test -n "$2" || { zztool -e uso frenteverso2pdf; return 1; }
				dir=$2
				shift
				;;
			-v | --verbose)
				set -x
				;;
			--) shift; break ;;
			*) { zztool -e uso frenteverso2pdf; set +x; return 1; } ;;
		esac
		shift
	done

	# Verifica se os arquivos existem.
	if test ! -s "$dir/$arq_frentes" -o ! -s "$dir/$arq_versos" ; then
		zztool erro "ERRO: Um dos arquivos $dir/$arq_frentes ou $dir/$arq_versos nao existe!"
		return 1
	fi

	# Verifica se pdftk existe.
	if ! [ -x "$(command -v pdftk)" ]; then
		zztool erro "ERRO: pdftk nao esta instalado!"
		return 2
	fi

	# Determina o numero de paginas de cada arquivo.
	n_frentes=`pdftk "$dir/$arq_frentes" dump_data | grep "NumberOfPages" | cut -d" " -f2`
	n_versos=`pdftk "$dir/$arq_versos" dump_data | grep "NumberOfPages" | cut -d" " -f2`

	# Verifica a compatibilidade do numero de paginas entre os dois arquivos.
	dif=`expr $n_frentes - $n_versos`
	if test $dif -lt 0 -o $dif -gt 1 ; then
		echo "CUIDADO: O numero de paginas dos arquivos nao parecem compativeis!"
	fi

	# Cria ordenacao das paginas.
	if test "$sinal_frente" = "-" ; then
		ini_frente=`expr $n_frentes + 1`
	fi
	if test "$sinal_verso" = "-" ; then
		ini_verso=`expr $n_versos + 1`
	fi

	while test $n_pag -le $n_frentes ; do
		n_pag_frente=`expr $ini_frente $sinal_frente $n_pag`
		numberlist="$numberlist A$n_pag_frente"
		n_pag_verso=`expr $ini_verso $sinal_verso $n_pag`
		if test $n_pag -le $n_versos; then
			numberlist="$numberlist B$n_pag_verso"
		fi
		n_pag=$(($n_pag + 1))
	done

	# Cria arquivo mesclado.
	pdftk A="$dir/$arq_frentes" B="$dir/$arq_versos" cat $numberlist output "$dir/frenteverso.pdf" dont_ask

}
