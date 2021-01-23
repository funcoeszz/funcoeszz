# ----------------------------------------------------------------------------
# Mostra uma tela de ajuda com explicação e sintaxe de todas as funções.
# Opções: --lista  lista de todas as funções, com sua descrição
#         --uso    resumo de todas as funções, com a sintaxe de uso
# Uso: zzajuda [--lista|--uso]
# Ex.: zzajuda
#      zzajuda --lista
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-05-04
# Versão: 1
# Requisitos: zzzz zztool
# ----------------------------------------------------------------------------
zzajuda ()
{
	zzzz -h ajuda "$1" && return

	local zzcor_pager

	if test ! -r "$ZZAJUDA"
	then
		echo "Ops! Não encontrei o texto de ajuda em '$ZZAJUDA'." >&2
		echo "Para recriá-lo basta executar o script 'funcoeszz' sem argumentos." >&2
		return
	fi

	case "$1" in
		--uso)
			# Lista com sintaxe de uso, basta pescar as linhas Uso:
			sed -n 's/^Uso: zz/zz/p' "$ZZAJUDA" |
				sort |
				zztool acha '^zz[^ ]*'
		;;
		--lista)
			# Lista de todas as funções no formato: nome descrição
			grep -A2 ^zz "$ZZAJUDA" |
				grep -v ^http |
				sed '
					/^zz/ {
						# Padding: o nome deve ter 17 caracteres
						# Maior nome: zzfrenteverso2pdf
						:pad
						s/^.\{1,16\}$/& /
						t pad

						# Junta a descricao (proxima linha)
						N
						s/\n/ /
					}' |
				grep ^zz |
				sort |
				zztool acha '^zz[^ ]*'
		;;
		*)
			# Desliga cores para os paginadores antigos
			test "$PAGER" = 'less' -o "$PAGER" = 'more' && zzcor_pager=0

			# Mostra a ajuda de todas as funções, paginando
			cat "$ZZAJUDA" |
				ZZCOR=${zzcor_pager:-$ZZCOR} zztool acha 'zz[a-z0-9]\{2,\}' |
				${PAGER:-less -r}
		;;
	esac
}
