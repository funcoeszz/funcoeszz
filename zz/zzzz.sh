# ----------------------------------------------------------------------------
# Mostra informações sobre as funções, como versão e localidade.
# Opções: --atualiza  baixa a versão mais nova das funções
#         --teste     testa se a codificação e os pré-requisitos estão OK
#         --bashrc    instala as funções no ~/.bashrc
#         --tcshrc    instala as funções no ~/.tcshrc
#         --zshrc     instala as funções no ~/.zshrc
# Uso: zzzz [--atualiza|--teste|--bashrc|--tcshrc|--zshrc]
# Ex.: zzzz
#      zzzz --teste
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2002-01-07
# Versão: 1
# Requisitos: zztool zzajuda
# ----------------------------------------------------------------------------
zzzz ()
{
	local nome_func arg_func padrao func
	local info_instalado info_instalado_zsh info_cor info_utf8 versao_remota
	local arquivo_aliases
	local n_on n_off
	local bashrc="$HOME/.bashrc"
	local tcshrc="$HOME/.tcshrc"
	local zshrc="$HOME/.zshrc"
	local url_site='http://funcoeszz.net'
	local url_exe="$url_site/funcoeszz"
	local instal_msg='Instalacao das Funcoes ZZ (www.funcoeszz.net)'

	case "$1" in

		# Atenção: Prepare-se para viajar um pouco que é meio complicado :)
		#
		# Todas as funções possuem a opção -h e --help para mostrar um
		# texto rápido de ajuda. Normalmente cada função teria que
		# implementar o código para verificar se recebeu uma destas opções
		# e caso sim, mostrar o texto na tela. Para evitar a repetição de
		# código, estas tarefas estão centralizadas aqui.
		#
		# Chamando a zzzz com a opção -h seguido do nome de uma função e
		# seu primeiro parâmetro recebido, o teste é feito e o texto é
		# mostrado caso necessário.
		#
		# Assim cada função só precisa colocar a seguinte linha no início:
		#
		#     zzzz -h beep "$1" && return
		#
		# Ao ser chamada, a zzzz vai mostrar a ajuda da função zzbeep caso
		# o valor de $1 seja -h ou --help. Se no $1 estiver qualquer outra
		# opção da zzbeep ou argumento, nada acontece.
		#
		# Com o "&& return" no final, a função zzbeep pode sair imediatamente
		# caso a ajuda tenha sido mostrada (retorno zero), ou continuar seu
		# processamento normal caso contrário (retorno um).
		#
		# Se a zzzz -h for chamada sem nenhum outro argumento, é porque o
		# usuário quer ver a ajuda da própria zzzz.
		#
		# Nota: Ao invés de "beep" literal, poderíamos usar $FUNCNAME, mas
		#       o Bash versão 1 não possui essa variável.

		-h | --help)

			nome_func=${2#zz}
			arg_func=$3

			# Nenhum argumento, mostre a ajuda da própria zzzz
			if test -z "$nome_func"
			then
				nome_func='zz'
				arg_func='-h'
			fi

			# Se o usuário informou a opção de ajuda, mostre o texto
			if test '-h' = "$arg_func" -o '--help' = "$arg_func"
			then
				# Um xunxo bonito: filtra a saída da zzajuda, mostrando
				# apenas a função informada.
				echo
				ZZCOR=0 zzajuda |
					sed -n "/^zz$nome_func$/,/^----*$/ {
						s/^----*$//
						p
					}" |
					zztool acha zz$nome_func
				return 0
			else

				# Alarme falso, o argumento não é nem -h nem --help
				return 1
			fi
		;;

		# Garantia de compatibilidade do -h com o formato antigo (-z):
		# zzzz -z -h zzbeep
		-z)
			zzzz -h "$3" "$2"
		;;

		# Testes de ambiente para garantir o funcionamento das funções
		--teste)

			### Todos os comandos necessários estão instalados?

			local comando tipo_comando comandos_faltando
			local comandos='awk bc cat chmod- clear- cp cpp- curl cut diff- du- find- fmt grep iconv links- lynx- mktemp mv od- ps- rm sed sleep sort tail- tr uniq unzip-'

			for comando in $comandos
			do
				# Este é um comando essencial ou opcional?
				tipo_comando='ESSENCIAL'
				if zztool grep_var - "$comando"
				then
					tipo_comando='opcional'
					comando=${comando%-}
				fi

				printf '%-30s' "Procurando o comando $comando... "

				# Testa se o comando existe
				if type "$comando" >/dev/null 2>&1
				then
					echo 'OK'
				else
					zztool eco "Comando $tipo_comando '$comando' não encontrado"
					comandos_faltando="$comandos_faltando $tipo_comando"
				fi
			done

			if test -n "$comandos_faltando"
			then
				echo
				zztool eco "**Atenção**"
				if zztool grep_var ESSENCIAL "$comandos_faltando"
				then
					echo 'Há pelo menos um comando essencial faltando.'
					echo 'Você precisa instalá-lo para usar as Funções ZZ.'
				else
					echo 'A falta de um comando opcional quebra uma única função.'
					echo 'Talvez você não precise instalá-lo.'
				fi
				echo
			fi

			### Tudo certo com a codificação do sistema e das ZZ?

			local cod_sistema='Nao UTF-8 :('  # deixe sem acentos

			printf 'Verificando a codificação do sistema... '
			zztool terminal_utf8 && cod_sistema='UTF-8'
			echo "$cod_sistema"

			printf 'Verificando a codificação das Funções ZZ... '
			echo "UTF-8"  # só temos essa versão agora

			# Se um dia precisar de um teste direto no arquivo:
			# sed 1d "$ZZPATH" | file - | grep UTF-8

			if test "$cod_sistema" != "UTF-8"
			then
				# Deixar sem acentuação mesmo, pois eles não vão aparecer
				echo
				zztool eco "**Atencao**"
				echo 'Ha uma incompatibilidade de codificacao.'
				echo "As Funcoes ZZ so funcionam corretamente em sistemas UTF-8."
			fi
		;;

		# Baixa a versão nova, caso diferente da local
		--atualiza)

			echo 'Procurando a versão nova, aguarde.'
			versao_remota=$(zztool dump "$url_site/v")
			echo "versão local : $ZZVERSAO"
			echo "versão remota: $versao_remota"
			echo

			# Aborta caso não encontrou a versão nova
			test -n "$versao_remota" || return

			# Compara e faz o download
			if test "$ZZVERSAO" != "$versao_remota"
			then
				printf 'Baixando a versão nova... '
				zztool download "$url_exe" "funcoeszz-$versao_remota"
				echo 'PRONTO!'
				echo "Arquivo 'funcoeszz-$versao_remota' baixado, instale-o manualmente."
				echo "O caminho atual é $ZZPATH"
			else
				echo 'Você já está com a versão mais recente.'
			fi
		;;

		# Instala as funções no arquivo .bashrc
		--bashrc)

			if ! grep "^[^#]*${ZZPATH:-zzpath_vazia}" "$bashrc" >/dev/null 2>&1
			then
				cat - >> "$bashrc" <<-EOS

				# $instal_msg
				export ZZOFF=""  # desligue funcoes indesejadas
				export ZZPATH="$ZZPATH"  # script
				export ZZDIR="$ZZDIR"    # pasta zz/
				source "\$ZZPATH"
				EOS

				echo 'Feito!'
				echo "As Funções ZZ foram instaladas no $bashrc"
			else
				echo "Nada a fazer. As Funções ZZ já estão no $bashrc"
			fi
		;;

		# Cria aliases para as funções no arquivo .tcshrc
		--tcshrc)
			arquivo_aliases="$HOME/.zzcshrc"

			# Chama o arquivo dos aliases no final do .tcshrc
			if ! grep "^[^#]*$arquivo_aliases" "$tcshrc" >/dev/null 2>&1
			then
				# setenv ZZDIR $ZZDIR
				cat - >> "$tcshrc" <<-EOS

				# $instal_msg
				# script
				setenv ZZPATH $ZZPATH
				# pasta zz/
				setenv ZZDIR $ZZDIR
				source $arquivo_aliases
				EOS

				echo 'Feito!'
				echo "As Funções ZZ foram instaladas no $tcshrc"
			else
				echo "Nada a fazer. As Funções ZZ já estão no $tcshrc"
			fi

			# Cria o arquivo de aliases
			echo > "$arquivo_aliases"
			for func in $(ZZCOR=0 zzzz | grep -v '^(' | sed 's/,//g')
			do
				echo "alias zz$func 'funcoeszz zz$func'" >> "$arquivo_aliases"
			done

			echo
			echo "Aliases atualizados no $arquivo_aliases"
		;;

		# Cria aliases para as funções no arquivo .zshrc
		--zshrc)
			arquivo_aliases="$HOME/.zzzshrc"

			# Chama o arquivo dos aliases no final do .zshrc
			if ! grep "^[^#]*$arquivo_aliases" "$zshrc" >/dev/null 2>&1
			then
				# export ZZDIR=$ZZDIR
				cat - >> "$zshrc" <<-EOS

				# $instal_msg
				# script
				export ZZPATH=$ZZPATH
				# pasta zz/
				export ZZDIR=$ZZDIR
				source $arquivo_aliases
				EOS

				echo 'Feito!'
				echo "As Funções ZZ foram instaladas no $zshrc"
			else
				echo "Nada a fazer. As Funções ZZ já estão no $zshrc"
			fi

			# Cria o arquivo de aliases
			echo > "$arquivo_aliases"
			for func in $(ZZCOR=0 zzzz | grep -v '^(' | sed 's/,//g')
			do
				echo "alias zz$func='funcoeszz zz$func'" >> "$arquivo_aliases"
			done

			echo
			echo "Aliases atualizados no $arquivo_aliases"
		;;

		# Mostra informações sobre as funções
		*)
			# As funções estão configuradas para usar cores?
			test "$ZZCOR" = '1' && info_cor='sim' || info_cor='não'

			# A codificação do arquivo das funções é UTF-8? Sim, sempre.
			info_utf8='UTF-8'

			# As funções estão instaladas no bashrc?
			if grep "^[^#]*${ZZPATH:-zzpath_vazia}" "$bashrc" >/dev/null 2>&1
			then
				info_instalado="$bashrc"
			else
				info_instalado='não instalado'
			fi

			# As funções estão instaladas no zshrc?
			if grep "^[^#]*${ZZPATH:-zzpath_vazia}" "$zshrc" >/dev/null 2>&1
			then
				info_instalado_zsh="$zshrc"
			else
				info_instalado_zsh='não instalado'
			fi

			# Informações, uma por linha
			zztool acha '^[^)]*)' "( script) $ZZPATH"
			zztool acha '^[^)]*)' "(  pasta) $ZZDIR"
			zztool acha '^[^)]*)' "( versão) $ZZVERSAO ($info_utf8)"
			zztool acha '^[^)]*)' "(  cores) $info_cor"
			zztool acha '^[^)]*)' "(    tmp) $ZZTMP"
			zztool acha '^[^)]*)' "(browser) $ZZBROWSER"
			zztool acha '^[^)]*)' "( bashrc) $info_instalado"
			zztool acha '^[^)]*)' "(  zshrc) $info_instalado_zsh"
			zztool acha '^[^)]*)' "(   site) $url_site"

			# Lista de todas as funções

			# Sem $ZZDIR, provavelmente usando --tudo-em-um
			# Tentarei obter a lista de funções carregadas na shell atual
			if test -z "$ZZDIR"
			then
				set |
					sed -n '/^zz[a-z0-9]/ s/ *().*//p' |
					sort > "$ZZTMP.on"
			fi

			if test -r "$ZZTMP.on"
			then
				echo
				n_on=$(zztool num_linhas "$ZZTMP.on")
				zztool eco "(( $n_on funções disponíveis ))"
				cat "$ZZTMP.on" |
					sed 's/^zz//' |
					zztool lines2list |
					sed 's/ /, /g' |
					fmt -w 70
			else
				echo
				echo "Não consegui obter a lista de funções disponíveis."
				echo "Para recriá-la basta executar o script 'funcoeszz' sem argumentos."
			fi

			# Só mostra se encontrar o arquivo...
			if test -r "$ZZTMP.off"
			then
				# ...e se ele tiver ao menos uma zz
				grep zz "$ZZTMP.off" >/dev/null || return

				echo
				n_off=$(zztool num_linhas "$ZZTMP.off")
				zztool eco "(( $n_off funções desativadas ))"
				cat "$ZZTMP.off" |
					sed 's/^zz//' |
					zztool lines2list |
					sed 's/ /, /g' |
					fmt -w 70
			else
				echo
				echo "Não consegui obter a lista de funções desativadas."
				echo "Para recriá-la basta executar o script 'funcoeszz' sem argumentos."
			fi
		;;
	esac
}
