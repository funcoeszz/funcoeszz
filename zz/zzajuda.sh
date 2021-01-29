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
		zz*)
			local func="$1"

			if test -n "$ZZDIR"
			then
				zzzz extrair-ajuda "${ZZDIR}/$func.sh" |
					# Insere o nome da função na segunda linha
					sed "2 { h; s/.*/$func/; G; }"
			else
			# TODO como lidar com o tudo-em-um ?
			# se guardar no tmp um arquivo por funcao pra ajuda, posso fazer $(cd TMPDIR/; cat $(zzzz --lista ligadas)) pra mostrar o help global, ou simplesmente `cat TMPDIR/$func` pro help individual
				cat TMPDIR/$func
			fi |
				zztool acha 'zz[a-z0-9]\{2,\}'

		;;
		*)
			# Desliga cores para os paginadores antigos
			test "$PAGER" = 'less' -o "$PAGER" = 'more' && zzcor_pager=0


			# aí posso iterar e obter as ajudas
			# zzzz --lista {todas,ligadas,desligadas}
			# Note que hoje o texto de ajuda é a database das funcoes ligadas (levando em consideração ZZOFF)
			# Se eu for mudar isso, tenho que garantir que em todos os pontos a lista correta é usada e a ajuda correta é usada
			#
			# quando tem ZZDIR, fica fácil mostrar o help de cada função, ou de todas.
			# quando é tudo-em-um, vou precisar de algo custom. Na zzzz no final tem código que extrai a lista de funções ativas da shell atual. pra compor a ajuda, terei que rodar a atual _extrai_ajuda no arquivo tudo-em-um (que pode não ter mais seu path disponível, afinal as funções já foram carregadas na memória -- aí o arquivo no tmp é vantagem)

			# Mostra a ajuda de todas as funções, paginando
			zzzz listar todas |
				while read -r func
				do
					# Remove última linha pra evitar linha separadora duplicada
					zzajuda "$func" | sed '$ d'
				done |
				ZZCOR=${zzcor_pager:-$ZZCOR} zztool acha 'zz[a-z0-9]\{2,\}' |
				${PAGER:-less -r}
		;;
	esac
}
