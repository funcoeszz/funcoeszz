# ----------------------------------------------------------------------------
# Mostra a diferença entre dois textos, palavra por palavra.
# Útil para conferir revisões ortográficas ou mudanças pequenas em frases.
# Obs.: Se tiver muitas *linhas* diferentes, use o comando diff.
# Uso: zzdiffpalavra arquivo1 arquivo2
# Ex.: zzdiffpalavra texto-orig.txt texto-novo.txt
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2001-07-23
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzdiffpalavra ()
{
	zzzz -h diffpalavra "$1" && return

	local esc
	local tmp1="$ZZTMP.diffpalavra.$$.1"
	local tmp2="$ZZTMP.diffpalavra.$$.2"
	local n=$(printf '\a')

	# Verificação dos parâmetros
	[ $# -ne 2 ] && { zztool uso diffpalavra; return 1; }

	# Verifica se os arquivos existem
	zztool arquivo_legivel "$1" || return
	zztool arquivo_legivel "$2" || return

	# Deixa uma palavra por linha e marca o início de parágrafos
	sed "s/^[[:blank:]]*$/$n$n/;" "$1" | tr ' ' '\n' > "$tmp1"
	sed "s/^[[:blank:]]*$/$n$n/;" "$2" | tr ' ' '\n' > "$tmp2"

	# Usa o diff para comparar as diferenças e formata a saída,
	# agrupando as palavras para facilitar a leitura do resultado
	diff -U 100 "$tmp1" "$tmp2" |
		sed 's/^ /=/' |
		sed '
			# Script para agrupar linhas consecutivas de um mesmo tipo.
			# O tipo da linha é o seu primeiro caractere. Ele não pode
			# ser um espaço em branco.
			#     +um
			#     +dois
			#     .one
			#     .two
			# vira:
			#     +um dois
			#     .one two

			# Apaga os cabeçalhos do diff
			1,3 d

			:join

			# Junta linhas consecutivas do mesmo tipo
			N

			# O espaço em branco é o separador
			s/\n/ /

			# A linha atual é do mesmo tipo da anterior?
			/^\(.\).* \1[^ ]*$/ {

				# Se for a última linha, mostra tudo e sai
				$ s/ ./ /g
				$ q

				# Caso contrário continua juntando...
				b join
			}
			# Opa, linha diferente (antiga \n antiga \n ... \n nova)

			# Salva uma cópia completa
			h

			# Apaga a última linha (nova) e mostra as anteriores
			s/\(.*\) [^ ]*$/\1/
			s/ ./ /g
			p

			# Volta a cópia, apaga linhas antigas e começa de novo
			g
			s/.* //
			$ !b join
			# Mas se for a última linha, acabamos por aqui' |
		sed 's/^=/ /' |

		# Restaura os parágrafos
		tr "$n" '\n' |

		# Podemos mostrar cores?
		if [ "$ZZCOR" = 1 ]
		then
			# Pinta as linhas antigas de vermelho e as novas de azul
			esc=$(printf '\033')
			sed "
				s/^-.*/$esc[31;1m&$esc[m/
				s/^+.*/$esc[36;1m&$esc[m/"
		else
			# Sem cores? Que chato. Só mostra então.
			cat -
		fi

	rm -f "$tmp1" "$tmp2"
}
