# ----------------------------------------------------------------------------
# Junta várias linhas em uma só, podendo escolher o início, fim e separador.
#
# Melhorias em relação ao comando paste -s:
# - Trata corretamente arquivos no formato Windows (CR+LF)
# - Lê arquivos ISO-8859-1 sem erros no Mac (o paste dá o mesmo erro do tr)
# - O separador pode ser uma string, não está limitado a um caractere
# - Opções -i e -f para delimitar somente um trecho a ser juntado
#
# Opções: -d sep        Separador a ser colocado entre as linhas (padrão: Tab)
#         -i, --inicio  Início do trecho a ser juntado (número ou regex)
#         -f, --fim     Fim do trecho a ser juntado (número ou regex)
#
# Uso: zzjuntalinhas [-d separador] [-i texto] [-f texto] arquivo(s)
# Ex.: zzjuntalinhas arquivo.txt
#      zzjuntalinhas -d @@@ arquivo.txt             # junta toda as linhas
#      zzjuntalinhas -d : -i 10 -f 20 arquivo.txt   # junta linhas 10 a 20
#      zzjuntalinhas -d : -i 10 arquivo.txt         # junta linha 10 em diante
#      cat /etc/named.conf | zzjuntalinhas -d '' -i '^[a-z]' -f '^}'
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-02
# Versão: 3
# Licença: GPL
# Requisitos: zzdos2unix
# ----------------------------------------------------------------------------
zzjuntalinhas ()
{
	zzzz -h juntalinhas "$1" && return

	local separador=$(printf '\t')  # tab
	local inicio='1'
	local fim='$'

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-d           ) separador="$2"; shift; shift;;
			-i | --inicio) inicio="$2"   ; shift; shift;;
			-f | --fim   ) fim="$2"      ; shift; shift;;
			*) break ;;
		esac
	done

	# Formata dados para o sed
	inicio=$(zztool endereco_sed "$inicio")
	fim=$(zztool endereco_sed "$fim")
	separador=$(echo "$separador" | sed 's:/:\\\/:g')

	# Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" |
		zzdos2unix |
		sed "
			# Exceção: Início e fim na mesma linha, mostra a linha e pronto
			$inicio {
				$fim {
					p
					d
				}
			}

			# O algoritmo é simples: ao entrar no trecho escolhido ($inicio)
			# vai guardando as linhas. Quando chegar no fim do trecho ($fim)
			# faz a troca das quebras de linha pelo $separador.

			$inicio, $fim {
				H
				$fim {
					s/.*//
					x
					s/^\n//
					s/\n/$separador/g
					p
					d
				}

				# Exceção: Não achei $fim e estou na última linha.
				# Este trecho não será juntado.
				$ {
					x
					s/^\n//
					p
				}

				d
			}"
}
