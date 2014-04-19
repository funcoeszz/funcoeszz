#!/bin/bash
# 2010-12-21
# Aurelio Marinho Jargas
#
# Verifica se as funções estão dentro dos padrões
# Uso: nanny.sh

cd $(dirname "$0")
cd ..

eco() { echo -e "\033[36;1m$*\033[m"; }

### Testes relacionados ao arquivo e sua estrutura básica

eco ----------------------------------------------------------------
eco "* Funções que não são UTF-8"
file --mime zz/* off/* | egrep -vi 'utf-8'

eco ----------------------------------------------------------------
eco "* Funções com nome de arquivo inválido"
ls -1 zz/* off/* | grep -v '/zz[a-z0-9]*\.sh$'

eco ----------------------------------------------------------------
eco "* Funções com erro ao importar (source)"
for f in zz/* off/*; do (source $f); done

eco ----------------------------------------------------------------
eco "* Funções cujo início não é 'zznome ()\\\n'"
for f in zz/* off/*; do grep "^zz[a-z0-9]* ()$" $f >/dev/null || echo $f; done

eco ----------------------------------------------------------------
eco "* Funções que não terminam em '}' na última linha"
for f in zz/* off/*; do tail -1 $f | grep "^}$" >/dev/null || echo $f; done

eco ----------------------------------------------------------------
eco "* Funções que falta a quebra de linha na última linha"
for f in zz/* off/*; do tail -1 $f | od -a | grep '}.*nl' >/dev/null || echo $f; done

eco ----------------------------------------------------------------
eco "* Funções cujo nome não bate com o nome do arquivo"
for f in zz/* off/*; do grep "^$(basename $f .sh) " $f >/dev/null || echo $f; done


### Testes relacionados ao cabeçalho

eco ----------------------------------------------------------------
eco "* Funções com o cabeçalho mal formatado"
for f in zz/* off/*
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
			/^# Licença: /    { s/^/Deveria vir depois dos exemplos -- /p; q; }
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
			/^# Licença: /! { s/^/Esperava Licença: …, veio /p; q; }
			n

			# Mais campos opcionais no final
			/^# Requisitos: / n
			/^# Tags: / n
			/^# Nota: / n

			# -----------------------------
			/^# -\{76\}$/! { s/^/Esperava -----------, veio /p; q; }
		}' $f)
		test -n "$wrong" && printf "%s: %s\n" $f "$wrong"
done

eco ----------------------------------------------------------------
eco "* Funções cuja linha separadora é estranha"
for f in zz/* off/*; do test $(egrep -c '^# -{76}$' $f) = 2 || echo $f; done

eco ----------------------------------------------------------------
eco "* Funções com a descrição sem ponto final"
for f in zz/* off/*; do
	wrong=$(sed -n '2 {
		/^# http/ n
		# Deve acabar em ponto final
		/\.$/! p
		}' $f)
	test -n "$wrong" && echo "$f: $wrong"
done

eco ----------------------------------------------------------------
eco "* Funções com a descrição com mais de um ponto ."
for f in zz/* off/*; do
	test "$f" = off/zzranking.sh && continue  # tem 2 pontos mas é OK
	wrong=$(sed -n '2 {
		/^# http/ n
		# Pontos no meio da frase
		/\. .*\./ p
		}' $f)
	test -n "$wrong" && echo "$f: $wrong"
done

eco ----------------------------------------------------------------
eco "* Funções com conteúdo inválido no campo Autor:"
for f in zz/* off/*
do
	wrong=$(grep '^# Autor:' $f | egrep -v '^# Autor: [^ ].*$')
	test -n "$wrong" && echo "$f: $wrong"
done

eco ----------------------------------------------------------------
eco "* Funções com a data inválida no campo Desde:"
for f in zz/* off/*
do
	wrong=$(grep '^# Desde:' $f | egrep -v '^# Desde: [0-9]{4}-[0-9]{2}-[0-9]{2}$')
	test -n "$wrong" && echo "$f: $wrong"
done

eco ----------------------------------------------------------------
eco "* Funções com número inválido no campo Versão: (deve ser decimal)"
for f in zz/*  #off/*
do
	wrong=$(grep '^# Versão:' $f | egrep -v '^# Versão: [0-9][0-9]?$')
	test -n "$wrong" && echo "$f: $wrong"
done

eco ----------------------------------------------------------------
eco "* Funções com conteúdo inválido no campo Licença:"
for f in zz/* off/*
do
	wrong=$(grep '^# Licença:' $f | egrep -v '^# Licença: (GPL(v2)?|MIT)$')
	# Se alguém quiser usar outra licença, basta adicionar aqui ^
	test -n "$wrong" && echo "$f: $wrong"
done

eco ----------------------------------------------------------------
eco "* Funções com campo Requisitos: vazio"
for f in zz/* off/*
do
	grep '^# Requisitos: *$' $f > /dev/null && echo $f
done

eco ----------------------------------------------------------------
eco "* Funções com vírgulas no campo Requisitos: (use só espaços)"
for f in zz/* off/*
do
	grep '^# Requisitos:.*,' $f > /dev/null && echo $f
done

eco ----------------------------------------------------------------
eco "* Funções com cabeçalho >78 colunas"
for f in zz/* off/*
do
	wrong=$(grep '^# ' $f | egrep '^.{79}' | grep -v DESATIVADA:)

	test -n "$wrong" && printf "%s: %s\n" $f "$wrong" |
		# Exceções conhecidas
		grep -v '^zz/zzferiado.sh: # Requisitos:' |
		grep -v '^zz/zzloteria2.sh: # Resultados da quina' |
		grep -v '^zz/zzpais.sh: # http://pt.wikipedia.org' |
		grep -v 'zz/zzpalpite.sh: # Uso: zzpalpite' |
		grep -v 'zz/zzxml.sh: # Uso: zzxml'
done

### Desativada por enquanto, ainda não sei o que fazer com isso
#
# eco ----------------------------------------------------------------
# eco "* Funções com campo desconhecido"
# campos='Obs\.|Opções|Uso|Ex\.|Autor|Desde|Versão|Licença|Requisitos|Nota'
# for f in zz/* off/*
# do
# 	wrong=$(
# 		egrep '^# [A-Z][a-z.]+: ' $f |
# 		cut -d : -f 1 |
# 		sed 's/^# //' |
# 		egrep -v "$campos" |
# 		sed 1q)  # só mostra o primeiro pra não poluir
# 	test -n "$wrong" && echo "$f: $wrong"
# done
#


### Testes relacionados ao ambiente ZZ

eco ----------------------------------------------------------------
eco "* Funções que não usam 'zzzz -h'"
ok="zztool"
for f in zz/*  # off/*
do
	echo " $ok " | grep " $(basename $f) " >/dev/null && continue
	grep 'zzzz -h ' $f >/dev/null || echo $f
done

eco ----------------------------------------------------------------
eco "* Funções cuja chamada 'zzzz -h' está incorreta"
for f in zz/*  # off/*
do
	# zzzz -h cores $1 && return
	fgrep "zzzz -h $(basename $f .sh | sed 's/^zz//') \"\$1\" && return" $f >/dev/null || echo $f
done

eco ----------------------------------------------------------------
eco "* Funções que não usam 'zztool uso'"
# As seguintes não precisam pois é válido chamá-las sem argumentos
ok="zzaleatorio zzalfabeto zzansi2html zzarrumacidade zzascii zzbeep zzbissexto zzbolsas zzbraille zzcalcula zzcapitalize zzcaracoroa zzcarnaval zzcidade zzcinemark15h zzcineuci zzcnpj zzcontapalavras zzcores zzcorpuschristi zzcotacao zzcpf zzdado zzdatafmt zzdiadasemana zzdolar zzdos2unix zzestado zzeuro zzferiado zzfilme zzfoneletra zzglobo zzhexa2str zzhoracerta zzhoramin zzhorariodeverao zzipinternet zzjquery zzjuntalinhas zzkill zzlembrete zzlimpalixo zzlinha zzlinux zzlinuxnews zzloteria zzloteria2 zzlua zzmaiores zzmaiusculas zzmariadb zzmd5 zzminusculas zzmoeda zzmoneylog zznatal zznoticias zznoticiaslinux zznoticiassec zzpais zzpalpite zzpascoa zzpgsql zzphp zzpiada zzppt zzramones zzranking zzrelansi zzrot13 zzrot47 zzsecurity zzsemacento zzsenha zzsextapaixao zzshuffle zzstr2hexa zzsubway zztabuada zztac zztelecine zztempo zztranspor zztv zztwitter zzunescape zzunicode2ascii zzuniq zzunix2dos zzvdp zzvira zzxml"
for f in zz/*  # off/*
do
	echo " $ok " | grep " $(basename $f .sh) " >/dev/null && continue
	grep 'zztool uso ' $f >/dev/null || echo $f
done

eco ----------------------------------------------------------------
eco "* Funções com o nome errado em 'zztool uso'"
for f in zz/*  # off/*
do
	wrong=$(grep 'zztool uso ' $f | grep -v "zztool uso $(basename $f .sh | sed 's/^zz//')")
	test -n "$wrong" && echo "$f"  # && echo "$wrong"
done

eco ----------------------------------------------------------------
eco "* Funções desativadas sem data e motivo para o desligamento"
for f in off/*
do
	# # DESATIVADA: 2002-10-30 O programa acabou.
	egrep '^# DESATIVADA: [0-9]{4}-[0-9]{2}-[0-9]{2} .{10,}' $f >/dev/null || echo $f
done


### Testes de segurança

eco ----------------------------------------------------------------
eco "* Funções que não colocaram aspas ao redor de \$ZZTMP"
grep '$ZZTMP' off/* zz/* | grep -v '"'

# https://github.com/funcoeszz/funcoeszz/wiki/Arquivos-Temporarios
eco ----------------------------------------------------------------
eco "* Funções que usaram nome inválido em \$ZZTMP.nome"
grep '$ZZTMP' zz/* | egrep -v '^zz/zz([^.]*)\.sh:.*\$ZZTMP\.\1'



# Outros:
#
# Verifica (visualmente) se há Uso: no texto de ajuda de todas as funções
# cat $ZZTMP.ajuda | egrep '^zz[^ ]*$|^Uso:' | sed 'N;s/\n/ - /'
