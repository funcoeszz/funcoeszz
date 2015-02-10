# ----------------------------------------------------------------------------
# Gera uma senha aleatória de N caracteres.
# Obs.: Sem opções, a senha é gerada usando letras e números
#
# Opções: -p, --pro   Usa letras, números e símbolos para compor a senha
#         -n, --num   Usa somente números para compor a senha
#         -u, --uniq  Gera senhas com caracteres únicos (não repetidos) 
#
# Uso: zzsenha [--pro|--num] [n]     (padrão n=8)
# Ex.: zzsenha
#      zzsenha 10
#      zzsenha --num 9
#      zzsenha --pro 30
#      zzsenha --uniq 10
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2002-11-07
# Versão: 3
# Licença: GPL
# Requisitos: zzaleatorio
# ----------------------------------------------------------------------------
zzsenha ()
{
	zzzz -h senha "$1" && return

	local posicao letra senha
	local n=8
	local alpha='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
	local num='0123456789'
	local pro='-/:;()$&@.,?!'  # teclado do iPhone, exceto aspas
	local lista="$alpha$num"   # senha padrão: letras e números
	local maximo=8             # usado para --uniq

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-p | --pro)  shift; lista="$alpha$num$pro";;
			-n | --num)  shift; lista="$num";;
			-u | --uniq) shift; local uniq=1;;
			*) break ;;
		esac
	done

	# atualiza maximo para ser usado para --uniq
	[ "$uniq" ] && maximo="${#lista}"

	# Guarda o número informado pelo usuário (se existente)
	[ "$1" ] && n="$1"

	# Foi passado um número mesmo?
	zztool -e testa_numero "$n" || return 1

	# Caso não repetita caracteres, existe uma limitação no tamanho
	# $maximo somente será maior que 8 caso solicitado via --uniq
	if [ "$maximo" -gt 8  -a "$n" -gt "$maximo" ]
	then
		echo "O tamanho máximo desse tipo de senha é $maximo"
		return 1
	fi

	# Esquema de geração da senha:
	# A cada volta é escolhido um número aleatório que indica uma
	# posição dentro do $lista. A letra dessa posição é mostrada na
	# tela.
	while [ "$n" -ne 0 ]
	do
		n=$((n-1))
		posicao=$(zzaleatorio 1 ${#lista})
		letra=$(printf "$lista" | cut -c "$posicao")
		[ "$maximo" -gt 8 ] && lista=$(echo "$lista" | tr -d "$letra")
		senha="$senha$letra"
	done

	# Mostra a senha
	echo "$senha"
}
