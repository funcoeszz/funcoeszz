# ----------------------------------------------------------------------------
# Miniferramentas para auxiliar as funções.
# Uso: zztool [-e] ferramenta [argumentos]
# Ex.: zztool grep_var foo $var
#      zztool eco Minha mensagem colorida
#      zztool testa_numero $num
#      zztool -e testa_numero $num || return
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-03-01
# Versão: 1
# Requisitos: zzzz
# ----------------------------------------------------------------------------
zztool ()
{
	zzzz -h tool "$1" && return

	local erro ferramenta
	local cor='36;1'  # ciano (vide saída da zzcores)

	# Devo mostrar a mensagem de erro?
	test "$1" = '-e' && erro=1 && shift

	# Libera o nome da ferramenta do $1
	ferramenta="$1"
	shift

	case "$ferramenta" in
		uso)
			# Extrai a mensagem de uso da função $1, usando seu --help
			if test -n "$erro"
			then
				zzzz -h "$1" -h | grep Uso >&2
			else
				zzzz -h "$1" -h | grep Uso
			fi
		;;
		eco)
			# Mostra mensagem colorida caso $ZZCOR esteja ligada
			if test "$ZZCOR" != '1'
			then
				printf "%b\n" "$*"
			else
				printf "%b\n" "\033[${cor}m$*\033[m"
			fi
		;;
		erro)
			# Mensagem de erro
			printf "%b\n" "$*" >&2
		;;
		acha)
			# Destaca o padrão $1 no texto via STDIN ou $2
			# O padrão pode ser uma regex no formato BRE (grep/sed)
			local esc padrao
			esc=$(printf '\033')
			padrao=$(echo "$1" | sed 's,/,\\/,g') # escapa /
			shift
			zztool multi_stdin "$@" |
				if test "$ZZCOR" != '1'
				then
					cat -
				else
					sed "s/$padrao/${esc}[${cor}m&${esc}[m/g"
				fi
		;;
		grep_var)
			# $1 está presente em $2?
			test "${2#*$1}" != "$2"
		;;
		index_var)
			# $1 está em qual posição em $2?
			local padrao="$1"
			local texto="$2"
			if zztool grep_var "$padrao" "$texto"
			then
				texto="${texto%%$padrao*}"
				echo $((${#texto} + 1))
			else
				echo 0
			fi
		;;
		arquivo_vago)
			# Verifica se o nome de arquivo informado está vago
			if test -e "$1"
			then
				test -n "$erro" && echo "Arquivo $1 já existe. Abortando." >&2
				return 1
			fi
		;;
		arquivo_legivel)
			# Verifica se o arquivo existe e é legível
			if ! test -r "$1"
			then
				test -n "$erro" && echo "Não consegui ler o arquivo $1" >&2
				return 1
			fi

			# TODO Usar em *todas* as funções que lêem arquivos
		;;
		num_linhas)
			# Informa o número de linhas, sem formatação
			local linhas
			linhas=$(zztool file_stdin "$@" | sed -n '$=')
			echo "${linhas:-0}"
		;;
		nl_eof)
			# Garante que a última linha tem um \n no final
			# Necessário porque o GNU sed não adiciona o \n
			# printf abc | bsd-sed ''      #-> abc\n
			# printf abc | gnu-sed ''      #-> abc
			# printf abc | zztool nl_eof   #-> abc\n
			sed '$ { G; s/\n//g; }'
		;;
		testa_ano)
			# Testa se $1 é um ano válido: 1-9999
			# O ano zero nunca existiu, foi de -1 para 1
			# Ano maior que 9999 pesa no processamento
			echo "$1" | grep -v '^00*$' | grep '^[0-9]\{1,4\}$' >/dev/null && return 0

			test -n "$erro" && echo "Ano inválido '$1'" >&2
			return 1
		;;
		testa_numero)
			# Testa se $1 é um número positivo
			echo "$1" | grep '^[0-9]\{1,\}$' >/dev/null && return 0

			test -n "$erro" && echo "Número inválido '$1'" >&2
			return 1

			# TODO Usar em *todas* as funções que recebem números
		;;
		testa_data)
			# Testa se $1 é uma data (dd/mm/aaaa)
			local d29='\(0[1-9]\|[12][0-9]\)/\(0[1-9]\|1[012]\)'
			local d30='30/\(0[13-9]\|1[012]\)'
			local d31='31/\(0[13578]\|1[02]\)'
			echo "$1" | grep "^\($d29\|$d30\|$d31\)/[0-9]\{1,4\}$" >/dev/null && return 0

			test -n "$erro" && echo "Data inválida '$1', deve ser dd/mm/aaaa" >&2
			return 1
		;;

		# IMPORTANTE
		# Em vez de adicionar outras ferramentas testa_* aqui, confira a zztestar.

		multi_stdin)
			# Mostra na tela os argumentos *ou* a STDIN, nesta ordem
			# Útil para funções/comandos aceitarem dados das duas formas:
			#     echo texto | funcao
			# ou
			#     funcao texto

			if test -n "$1"
			then
				echo "$*"  # security: always quote to avoid shell expansion
			else
				cat -
			fi
		;;
		file_stdin)
			# Mostra na tela o conteúdo dos arquivos *ou* da STDIN, nesta ordem
			# Útil para funções/comandos aceitarem dados das duas formas:
			#     cat arquivo1 arquivo2 | funcao
			#     cat arquivo1 arquivo2 | funcao -
			# ou
			#     funcao arquivo1 arquivo2
			#
			# Note que o uso de - para indicar STDIN não é portável, mas esta
			# ferramenta o torna portável, pois o cat o suporta no Unix.

			cat "${@:--}"  # Traduzindo: cat $@ ou cat -
		;;
		list2lines)
			# Limpa lista dos argumentos *ou* a STDIN e retorna um item por linha
			# Lista: um dois três | um, dois, três | um;dois;três
			zztool multi_stdin "$@" | 
				sed 's/[;,]/ /g' |
				tr -s '\t' ' ' |
				tr ' ' '\n' |
				grep .
		;;
		lines2list)
			# Recebe linhas em STDIN e retorna: linha1 linha2 linha3
			# Ignora linhas em branco e remove espaços desnecessários
			grep . |
				tr '\n' ' ' |
				sed 's/^ // ; s/ $//'
		;;
		endereco_sed)
			# Formata um texto para ser usado como endereço no sed.
			# Números e $ não são alterados, resto fica /entre barras/
			#     foo     -> /foo/
			#     foo/bar -> /foo\/bar/

			local texto="$*"

			if zztool testa_numero "$texto" || test "$texto" = '$'
			then
				echo "$texto"  # 1, 99, $
			else
				echo "$texto" | sed 's:/:\\\/:g ; s:.*:/&/:'
			fi
		;;
		sedurl)
			# Formata a url para ser utilizada
			sed 's| |+|g;s|&|%26|g;s|@|%40|g'
		;;
		terminal_utf8)
			echo "$LC_ALL $LC_CTYPE $LANG" | grep -i utf >/dev/null
		;;
		texto_em_iso)
			if test $ZZUTF = 1
			then
				iconv -f iso-8859-1 -t utf-8 /dev/stdin
			else
				cat -
			fi
		;;
		texto_em_utf8)
			if test $ZZUTF != 1
			then
				iconv -f utf-8 -t iso-8859-1 /dev/stdin
			else
				cat -
			fi
		;;
		mktemp)
			# Cria um arquivo temporário de nome único, usando $1.
			# Lembre-se de removê-lo no final da função.
			#
			# Exemplo de uso:
			#   local tmp=$(zztool mktemp arrumanome)
			#   foo --bar > "$tmp"
			#   rm -f "$tmp"

			mktemp "${ZZTMP:-/tmp/zz}.${1:-anonimo}.XXXXXX"
		;;
		post | dump | source | list | download)
			# Estrutura do comando:
			# zztool <post|dump|source|list|download> [browser] [opções] <url> [dados_post]

			local browser input_charset output_charset output_width user_agent opt_common nbsp_utf

			# A função pode chamar um navegador específico ou assumir o padrão $ZZBROWSER
			case "$1" in
				lynx | links | links2 | elinks | w3m) browser="$1"; shift  ;;
				*                                   ) browser="$ZZBROWSER" ;;
			esac

			# Parâmetros que podem ser modificados na linha de comando.
			while test "${1#-}" != "$1"
			do
				case "$1" in
					-i) input_charset="$2";  shift; shift ;;
					-o) output_charset="$2"; shift; shift ;;
					-w) output_width="$2";   shift; shift ;;
					-u) user_agent="$2";     shift; shift ;;
					-*) break ;;
				esac
			done

			output_charset="${output_charset:-UTF-8}"
			output_width="${output_width:-300}"
			nbsp_utf=$(printf '\302\240')

			# Para POST se não houver ao menos 2 parâmetros (url e dados) interrompe.
			test "$ferramenta" = 'post' && test $# -lt 2 && return 1

			# Para outras requisições ao menos 1 parâmetro (url), senão interrompe.
			test "$ferramenta" != 'post' && test $# -lt 1 && return 1

			# Caracterizando os paramêtros conforme cada navegador.
			case "$browser" in
				links | links2) opt_common="-width ${output_width} -codepage ${output_charset}        ${input_charset:+-html-assume-codepage} ${input_charset} ${user_agent:+-http.fake-user-agent} ${user_agent}" ;;
				lynx          ) opt_common="-width=${output_width} -display_charset=${output_charset} ${input_charset:+-assume_charset=}${input_charset}       ${user_agent:+-useragent=}${user_agent}            -accept_all_cookies" ;;
				w3m           ) opt_common="-cols ${output_width}  -O ${output_charset}               ${input_charset:+-I} ${input_charset}                    ${user_agent:+-o user_agent=}${user_agent}         -cookie -o follow_redirection=9" ;;
				elinks        )
					local aspas='"'
					opt_common="-dump-width ${output_width} -dump-charset ${output_charset} ${input_charset:+-eval 'set document.codepage.assume = ${aspas}${input_charset}${aspas}'} ${user_agent:+-eval 'set protocol.http.user_agent = $user_agent'} -no-numbering"
				;;
			esac

			case "$ferramenta" in
			post)
				# Post conforme o navegador escolhido
				case "$browser" in
					lynx)
						echo "$2" | $browser ${opt_common} -post-data -nolist "$1"
					;;
					links | links2 | elinks | w3m)
						local post_temp
						post_temp=$(zztool mktemp post)
						curl -L -s "${user_agent:+-A}" "${user_agent}" -o "$post_temp" --data "$2" "$1"

						if test "$browser" = 'w3m'
						then
							$browser ${opt_common} -dump -T text/html   "$post_temp"
						elif test "$browser" = 'elinks'
						then
							eval $browser ${opt_common} -dump -no-references "$post_temp" | sed "s/${nbsp_utf}/ /g"
						else
							$browser ${opt_common} -dump         file://"$post_temp"
						fi

						rm -f "$post_temp"
					;;
				esac
			;;
			dump)
				case "$browser" in
					links | links2)      $browser ${opt_common} -dump                "$1" ;;
					lynx          )      $browser ${opt_common} -dump -nolist        "$1" ;;
					w3m           )      $browser ${opt_common} -dump -T text/html   "$1" ;;
					elinks        ) eval $browser ${opt_common} -dump -no-references $(echo "$1" | sed 's/\&/\\&/g') | sed "s/${nbsp_utf}/ /g" ;;
				esac
			;;
			source)
				curl -L -s "${user_agent:+-A}" "${user_agent}" "$1"
			;;
			list)
				case "$browser" in
					links | links2)             $browser ${opt_common} -dump                -html-numbered-links 1   "$1" ;;
					lynx          ) LANG=C      $browser ${opt_common} -dump                                         "$1" ;;
					elinks        ) LANG=C eval $browser ${opt_common} -dump              $(echo "$1" | sed 's/\&/\\&/g') ;;
					w3m           )             $browser ${opt_common} -dump -T text/html   -o display_link_number=1 "$1" ;;
				esac |
				case "$browser" in
					links | links2) sed '1,/^Links:/d' ;;
					lynx  | elinks) sed '1,/^References/d; /Visible links/d; /Hidden links/d' | sed "s/${nbsp_utf}/ /g" ;;
					w3m           ) sed '1,/^References:/d' ;;
				esac |
				sed '/^ *$/d; s/.* //;'
			;;
			download)
				local arq_dest
				test -n "$2" && arq_dest="$2" || arq_dest=$(basename "$1")
				zztool source "$1" > "$arq_dest"
			;;
			esac
		;;
		cache | atualiza)
		# Limpa o cache se solicitado a atualização
		# Atualiza o cache se for fornecido a url
		# e retorna o nome do arquivo de cache
		# Ex.: local cache=$(zztool cache lua <identificador> '$url' dump) # Nome do cache, e atualiza se necessário
		# Ex.: local cache=$(zztool cache php) # Apenas retorna o nome do cache
		# Ex.: zztool cache rm palpite # Apaga o cache diretamente
			local id
			case "${1#zz}" in
			on | off | ajuda)
				# shellcheck disable=SC2104
				break
			;;
			rm)
				if test "$2" = '*'
				then
					rm -f "${ZZTMP:-XXXX}"*
					# Restabelecendo zz.ajuda, zz.on, zz.off
					$ZZPATH
				else
					test -n "$3" && id=".$3"
					test -n "$2" && rm -f "${ZZTMP:-XXXX}.${2#zz}${id}"*
				fi
			;;
			*)
				# Para mais de um arquivo cache pode-se usar um identificador adicional
				# como PID, um numero incremental ou um sufixo qualquer
				test -n "$2" && id=".$2"

				# Para atualizar é necessário prevenir a existência prévia do arquivo
				test "$ferramenta" = "atualiza" && rm -f "${ZZTMP:-XXXX}.${1#zz}$id"

				# Baixo para o cache os dados brutos sem tratamento
				if ! test -s "$ZZTMP.${1#zz}" && test -n "$3"
				then
					case $4 in
					none    ) : ;;
					html    ) zztool source "$3" > "$ZZTMP.${1#zz}$id";;
					list    ) zztool list   "$3" > "$ZZTMP.${1#zz}$id";;
					dump | *) zztool dump   "$3" > "$ZZTMP.${1#zz}$id";;
					esac
				fi
				test "$ferramenta" = "cache" && echo "$ZZTMP.${1#zz}$id"
			;;
			esac
		;;
		# Ferramentas inexistentes são simplesmente ignoradas
		esac
}
