#!/bin/bash
# 2010-12-21
# Aurelio Jargas
#
# Verifica se as funções estão dentro dos padrões
# Uso: nanny.sh

cd "$(dirname "$0")/.." || exit 1  # go to repo root

exit_code=0
tab=$(printf '\t')

eco() {
    echo -e "\033[36;1m$*\033[m"
}

check() {  # $1=name, $2=wrong
	if test -n "$2"
	then
		eco ----------------------------------------------------------------
		eco "* $1"
		echo "$2"
		exit_code=1
	fi
}

### Testes relacionados ao arquivo e sua estrutura básica

check "Funções que não são UTF-8" "$(
	file --mime zz/*.sh off/*.sh |
	grep -vi 'utf-8'
)"

check "Funções com nome de arquivo inválido" "$(
	ls -1 zz/*.sh off/*.sh |
	grep -v '/zz[a-z0-9]*\.sh$'
)"

check "Funções com erro ao importar (source)" "$(
	for f in zz/*.sh off/*.sh
	do
		(source "$f" 2>&1)
	done
)"

check "Funções cujo início não é 'zznome ()\\\n'" "$(
	for f in zz/*.sh off/*.sh
	do
		grep "^zz[a-z0-9]* ()$" "$f" >/dev/null || echo "$f"
	done
)"

check "Funções que não terminam em '}' na última linha" "$(
	for f in zz/*.sh off/*.sh
	do
		tail -1 "$f" | grep "^}$" >/dev/null || echo "$f"
	done
)"

check "Funções que falta a quebra de linha na última linha" "$(
	for f in zz/*.sh off/*.sh
	do
		tail -1 "$f" | od -a | grep '}.*nl' >/dev/null || echo "$f"
	done
)"

check "Funções cujo nome não bate com o nome do arquivo" "$(
	for f in zz/*.sh off/*.sh
	do
		grep "^$(basename "$f" .sh) " "$f" >/dev/null || echo "$f"
	done
)"


### Testes relacionados ao cabeçalho

check "Funções com o cabeçalho mal formatado" "$(
	for f in zz/*.sh off/*.sh
	do
		wrong=$(sed -n '

			# Script sed que vai lendo o cabeçalho linha a linha e
			# verifica se ele está no formato padrão, com as linhas
			# ao redor e com os campos na ordem correta.
			# Checa apenas o nome e posição do campo, não seu conteúdo.

			1 {
				# -----------------------------
				/^# -\{76\}$/! { s/^/Esperava -----------, veio /p; q; }
			}
			2 {
				# Um http:// é opcional na linha 2
				/^# http:/ n

				# Depois vem texto sem forma, que é a descrição
				# Pode durar várias linhas
				:loop

				# Se chegou no fim do arquivo, deu pau
				$ { s/^/Esperava Uso: …, veio EOF: /p; q; }

				# Se encontrar algum outro campo aqui, reclame
				/^# Autor: /      { s/^/Deveria vir depois dos exemplos -- /p; q; }
				/^# Desde: /      { s/^/Deveria vir depois dos exemplos -- /p; q; }
				/^# Versão: /     { s/^/Deveria vir depois dos exemplos -- /p; q; }
				/^# Requisitos: / { s/^/Deveria vir depois dos exemplos -- /p; q; }
				/^# Tags: /       { s/^/Deveria vir depois dos exemplos -- /p; q; }

				n

				# Só sai do loop quando chegar no campo Uso, obrigatório
				/^# Uso: /b loopend
				b loop
				:loopend
				n

				# Depois do Uso vem Ex.:, obrigatório
				/^# Ex\.: /! { s/^/Esperava Ex.: …, veio /p; q; }
				n

				# O exemplo pode durar várias linhas, iniciadas por espaços
				:loopexem
				/^#      [^ ]/ {
					n
					b loopexem
				}

				# Então vem uma linha em branco para separar
				/^#$/! { s/^/Esperava um # sozinho após os exemplos, veio /p; q; }
				n

				# Campos obrigatórios em sequencia
				/^# Autor: /! { s/^/Esperava Autor: …, veio /p; q; }
				n
				/^# Desde: /! { s/^/Esperava Desde: …, veio /p; q; }
				n
				/^# Versão: / ! { s/^/Esperava Versão: …, veio /p; q; }
				n

				# Mais campos opcionais no final
				/^# Requisitos: / n
				/^# Tags: / n
				/^# Nota: / n

				# -----------------------------
				/^# -\{76\}$/! { s/^/Esperava -----------, veio /p; q; }
			}' "$f")
			test -n "$wrong" && printf "%s: %s\n" "$f" "$wrong"
	done
)"

check "Funções cuja linha separadora é estranha" "$(
	for f in zz/*.sh off/*.sh
	do
		test "$(grep -Ec '^# -{76}$' "$f")" = 2 || echo "$f"
	done
)"

check "Funções com a descrição sem ponto final" "$(
	for f in zz/*.sh off/*.sh
	do
		wrong=$(sed -n '2 {
			/^# http/ n
			# Deve acabar em ponto final
			/\.$/! p
			}' "$f")
		test -n "$wrong" && echo "$f: $wrong"
	done
)"

check "Funções com a descrição com mais de um ponto ." "$(
	for f in zz/*.sh off/*.sh
	do
		test "$f" = off/zzranking.sh && continue  # tem 2 pontos mas é OK
		wrong=$(sed -n '2 {
			/^# http/ n
			# Pontos no meio da frase
			/\. .*\./ p
			}' "$f")
		test -n "$wrong" && echo "$f: $wrong"
	done
)"

check "Funções com conteúdo inválido no campo Autor:" "$(
	for f in zz/*.sh off/*.sh
	do
		wrong=$(
			grep '^# Autor:' "$f" |
			grep -Ev '^# Autor: [^ ].*$'
		)
		test -n "$wrong" && echo "$f: $wrong"
	done
)"

check "Funções com a data inválida no campo Desde:" "$(
	for f in zz/*.sh off/*.sh
	do
		wrong=$(
			grep '^# Desde:' "$f" |
			grep -Ev '^# Desde: [0-9]{4}-[0-9]{2}-[0-9]{2}$'
		)
		test -n "$wrong" && echo "$f: $wrong"
	done
)"

check "Funções com número inválido no campo Versão: (deve ser decimal)" "$(
	for f in zz/*.sh  #off/*.sh
	do
		wrong=$(
			grep '^# Versão:' "$f" |
			grep -Ev '^# Versão: [0-9][0-9]?$'
		)
		test -n "$wrong" && echo "$f: $wrong"
	done
)"

check "Funções com o campo inválido Licença:" "$(
	for f in zz/*.sh
	do
		wrong=$(grep '^# Licença:' "$f")
		test -n "$wrong" && echo "$f: $wrong"
	done
)"

check "Funções com campo Requisitos: vazio" "$(
	for f in zz/*.sh off/*.sh
	do
		grep '^# Requisitos: *$' "$f" > /dev/null && echo "$f"
	done
)"

check "Funções com vírgulas no campo Requisitos: (use só espaços)" "$(
	for f in zz/*.sh off/*.sh
	do
		grep '^# Requisitos:.*,' "$f" > /dev/null && echo "$f"
	done
)"

check "Funções com cabeçalho >78 colunas" "$(
	for f in zz/*.sh off/*.sh
	do
		grep '^# ' "$f" | grep -E '^.{79}' |
		grep -v DESATIVADA: |
		grep -v '^# Requisitos:' |
		# Insere o path do arquivo no início da linha
		sed "s|^|$f: |" |
		# Exceções pontuais
		grep -v '^zz/zzloteria\.sh: # Resultados da quina' |
		grep -v '^zz/zzpalpite\.sh: # quina, megasena,' |
		grep -v '^zz/zzpalpite\.sh: # Uso: zzpalpite'
	done
)"

check "Funções com cabeçalho usando TAB (use só espaços)" "$(
	grep -H "^#.*$tab" zz/*.sh off/*.sh
)"

### Desativada por enquanto, ainda não sei o que fazer com isso
#
# campos='Obs\.|Opções|Uso|Ex\.|Autor|Desde|Versão|Requisitos|Nota'
# check "Funções com campo desconhecido" "$(
# 	for f in zz/*.sh off/*.sh
# 	do
# 		wrong=$(
# 			grep -E '^# [A-Z][a-z.]+: ' "$f" |
# 			cut -d : -f 1 |
# 			sed 's/^# //' |
# 			grep -Ev "$campos" |
# 			sed 1q)  # só mostra o primeiro pra não poluir
# 		test -n "$wrong" && echo "$f: $wrong"
# 	done
# )"
#


### Testes relacionados ao ambiente ZZ

check "Funções que não usam 'zzzz -h'" "$(
	for f in zz/*.sh  # off/*.sh
	do
		grep 'zzzz -h ' "$f" >/dev/null || echo "$f"
	done
)"

check "Funções cuja chamada 'zzzz -h' está incorreta" "$(
	for f in zz/*.sh  # off/*.sh
	do
		# zzzz lida com seu próprio -h
		# zzzz -h cores $1 && return
		test "$f" = zz/zzzz.sh && continue

		grep -F "zzzz -h $(basename "$f" .sh |
		sed 's/^zz//') \"\$1\" && return" "$f" >/dev/null || echo "$f"
	done
)"

check "Funções com o nome errado em 'zztool uso'" "$(
	for f in zz/*.sh  # off/*.sh
	do
		wrong=$(
			grep -E 'zztool( -e)? uso ' "$f" |
			grep -Ev "zztool( -e)? uso $(basename "$f" .sh | sed 's/^zz//')"
		)
		test -n "$wrong" && echo "$f"  # && echo "$wrong"
	done
)"

check "Funções desativadas sem data e motivo para o desligamento" "$(
	for f in off/*.sh
	do
		# # DESATIVADA: 2002-10-30 O programa acabou.
		grep -E '^# DESATIVADA: [0-9]{4}-[0-9]{2}-[0-9]{2} .{10,}' "$f" >/dev/null || echo "$f"
	done
)"


### Testes de segurança

check "Funções que não colocaram aspas ao redor de \$ZZTMP" "$(
	grep -F '$ZZTMP' zz/*.sh off/*.sh |
	grep -v '"'
)"

# https://github.com/funcoeszz/funcoeszz/wiki/Arquivos-Temporarios
check "Funções que usaram nome inválido em \$ZZTMP.nome" "$(
	grep -F '$ZZTMP' zz/*.sh |
	grep -Ev '^zz/zz([^.]*)\.sh:.*\$ZZTMP\.\1' |
	# Exceções conhecidas
	grep -Ev '^zz/zz(tool|zz)\.sh:'
)"


exit $exit_code

# Outros:
#
# Verifica (visualmente) se há Uso: no texto de ajuda de todas as funções
# cat $ZZTMP.ajuda | grep -E '^zz[^ ]*$|^Uso:' | sed 'N;s/\n/ - /'
