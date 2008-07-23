#!/bin/bash
# funcoeszz
#
# INFORMAÇÕES: www.funcoeszz.net
# NASCIMENTO : 22 de Fevereiro de 2000
# AUTORES    : Aurélio Marinho Jargas <verde (a) aurelio net>
#              Thobias Salazar Trevisan <thobias (a) thobias org>
# DESCRIÇÃO  : Funções de uso geral para o shell Bash, que buscam
#              informações em arquivos locais e fontes na Internet
# LICENÇA    : GPL v2
# CHANGELOG  : www.funcoeszz.net/changelog.html
#
ZZVERSAO=8.7
ZZUTF=1
#
##############################################################################
#
#                                Configuração
#                                ------------
#
#
### Configuração via variáveis de ambiente
#
# Algumas variáveis de ambiente podem ser usadas para alterar o comportamento
# padrão das funções. Basta defini-las em seu .bashrc ou na própria linha de
# comando antes de chamar as funções. São elas:
#
#      $ZZCOR    - Liga/Desliga as mensagens coloridas (1 e 0)
#      $ZZPATH   - Caminho completo para o arquivo das funções
#      $ZZEXTRA  - Caminho completo para o arquivo com funções adicionais
#      $ZZTMPDIR - Diretório para armazenar arquivos temporários
#
# Nota: Se você é paranóico com segurança, configure a ZZTMPDIR para
#       um diretório dentro do seu HOME.
#
### Configuração fixa neste arquivo (hardcoded)
#
# A configuração também pode ser feita diretamente neste arquivo, se você
# puder fazer alterações nele.
#
ZZCOR_DFT=1                       # colorir mensagens? 1 liga, 0 desliga
ZZPATH_DFT="/usr/bin/funcoeszz"   # rota absoluta deste arquivo
ZZEXTRA_DFT="$HOME/.zzextra"      # rota absoluta do arquivo de extras
ZZTMPDIR_DFT="${TMPDIR:-/tmp}"    # diretório temporário
#
#
##############################################################################
#
#                               Inicialização
#                               -------------
#
#
# Variáveis auxiliares usadas pelas Funções ZZ.
# Não altere nada aqui.
#
#

ZZWWWDUMP='lynx -dump      -nolist -width=300 -accept_all_cookies -display_charset=UTF-8'
ZZWWWLIST='lynx -dump              -width=300 -accept_all_cookies -display_charset=UTF-8'
ZZWWWPOST='lynx -post-data -nolist -width=300 -accept_all_cookies -display_charset=UTF-8'
ZZWWWHTML='lynx -source'
ZZCODIGOCOR='36;1'            # use zzcores para ver os códigos
ZZSEDURL='s| |+|g;s|&|%26|g;s|@|%40|g'


#
### Truques para descobrir a localização deste arquivo no sistema
#
# Se a chamada foi pelo executável, o arquivo é o $0.
# Senão, tenta usar a variável de ambiente ZZPATH, definida pelo usuário.
# Caso não exista, usa o local padrão ZZPATH_DFT.
# Finalmente, força que ZZPATH seja uma rota absoluta.
#
[ "${0##*/}" = 'bash' -o "${0#-}" != "$0" ] || ZZPATH="$0"
[ "$ZZPATH" ] || ZZPATH=$ZZPATH_DFT
[ "$ZZPATH" ] || echo 'AVISO: $ZZPATH vazia. zzajuda e zzzz não funcionarão'
[ "${ZZPATH#/}" = "$ZZPATH" ] && ZZPATH="$PWD/${ZZPATH#./}"
[ "$ZZEXTRA" ] || ZZEXTRA=$ZZEXTRA_DFT
[ -f "$ZZEXTRA" ] || ZZEXTRA=
#
### Últimos ajustes
#
ZZCOR="${ZZCOR:-$ZZCOR_DFT}"
ZZTMP="${ZZTMPDIR:-$ZZTMPDIR_DFT}/zz"
unset ZZCOR_DFT ZZPATH_DFT ZZEXTRA_DFT ZZTMPDIR_DFT
#
#
##############################################################################


# ----------------------------------------------------------------------------
# Miniferramentas para auxiliar as funções.
# Uso: zztool ferramenta [argumentos]
# ----------------------------------------------------------------------------
zztool ()
{
	case "$1" in
		uso)
			# Extrai a mensagem de uso da função $2, usando seu --help
			zzzz -h $2 -h | grep Uso
		;;
		eco)
			shift
			# Mostra mensagem colorida caso $ZZCOR esteja ligada
			if [ "$ZZCOR" != '1' ]
			then
				echo -e "$*"
			else
				echo -e "\033[${ZZCODIGOCOR}m$*\033[m"
			fi
		;;
		acha)
			# Destaca o padrão $2 no texto via STDIN ou $3
			# O padrão pode ser uma regex no formato BRE (grep/sed)
			local esc=$(printf '\033')
			local padrao=$(echo "$2" | sed 's,/,\\/,g') # escapa /
			shift; shift
			zztool multi_stdin "$@" |
				if [ "$ZZCOR" != '1' ]
				then
					cat -
				else
		 			sed "s/$padrao/$esc[${ZZCODIGOCOR}m&$esc[m/g"
				fi
		;;
		grep_var)
			# $2 está presente em $3?
			test "${3#*$2}" != "$3"
		;;
		index_var)
			# $2 está em qual posição em $3?
			local padrao="$2"
			local texto="$3"
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
			if test -e "$2"
			then
				echo "Arquivo $2 já existe. Abortando."
				return 1
			fi
		;;
		arquivo_legivel)
			# Verifica se o arquivo existe e é legível
			if ! test -r "$2"
			then
				echo "Não consegui ler o arquivo $2"
				return 1
			fi
			
			# TODO Usar em *todas* as funções que lêem arquivos
		;;
		testa_numero)
			# Testa se $2 é um número positivo
			echo "$2" | grep '^[0-9]\{1,\}$' >/dev/null
			
			# TODO Usar em *todas* as funções que recebem números
		;;
		testa_numero_sinal)
			# Testa se $2 é um número (pode ter sinal: -2 +2)
			echo "$2" | grep '^[+-]\{0,1\}[0-9]\{1,\}$' >/dev/null
		;;
		testa_binario)
			# Testa se $2 é um número binário
			echo "$2" | grep '^[01]\{1,\}$' >/dev/null
		;;
		testa_ip)
			# Testa se $2 é um número IP (nnn.nnn.nnn.nnn)
			local nnn="\([0-9]\{1,2\}\|1[0-9][0-9]\|2[0-4][0-9]\|25[0-5]\)" # 0-255
			echo "$2" | grep "^$nnn\.$nnn\.$nnn\.$nnn$" >/dev/null
		;;
		multi_stdin)
			# Mostra na tela os argumentos *ou* a STDIN, nesta ordem
			# Útil para funções/comandos aceitarem dados das duas formas:
			#     echo texto | funcao
			# ou
			#     funcao texto
			shift
			if [ "$1" ]
			then
				 	echo "$*"
			else
					cat -
			fi
		;;
		trim)
			shift
			zztool multi_stdin "$@" |
		 		sed 's/^[[:blank:]]*// ; s/[[:blank:]]*$//'
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
		# Ferramentas inexistentes são simplesmente ignoradas
		esac
}


# ----------------------------------------------------------------------------
# Mostra uma tela de ajuda com explicação e sintaxe de todas as funções.
# Uso: zzajuda
# ----------------------------------------------------------------------------
zzajuda ()
{

	zzzz -h ajuda $1 && return

	# Salva a configuração original de cores
	local zzcor_orig=$ZZCOR

	# Desliga cores para os paginadores antigos
	if [ "$PAGER" = 'less' -o "$PAGER" = 'more' ]
	then
		ZZCOR=0
	fi

	# Mostra ajuda das funções padrão e das extras
	cat $ZZPATH $ZZEXTRA |

		# Magia negra para extrair somente os textos de descrição
		sed '
			1 {
				s/.*/** Ajuda das Funções ZZ (tecla Q sai)/
				G
				p
			}
			/^# --*$/,/^# --*$/ {
				s/-\{20,\}/-------/
				s/^# //p
			}
			d' |
		uniq |
		sed 's/^-\{7\}/&&&&&&&&&&&/' |
		zztool acha 'zz[a-z0-9]\{2,\}' |
		${PAGER:-less -r}
		
	# Restaura configuração de cores
	ZZCOR=$zzcor_orig
}


# ----------------------------------------------------------------------------
# Mostra informações sobre as funções, como versão e localidade.
# Opções: --atualiza  baixa a versão mais nova das funções
#         --teste     testa se a codificação e os pré-requisitos estão OK
#         --bashrc    instala as funções no ~/.bashrc
#         --tcshrc    instala as funções no ~/.tcshrc
# Uso: zzzz [--atualiza|--teste|--bashrc|--tcshrc]
# Ex.: zzzz
#      zzzz --teste
# ----------------------------------------------------------------------------
zzzz ()
{
	local nome_func arg_func padrao
	local info_instalado info_cor info_utf8 versao_remota
	local arquivo_aliases arquivo_zz extra
	local bashrc="$HOME/.bashrc"
	local tcshrc="$HOME/.tcshrc"
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
		#     zzzz -h beep $1 && return
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
			if ! [ "$nome_func" ]
			then
				nome_func='zz'
				arg_func='-h'
			fi

			# Se o usuário informou a opção de ajuda, mostre o texto
			if [ "$arg_func" = '-h' -o "$arg_func" = '--help'  ]
			then
				padrao="Uso: [^ ]*zz$nome_func \{0,1\}"

				# Um xunxo bonito: filtra a saída da zzajuda, mostrando
				# apenas a função informada.
				zzajuda |
					grep -C15 "^$padrao\b" |
					sed -n "
						H
						/^---/ {
						 	x
							/zz$nome_func/ {
							 	s/----*//gp
								q
							}
						}"
				return 0
			else
			
				# Alarme falso, o argumento não é nem -h nem --help
				return 1
			fi
		;;
		
		# Garantia de compatibilidade do -h com o formato antigo (-z):
		# zzzz -z -h zzbeep
		-z)
			zzzz -h $3 $2
		;;

		# Testes de ambiente para garantir o funcionamento das funções
		--teste)
		
			### Todos os comandos necessários estão instalados?
			
			local comando tipo_comando comandos_faltando
			local comandos='awk- bc cat chmod- clear- cp cpp- cut diff- du- find- grep iconv- lynx mv od- play- ps- rm sed sleep sort tail- tr uniq'

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
					comandos_faltando="$comando_faltando $tipo_comando"
				fi
			done
			
			if [ "$comandos_faltando" ]
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

			local cod_sistema='ISO-8859-1'
			local cod_funcoeszz='ISO-8859-1'

			printf 'Verificando a codificação do sistema... '
			zztool terminal_utf8 && cod_sistema='UTF-8'
			echo $cod_sistema

			printf 'Verificando a codificação das Funções ZZ... '
			test $ZZUTF = 1 && cod_funcoeszz='UTF-8'
			echo $cod_funcoeszz
			
			# Se um dia precisar de um teste direto no arquivo:
			# sed 1d "$ZZPATH" | file - | grep UTF-8

			if test "$cod_sistema" != "$cod_funcoeszz"
			then
				# Deixar sem acentuação mesmo, pois eles não vão aparecer
				echo
				zztool eco "**Atencao**"
				echo 'Ha uma incompatibilidade de codificacao.'
				echo "Baixe as Funcoes ZZ versao $cod_sistema."
			fi
		;;
		
		# Baixa a versão nova, caso diferente da local
		--atualiza)

			echo 'Procurando a versão nova, aguarde.'
			versao_remota=$($ZZWWWDUMP "$url_site/v")
			echo "versão local : $ZZVERSAO"
			echo "versão remota: $versao_remota"
			echo

			# Aborta caso não encontrou a versão nova
			[ "$versao_remota" ] || return

			# Compara e faz o download
			if [ "$ZZVERSAO" != "$versao_remota" ]
			then
				# Vamos baixar a versão ISO-8859-1?
				[ $ZZUTF != '1' ] && url_exe="${url_exe}-iso"

				echo -n 'Baixando a versão nova... '				
				$ZZWWWHTML "$url_exe" > "funcoeszz-$versao_remota"
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
				(
					echo
					echo "# $instal_msg"
					echo "source $ZZPATH"
					echo "export ZZPATH=$ZZPATH"
				) >> "$bashrc"
				
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
				(
					echo
					echo "# $instal_msg"
					echo "source $arquivo_aliases"
					echo "setenv ZZPATH $ZZPATH"
				) >> "$tcshrc"
				echo 'Feito!'
				echo "As Funções ZZ foram instaladas no $tcshrc"
			else
				echo "Nada a fazer. As Funções ZZ já estão no $tcshrc"
			fi
			
			# Cria o arquivo de aliases
			echo > $arquivo_aliases
			for func in $(ZZCOR=0 zzzz | sed '1,/^(( fu/d; /^(/d; s/,//g')
			do
				echo "alias zz$func 'funcoeszz zz$func'" >> "$arquivo_aliases"
			done
			echo
			echo "Aliases atualizados no $arquivo_aliases"
		;;

		# Mostra informações sobre as funções
		*)
			# As funções estão configuradas para usar cores?
			[ "$ZZCOR" = '1' ] && info_cor='sim' || info_cor='não'

			# A codificação do arquivo das funções é UTF-8?
			[ "$ZZUTF" = 1 ] && info_utf8='UTF-8' || info_utf8='ISO-8859-1'
			
			# As funções estão instaladas no bashrc?
			if grep "^[^#]*${ZZPATH:-zzpath_vazia}" "$bashrc" >/dev/null 2>&1
			then
				info_instalado="$bashrc"
			else
				info_instalado='não instalado'
			fi
			
			# Informações, uma por linha
			zztool acha '^[^)]*)' "( local) $ZZPATH"
			zztool acha '^[^)]*)' "(versão) $ZZVERSAO ($info_utf8)"
			zztool acha '^[^)]*)' "( cores) $info_cor"
			zztool acha '^[^)]*)' "(   tmp) $ZZTMP"
			zztool acha '^[^)]*)' "(bashrc) $info_instalado"
			zztool acha '^[^)]*)' "(extras) ${ZZEXTRA:-nenhum}"
			zztool acha '^[^)]*)' "(  site) $url_site"
						
			# Lista de todas as funções
			for arquivo_zz in "$ZZPATH" "$ZZEXTRA"
			do
				if [ "$arquivo_zz" -a -f "$arquivo_zz" ]
				then
					echo
					zztool eco "(( funções disponíveis ${extra:+EXTRA }))"
					# Nota: zzzz --tcshrc procura por " fu"
					
					# Sed mágico que extrai e formata os nomes de funções
					# limitando as linhas em 60 colunas
					sed -n '/^zz\([a-z0-9]\{1,\}\) *(.*/s//\1/p' "$arquivo_zz" |
						sort |
						sed -e ':a' -e '$b' -e 'N; s/\n/, /; /.\{60\}/{p;d;};ba'
						
					# Flag tosca para identificar a segunda volta do loop
					extra=1
				fi
			done
		;;
	esac
}



# ----------------------------------------------------------------------------
# #### D I V E R S O S
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# Mostra uma seqüência numérica, um número por linha.
# Obs.: Emulação do comando seq, presente no Linux.
# Uso: zzseq [número-inicial] número-final
# Ex.: zzseq 5
#      zzseq 10 5
# ----------------------------------------------------------------------------
# TODO aceitar terceiro parâmetro, igual no Linux: 10 -2 0 (início step fim)
zzseq ()
{
	zzzz -h seq $1 && return

	local operacao='+'
	local inicio=1
	local fim=$1

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso seq; return; }
	
	# Se houver dois números, vai "do primeiro ao segundo"
	[ "$2" ] && inicio=$1 fim=$2

	# Verificações básicas
	if ! (zztool testa_numero_sinal "$inicio" &&
	      zztool testa_numero_sinal "$fim")
	then
		zztool uso seq
		return
	fi
	
	# Se o primeiro for maior que o segundo, a contagem é regressiva
	[ $inicio -gt $fim ] && operacao='-'
	
	# Loop que mostra o número e aumenta/diminui a contagem
	while [ $inicio -ne $fim ]
	do
		echo $inicio
		eval "inicio=\$((inicio $operacao 1))" # +1 ou -1
	done
	echo $inicio
}


# ----------------------------------------------------------------------------
# Conversão entre grandezas de bytes (mega, giga, tera, etc).
# Uso: zzbyte N [unidade-entrada] [unidade-saida]  # BKMGTPEZY
# Ex.: zzbyte 2048                    # Quanto é 2048 bytes?  -- 2K
#      zzbyte 2048 K                  # Quanto é 2048KB?      -- 2M
#      zzbyte 7 K M                   # Quantos megas em 7KB? -- 0.006M
#      zzbyte 7 G B                   # Quantos bytes em 7GB? -- 7516192768B
#      for u in b k m g t p e z y; do zzbyte 2 t $u; done
# ----------------------------------------------------------------------------
zzbyte ()
{
	zzzz -h byte $1 && return

	local i i_entrada i_saida diferenca operacao passo falta
	local unidades='BKMGTPEZY' # kilo, mega, giga, etc
	local n=$1
	local entrada=${2:-B}
	local saida=${3:-.}
	
	# Sejamos amigáveis com o usuário permitindo minúsculas também
	entrada=$(echo $entrada | zzmaiusculas)
	saida=$(  echo $saida   | zzmaiusculas)

	# Verificações básicas
	if ! zztool testa_numero $n
	then
		zztool uso byte
		return
	fi
	if ! zztool grep_var $entrada "$unidades"
	then
		echo "Unidade inválida '$entrada'"
		return
	fi
	if ! zztool grep_var $saida ".$unidades"
	then
		echo "Unidade inválida '$saida'"
		return
	fi
	
 	# Extrai os números (índices) das unidades de entrada e saída
	i_entrada=$(zztool index_var $entrada $unidades)
	i_saida=$(  zztool index_var $saida   $unidades)
		
	# Sem $3, a unidade de saída será otimizada
	[ $i_saida -eq 0 ] && i_saida=15

	# A diferença entre as unidades guiará os cálculos
	diferenca=$((i_saida - i_entrada))
	if [ $diferenca -lt 0 ]
	then
	 	operacao='*'
	 	passo='-'
	else
		operacao='/'
		passo='+'
	fi
	
	i=$i_entrada
	while [ $i -ne $i_saida ]
	do
		# Saída automática (sem $3)
		# Chegamos em um número menor que 1024, hora de sair
		[ $n -lt 1024 -a $i_saida -eq 15 ] && break
		
		# Não ultrapasse a unidade máxima (Yota)
		[ $i -eq ${#unidades} -a $passo = '+' ] && break
		
		# 0 < n < 1024 para unidade crescente, por exemplo: 1 B K
		# É hora de dividir com float e colocar zeros à esquerda
		if [ $n -gt 0 -a $n -lt 1024 -a $passo = '+' ]
		then
			# Quantos dígitos ainda faltam?
			falta=$(( (i_saida - i - 1) * 3))
						
			# Pulamos direto para a unidade final
			i=$i_saida
			
			# Cálculo preciso usando o bc (Retorna algo como .090)
			n=$(echo "scale=3; $n / 1024" | bc)
			[ $n = '0' ] && break # 1 / 1024 = 0

			# Completa os zeros que faltam
			[ $falta -gt 0 ] && n=$(printf "%0.${falta}f%s" 0 ${n#.})
			
			# Coloca o zero na frente, caso necessário
			[ "${n#.}" != "$n" ] && n=0$n
			
			break
		fi
		
		# Terminadas as exceções, este é o processo normal
		# Aumenta/diminui a unidade e divide/multiplica por 1024
		eval "i=$((i $passo 1))"
		eval "n=$((n $operacao 1024))"
	done
	
	# Mostra o resultado
	echo $n$(echo $unidades | cut -c$i)
}


# ----------------------------------------------------------------------------
# Aguarda N minutos e dispara uma sirene usando o 'speaker'.
# Útil para lembrar de eventos próximos no mesmo dia.
# Sem argumentos, restaura o 'beep' para o seu tom e duração originais.
# Obs.: A sirene tem 4 toques, sendo 2 tons no modo texto e apenas 1 no Xterm.
# Uso: zzbeep [números]
# Ex.: zzbeep 0
#      zzbeep 1 5 15    # espere 1 minuto, depois mais 5, e depois 15
# ----------------------------------------------------------------------------
zzbeep ()
{
	zzzz -h beep $1 && return
	
	local minutos frequencia
	
	# Sem argumentos, apenas restaura a "configuração de fábrica" do beep
	[ "$1" ] || {
		printf '\033[10;750]\033[11;100]\a'
		return
	}
	
	# Para cada quantidade informada pelo usuário...
	for minutos in $*
	do
		# Aguarda o tempo necessário
		echo -n "Vou bipar em $minutos minutos... "
		sleep $((minutos*60))
		
		# Ajusta o beep para toque longo (Linux modo texto)
		printf '\033[11;900]'
		
		# Alterna entre duas freqüências, simulando uma sirene (Linux)
		for frequencia in 500 400 500 400
		do
			printf "\033[10;$frequencia]\a"
			sleep 1
		done
		
		# Restaura o beep para toque normal
		printf '\033[10;750]\033[11;100]'
		echo OK
	done
}


# ----------------------------------------------------------------------------
# Retira linhas em branco e comentários.
# Para ver rapidamente quais opções estão ativas num arquivo de configuração.
# Além do tradicional #, reconhece comentários de arquivos .vim.
# Obs.: Aceita dados vindos da entrada padrão (STDIN).
# Uso: zzlimpalixo [arquivos]
# Ex.: zzlimpalixo ~/.vimrc
#      cat /etc/inittab | zzlimpalixo
# ----------------------------------------------------------------------------
zzlimpalixo ()
{
	zzzz -h limpalixo $1 && return

	local comentario='#'

	# Reconhecimento de comentários do Vim
	case "$1" in
		*.vim | *.vimrc*)
			comentario='"'
		;;
	esac

	# Remove comentários e linhas em branco
	cat "${@:--}" |
		sed "
			/^[[:blank:]]*$comentario/ d
			/^[[:blank:]]*$/ d" |
		uniq
}


# ----------------------------------------------------------------------------
# Conversão de letras entre minúsculas e MAIÚSCULAS, inclusive acentuadas.
# Uso: zzmaiusculas [arquivo]
# Uso: zzminusculas [arquivo]
# Ex.: zzmaiusculas /etc/passwd
#      echo NÃO ESTOU GRITANDO | zzminusculas
# ----------------------------------------------------------------------------
zzminusculas ()
{
	zzzz -h minusculas $1 && return
	
	sed '
		y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/
	 	y/ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÇÑ/àáâãäåèéêëìíîïòóôõöùúûüçñ/' "$@"
}
zzmaiusculas ()
{
	zzzz -h maiusculas $1 && return
	
	sed '
		y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/
	 	y/àáâãäåèéêëìíîïòóôõöùúûüçñ/ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÇÑ/' "$@"
}


# ----------------------------------------------------------------------------
# Retira as linhas repetidas, consecutivas ou não.
# Obs.: Não altera a ordem original das linhas, diferente do sort|uniq.
# Uso: zzuniq [arquivo]
# Ex.: zzuniq /etc/inittab
#      cat /etc/inittab | zzuniq
# ----------------------------------------------------------------------------
zzuniq ()
{
	zzzz -h uniq $1 && return

	# As linhas do arquivo são numeradas para guardar a ordem original
	cat -n "${1:--}" |     # Numera as linhas do arquivo
		sort -k2 -u |  # Ordena e remove duplos, ignorando a numeração
		sort -n |      # Restaura a ordem original
		cut -f2-       # Remove a numeração

	# Versão SED, mais lenta para arquivos grandes, mas só precisa do SED
	# PATT: LINHA ATUAL \n LINHA-1 \n LINHA-2 \n ... \n LINHA #1 \n
	# sed "G ; /^\([^\n]*\)\n\([^\n]*\n\)*\1\n/d ; h ; s/\n.*//" $1
		
}


# ----------------------------------------------------------------------------
# Mata processos pelo nome do seu comando de origem.
# Com a opção -n, apenas mostra o que será feito, mas não executa.
# Uso: zzkill [-n] comando [comando2 ...]
# Ex.: zzkill netscape
#      zzkill netsc soffice startx
# ----------------------------------------------------------------------------
zzkill ()
{
	zzzz -h kill $1 && return

	local nao comandos comando processos pid chamada

	# Opções de linha de comando
	if [ "$1" = '-n' ]
	then
		nao='[-n]\t'
		shift
	fi

	while :
	do
		comando="$1"
		
		# Tenta obter a lista de processos nos formatos Linux e BSD
		processos=$(ps xw --format pid,comm 2>/dev/null) ||
		processos=$(ps xw -o pid,command 2>/dev/null)

		 # Diga não ao suicídio
		processos=$(echo "$processos" | grep -vw '\(zz\)*kill')
		
		# Sem argumentos, apenas mostra a listagem e sai
		if ! [ "$1" ]
		then
			echo "$processos"
			return
		fi
		
		# Filtra a lista, extraindo e matando os PIDs
		echo "$processos" |
			grep -i "$comando" |
			while read pid chamada
			do
				echo -e "$nao$pid\t$chamada"
				[ "$nao" ] || kill $pid
			done
		
		# Próximo da fila!
		shift
		[ "$1" ] || break
	done
}


# ----------------------------------------------------------------------------
# Mostra todas as combinações de cores possíveis no console.
# Também mostra os códigos ANSI para obter tais combinações.
# Uso: zzcores
# ----------------------------------------------------------------------------
zzcores ()
{
	zzzz -h cores $1 && return

	local frente fundo negrito cor

	for frente in 0 1 2 3 4 5 6 7
	do
		for negrito in '' ';1' # alterna entre linhas sem e com negrito
		do
			for fundo in 0 1 2 3 4 5 6 7
			do
				# Compõe o par de cores: NN;NN
				cor="4$fundo;3$frente"
				
				# Mostra na tela usando caracteres de controle: ESC[ NN m
				printf "\033[$cor${negrito}m $cor${negrito:-  } \033[m"
			done
			echo
		done
	done
}


# ----------------------------------------------------------------------------
# Gera uma senha aleatória de N caracteres formada por letras e números.
# Obs.: A senha gerada não possui caracteres repetidos.
# Uso: zzsenha [n]     (padrão n=6)
# Ex.: zzsenha
#      zzsenha 8
# ----------------------------------------------------------------------------
zzsenha ()
{
	zzzz -h senha $1 && return

	local posicao letra
	local n=6
	local alpha='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
	local maximo=${#alpha}

	# Guarda o número informado pelo usuário (se existente)
	[ "$1" ] && n=$1
	
	# Foi passado um número mesmo?
	if ! zztool testa_numero "$n"
	then
		zztool uso senha
		return
	fi

	# Já que não repete as letras, temos uma limitação de tamanho
	if [ $n -gt $maximo ]
	then
		echo "O tamanho máximo da senha é $maximo"
		return
	fi
	
	# Esquema de geração da senha:
	# A cada volta é escolhido um número aleatório que indica uma
	# posição dentro do $alpha. A letra dessa posição é mostrada na
	# tela e removida do $alpha para não ser reutilizada.
	while [ $n -ne 0 ]
	do
		n=$((n-1))
		posicao=$((RANDOM % ${#alpha} + 1))
		letra=$(echo -n "$alpha" | cut -c$posicao)
		alpha=$(echo $alpha | tr -d $letra)
		echo -n $letra
	done
	echo
}


# ----------------------------------------------------------------------------
# Mostra a tabela ASCII com todos os caracteres imprimíveis (32-126,161-255).
# O formato utilizando é: <decimal> <hexa> <octal> <ascii>.
# O número de colunas e a largura da tabela são configuráveis.
# Uso: zzascii [colunas] [largura]
# Ex.: zzascii
#      zzascii 4
#      zzascii 7 100
# ----------------------------------------------------------------------------
zzascii ()
{
	zzzz -h ascii $1 && return

	local referencias decimais decimal hexa octal caractere
	local num_colunas=${1:-5}
	local largura=${2:-78}
	local linha=0
	
	# Estamos em um terminal UTF-8?
	if zztool terminal_utf8
	then
		decimais=$(zzseq 32 126)
	else
		# Se o sistema for ISO-8859-1, mostra a tabela extendida,
		# com caracteres acentuados
		decimais=$(zzseq 32 126 ; zzseq 161 255)
	fi

	# Cálculos das dimensões da tabela
	local colunas=$(zzseq 0 $((num_colunas - 1)))
	local largura_coluna=$((largura / num_colunas))
	local num_caracteres=$(echo "$decimais" | sed -n '$=')
	local num_linhas=$((num_caracteres / num_colunas + 1))

	# Mostra as dimensões
	echo $num_caracteres caracteres, $num_colunas colunas, $num_linhas linhas, $largura de largura
	
	# Linha a linha...
	while [ $linha -lt $num_linhas ]
	do
		linha=$((linha+1))

		# Extrai as referências (número da linha dentro do $decimais)
		# para cada caractere que será mostrado nesta linha da tabela.
		# É montado um comando Sed com eles: 5p; 10p; 13p;
		referencias=''
		for col in $colunas
		do
			referencias="$referencias $((num_linhas * col + linha))p;"
		done
		
		# Usando as referências coletadas, percorre cada decimal
		# que será usado nesta linha da tabela
		for decimal in $(echo "$decimais" | sed -n "$referencias")
		do
			hexa=$( printf '%X'   $decimal)
			octal=$(printf '%03o' $decimal) # NNN
			caractere=$(printf "\x$hexa")
			
			# Mostra a célula atual da tabela
			printf "%${largura_coluna}s" "$decimal $hexa $octal $caractere"
		done
		echo
	done
}


# ----------------------------------------------------------------------------
# Protetor de tela (Screen Saver) para console, com cores e temas.
# Temas: mosaico, espaco, olho, aviao, jacare, alien, rosa, peixe, siri.
# Obs.: Aperte Ctrl+C para sair.
# Uso: zzss [--rapido|--fundo] [--tema <tema>] [texto]
# Ex.: zzss
#      zzss fui ao banheiro
#      zzss --rapido /
#      zzss --fundo --tema peixe
# ----------------------------------------------------------------------------
zzss ()
{
	zzzz -h ss $1 && return

	local mensagem tamanho_mensagem mensagem_colorida
	local cor_fixo cor_muda negrito codigo_cores fundo
	local linha coluna dimensoes
	local linhas=25
	local colunas=80
	local tema='mosaico'
	local pausa=1

	local temas='
		mosaico	#
		espaco	.
 		olho	00
		aviao	--o-0-o--
		jacare	==*-,,--,,--
	   	alien	/-=-\\
		rosa	--/--\-<@
		peixe	>-)))-D
 		siri	(_).-=''=-.(_)
	'
	
	# Tenta obter as dimensões atuais da tela/janela
	dimensoes=$(stty size 2>/dev/null)
	if [ "$dimensoes" ]
	then
		linhas=${dimensoes% *}
		colunas=${dimensoes#* }
	fi
	
	# Opções de linha de comando
	while [ $# -ge 1 ]
	do
		case "$1" in
			--fundo)
				fundo=1
			;;
			--rapido)
				unset pausa
			;;
			--tema)
				[ "$2" ] || { zztool uso ss; return; }
				tema=$2
				shift
			;;
			*)
				mensagem="$*"
				unset tema
				break
			;;
		esac
		shift
	done
	
	# Extrai a mensagem (desenho) do tema escolhido
	if [ "$tema" ]
	then
		mensagem=$(
			echo "$temas" |
		 		grep -w "$tema" |
				zztool trim |
				cut -f2
		)
	
		if ! [ "$mensagem" ]
		then
			echo "Tema desconhecido '$tema'"
			return
		fi
	fi
	
	# O 'mosaico' é um tema especial que precisa de ajustes
	if [ "$tema" = 'mosaico' ]
	then
		# Configurações para mostrar retângulos coloridos frenéticos
		mensagem=' '
		fundo=1
		unset pausa
	fi

	# Define se a parte fixa do código de cores será fundo ou frente
	if [ "$fundo" ]
	then
	 	cor_fixo='30;4'
	else
		cor_fixo='40;3'
	fi

	# Então vamos começar, primeiro limpando a tela
	clear
	
	# O 'trap' mapeia o Ctrl-C para sair do Screen Saver
	( trap "clear;return" 2
	
	tamanho_mensagem=${#mensagem}
	
	while :
	do
		# Posiciona o cursor em um ponto qualquer (aleatório) da tela (X,Y)
		# Detalhe: A mensagem sempre cabe inteira na tela ($coluna)
		linha=$((RANDOM % linhas + 1))
		coluna=$((RANDOM % (colunas - tamanho_mensagem + 1) + 1))
		printf "\033[$linha;${coluna}H"
		
		# Escolhe uma cor aleatória para a mensagem (ou o fundo): 1 - 7
		cor_muda=$((RANDOM % 7 + 1))

		# Usar negrito ou não também é escolhido ao acaso: 0 - 1
		negrito=$((RANDOM % 2))
		
		# Podemos usar cores ou não?
		if [ "$ZZCOR" = 1 ]
		then
			codigo_cores="$negrito;$cor_fixo$cor_muda"
			mensagem_colorida="\033[${codigo_cores}m$mensagem\033[m"
		else
			mensagem_colorida="$mensagem"
		fi

		# Mostra a mensagem/desenho na tela e (talvez) espera 1s
		printf "$mensagem_colorida"
		${pausa:+sleep 1}
	done )
}


# ----------------------------------------------------------------------------
# Conversão de telefones contendo letras para apenas números.
# Autor: Rodolfo de Faria <rodolfo faria (a) fujifilm com br>
# Uso: zzfoneletra telefone
# Ex.: zzfoneletra 2345-LINUX              # Retorna 2345-54689
#      echo 5555-HELP | zzfoneletra        # Retorna 5555-4357
# ----------------------------------------------------------------------------
zzfoneletra ()
{
	zzzz -h foneletra $1 && return

	# Um Sed faz tudo, é uma tradução letra a letra
	zztool multi_stdin "$@" |
	 	zzmaiusculas |
	 	sed y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/22233344455566677778889999/
}


# ----------------------------------------------------------------------------
# Codifica/decodifica um texto utilizando a cifra ROT13
# Uso: zzrot13 texto
# Ex.: zzrot13 texto secreto               # Retorna: grkgb frpergb
#      zzrot13 grkgb frpergb               # Retorna: texto secreto
#      echo texto secreto | zzrot13        # Retorna: grkgb frpergb
# ----------------------------------------------------------------------------
zzrot13 ()
{
	zzzz -h rot13 $1 && return

	# Um tr faz tudo, é uma tradução letra a letra
	# Obs.: Dados do tr entre colchetes para funcionar no Solaris
	zztool multi_stdin "$@" |
	 	tr '[a-zA-Z]' '[n-za-mN-ZA-M]'
}


# ----------------------------------------------------------------------------
# Codifica/decodifica um texto utilizando a cifra ROT47
# Uso: zzrot47 texto
# Ex.: zzrot47 texto secreto               # Retorna: E6IE@ D64C6E@
#      zzrot47 E6IE@ D64C6E@               # Retorna: texto secreto
#      echo texto secreto | zzrot47        # Retorna: E6IE@ D64C6E@
# ----------------------------------------------------------------------------
zzrot47 ()
{
	zzzz -h rot47 $1 && return

	# Um tr faz tudo, é uma tradução letra a letra
	# Obs.: Os colchetes são parte da tabela, o tr não funcionará no Solaris
	zztool multi_stdin "$@" |
		tr '!-~' 'P-~!-O'
}


# ----------------------------------------------------------------------------
# Central de alfabetos (romano, militar, radiotelefônico, OTAN, RAF, etc).
# Obs.: Sem argumentos mostra a tabela completa, senão traduz uma palavra.
#
# Tipos reconhecidos:
#
#    --militar | --radio | --fone | --otan | --icao | --ansi
#                            Alfabeto radiotelefônico internacional
#    --romano | --latino     A B C D E F...
#    --royal-navy            Marinha Real - Reino Unido, 1914-1918
#    --signalese             Primeira Guerra, 1914-1918
#    --raf24                 Força Aérea Real - Reino Unido, 1924-1942
#    --raf42                 Força Aérea Real - Reino Unido, 1942-1943
#    --raf                   Força Aérea Real - Reino Unido, 1943-1956
#    --us                    Alfabeto militar norte-americano, 1941-1956
#    --portugal              Lugares de Portugal
#    --names                 Nomes de pessoas, em inglês
#    --lapd                  Polícia de Los Angeles (EUA)
#
# Uso: zzalfabeto [--TIPO] [palavra]
# Ex.: zzalfabeto --militar
#      zzalfabeto --militar cambio
# ----------------------------------------------------------------------------
zzalfabeto ()
{
	zzzz -h alfabeto $1 && return

	local char letra

	local coluna=1
	local dados="\
A:Alpha:Apples:Ack:Ace:Apple:Able/Affirm:Able:Aveiro:Alan:Adam
B:Bravo:Butter:Beer:Beer:Beer:Baker:Baker:Bragança:Bobby:Boy
C:Charlie:Charlie:Charlie:Charlie:Charlie:Charlie:Charlie:Coimbra:Charlie:Charles
D:Delta:Duff:Don:Don:Dog:Dog:Dog:Dafundo:David:David
E:Echo:Edward:Edward:Edward:Edward:Easy:Easy:Évora:Edward:Edward
F:Foxtrot:Freddy:Freddie:Freddie:Freddy:Fox:Fox:Faro:Frederick:Frank
G:Golf:George:Gee:George:George:George:George:Guarda:George:George
H:Hotel:Harry:Harry:Harry:Harry:How:How:Horta:Howard:Henry
I:India:Ink:Ink:Ink:In:Item/Interrogatory:Item:Itália:Isaac:Ida
J:Juliet:Johnnie:Johnnie:Johnnie:Jug/Johnny:Jig/Johnny:Jig:José:James:John
K:Kilo:King:King:King:King:King:King:Kilograma:Kevin:King
L:Lima:London:London:London:Love:Love:Love:Lisboa:Larry:Lincoln
M:Mike:Monkey:Emma:Monkey:Mother:Mike:Mike:Maria:Michael:Mary
N:November:Nuts:Nuts:Nuts:Nuts:Nab/Negat:Nan:Nazaré:Nicholas:Nora
O:Oscar:Orange:Oranges:Orange:Orange:Oboe:Oboe:Ovar:Oscar:Ocean
P:Papa:Pudding:Pip:Pip:Peter:Peter/Prep:Peter:Porto:Peter:Paul
Q:Quebec:Queenie:Queen:Queen:Queen:Queen:Queen:Queluz:Quincy:Queen
R:Romeo:Robert:Robert:Robert:Roger/Robert:Roger:Roger:Rossio:Robert:Robert
S:Sierra:Sugar:Esses:Sugar:Sugar:Sugar:Sugar:Setúbal:Stephen:Sam
T:Tango:Tommy:Toc:Toc:Tommy:Tare:Tare:Tavira:Trevor:Tom
U:Uniform:Uncle:Uncle:Uncle:Uncle:Uncle:Uncle:Unidade:Ulysses:Union
V:Victor:Vinegar:Vic:Vic:Vic:Victor:Victor:Viseu:Vincent:Victor
W:Whiskey:Willie:William:William:William:William:William:Washington:William:William
X:X-ray/Xadrez:Xerxes:X-ray:X-ray:X-ray:X-ray:X-ray:Xavier:Xavier:X-ray
Y:Yankee:Yellow:Yorker:Yorker:Yoke/Yorker:Yoke:Yoke:York:Yaakov:Young
Z:Zulu:Zebra:Zebra:Zebra:Zebra:Zebra:Zebra:Zulmira:Zebedee:Zebra"

	# Escolhe o alfabeto a ser utilizado
	case "$1" in
		--militar|--radio|--fone|--telefone|--otan|--nato|--icao|--itu|--imo|--faa|--ansi)
			coluna=2 ; shift ;;
		--romano|--latino           ) coluna=1  ; shift ;;
		--royal|--royal-navy        ) coluna=3  ; shift ;;
		--signalese|--western-front ) coluna=4  ; shift ;;
		--raf24                     ) coluna=5  ; shift ;;
		--raf42                     ) coluna=6  ; shift ;;
		--raf43|--raf               ) coluna=7  ; shift ;;
		--us41|--us                 ) coluna=8  ; shift ;;
		--pt|--portugal             ) coluna=9  ; shift ;;
		--name|--names              ) coluna=10 ; shift ;;
		--lapd                      ) coluna=11 ; shift ;;
	esac

	if test "$1"
	then
		# Texto informado, vamos fazer a conversão
		# Deixa uma letra por linha e procura seu código equivalente
		echo $* |
			zzmaiusculas |
		 	sed 's/./&\
				/g' |
			while read char
			do
				letra=$(echo "$char" | sed 's/[^A-Z]//g')
				if test "$letra"
				then
					echo "$dados" | grep "^$letra" | cut -d : -f $coluna
				else
					echo "$char"
				fi
			done
	else
		# Apenas mostre a tabela
		echo "$dados" | cut -d : -f $coluna
	fi
}



# ----------------------------------------------------------------------------
# #### A R Q U I V O S
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# Converte arquivos texto no formato Windows/DOS (CR+LF) para o Unix (LF).
# Obs.: Também remove a permissão de execução do arquivo, caso presente.
# Uso: zzdos2unix arquivo(s)
# Ex.: zzdos2unix frases.txt
# ----------------------------------------------------------------------------
zzdos2unix ()
{
	zzzz -h dos2unix $1 && return

	local arquivo
	local tmp="$ZZTMP.dos2unix.$$"

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dos2unix; return; }
	
	for arquivo in "$@"
	do
		# O arquivo existe?
		zztool arquivo_legivel "$arquivo" || continue
		
		# Remove o famigerado CR \r ^M
		cp "$arquivo" "$tmp" &&
		tr -d '\015' < "$tmp" > "$arquivo"
		
		# Segurança
		if [ $? -ne 0 ]
		then
			echo "Ops, algum erro ocorreu em $arquivo"
			echo "Seu arquivo original está guardado em $tmp"
			return
		fi
		
		# Remove a permissão de execução, comum em arquivos DOS
		chmod -x "$arquivo"
		
 		echo "Convertido $arquivo"
	done
	
	# Remove o arquivo temporário
	rm "$tmp"
}


# ----------------------------------------------------------------------------
# Converte arquivos texto no formato Unix (LF) para o Windows/DOS (CR+LF).
# Uso: zzunix2dos arquivo(s)
# Ex.: zzunix2dos frases.txt
# ----------------------------------------------------------------------------
zzunix2dos ()
{
	zzzz -h unix2dos $1 && return

	local arquivo
	local tmp="$ZZTMP.unix2dos.$$"
	local control_m=$(printf '\r') # ^M / CR

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso unix2dos; return; }
	
	for arquivo in "$@"
	do
		# O arquivo existe?
		zztool arquivo_legivel "$arquivo" || continue
		
		# Adiciona um único CR no final de cada linha
		cp "$arquivo" "$tmp" &&
		sed "s/$control_m*$/$control_m/" "$tmp" > "$arquivo"
		
		# Segurança
		if [ $? -ne 0 ]
		then
			echo "Ops, algum erro ocorreu em $arquivo"
			echo "Seu arquivo original está guardado em $tmp"
			return
		fi
				
 		echo "Convertido $arquivo"
	done
	
	# Remove o arquivo temporário
	rm "$tmp"
}


# ----------------------------------------------------------------------------
# Troca a extensão dos arquivos especificados.
# Com a opção -n, apenas mostra o que será feito, mas não executa.
# Uso: zztrocaextensao [-n] antiga nova arquivo(s)
# Ex.: zztrocaextensao -n .doc .txt *          # tire o -n para renomear!
# ----------------------------------------------------------------------------
zztrocaextensao ()
{
	zzzz -h trocaextensao $1 && return
	
	local ext1 ext2 arquivo base novo nao

	# Opções de linha de comando
	if [ "$1" = '-n' ]
	then
		nao='[-n] '
		shift
	fi

	# Verificação dos parâmetros
	[ "$3" ] || { zztool uso trocaextensao; return; }
	
	# Guarda as extensões informadas
	ext1="$1"
	ext2="$2"
	shift; shift
	
	# Tiro no pé? Não, obrigado
	[ "$ext1" = "$ext2" ] && return
	
	# Para cada arquivo informado...
	for arquivo in "$@"
	do
		# O arquivo existe?
		zztool arquivo_legivel "$arquivo" || continue
	
		base="${arquivo%$ext1}"
		novo="$base$ext2"

		# Testa se o arquivo possui a extensão antiga
		[ "$base" != "$arquivo" ] || continue

		# Mostra o que será feito
		echo "$nao$arquivo -> $novo"

		# Se não tiver -n, vamos renomear o arquivo
		if [ ! "$nao" ]
		then
			# Não sobrescreve arquivos já existentes
			zztool arquivo_vago "$novo" || return

			# Vamos lá
			mv -- "$arquivo" "$novo"
		fi
	done
}


# ----------------------------------------------------------------------------
# Troca o conteúdo de dois arquivos, mantendo suas permissões originais.
# Uso: zztrocaarquivos arquivo1 arquivo2
# Ex.: zztrocaarquivos /etc/fstab.bak /etc/fstab
# ----------------------------------------------------------------------------
zztrocaarquivos ()
{
	zzzz -h trocaarquivos $1 && return
	
	# Um terceiro arquivo é usado para fazer a troca
	local tmp="$ZZTMP.trocaarquivos.$$"

	# Verificação dos parâmetros
	[ "$#" -eq 2 ] || { zztool uso trocaarquivos; return; }

	# Verifica se os arquivos existem
	zztool arquivo_legivel "$1" || return
	zztool arquivo_legivel "$2" || return

	# Tiro no pé? Não, obrigado
	[ "$1" = "$2" ] && return
	
	# A dança das cadeiras
	cat "$2"   > "$tmp"
	cat "$1"   > "$2"
	cat "$tmp" > "$1"
	
	# E foi
	rm "$tmp"
	echo "Feito: $1 <-> $2"
}


# ----------------------------------------------------------------------------
# Troca uma palavra por outra, nos arquivos especificados.
# Obs.: Além de palavras, é possível usar expressões regulares.
# Uso: zztrocapalavra antiga nova arquivo(s)
# Ex.: zztrocapalavra excessão exceção *.txt
# ----------------------------------------------------------------------------
# TODO -r (ver zzarrumanome)
zztrocapalavra ()
{
	zzzz -h trocapalavra $1 && return
	
	local arquivo antiga_escapada nova_escapada
	local antiga="$1"
	local nova="$2"

	# Precisa do temporário pois nem todos os Sed possuem a opção -i
	local tmp="$ZZTMP.trocapalavra.$$"
	
	# Verificação dos parâmetros
	[ "$3" ] || { zztool uso trocapalavra; return; }

	# Escapando a barra "/" dentro dos textos de pesquisa
	antiga_escapada=$(echo "$antiga" | sed 's,/,\\/,g')
	nova_escapada=$(  echo "$nova"   | sed 's,/,\\/,g')

	shift; shift
	for arquivo in "$@"
	do
		# O arquivo existe?
		zztool arquivo_legivel "$arquivo" || continue
	
		# Um teste rápido para saber se o arquivo tem a palavra antiga,
		# evitando gravar o temporário desnecessariamente
		grep "$antiga" "$arquivo" >/dev/null 2>&1 || continue
		
		# Uma seqüência encadeada de comandos para garantir que está OK
		cp "$arquivo" "$tmp" &&
		sed "s/$antiga_escapada/$nova_escapada/g" "$tmp" > "$arquivo" && {
			echo "Feito $arquivo" # Está retornando 1 :/
			continue
		}
		
		# Em caso de erro, recupera o conteúdo original
		echo
		echo "Ops, deu algum erro no arquivo $arquivo"
		echo "Uma cópia dele está em $tmp"
		cat "$tmp" > "$arquivo"
		return
	done
	rm -f "$tmp"
}


# ----------------------------------------------------------------------------
# Renomeia arquivos do diretório atual, arrumando nomes estranhos.
# Obs.: Ele deixa tudo em minúsculas, retira acentuação e troca espaços em
#       branco, símbolos e pontuação pelo sublinhado _.
# Opções: -n  apenas mostra o que será feito, não executa
#         -d  também renomeia diretórios
#         -r  funcionamento recursivo (entra nos diretórios)
# Uso: zzarrumanome [-n] [-d] [-r] arquivo(s)
# Ex.: zzarrumanome *
#      zzarrumanome -n -d -r .                   # tire o -n para renomear!
#      zzarrumanome "DOCUMENTO MALÃO!.DOC"       # fica documento_malao.doc
#      zzarrumanome "RAMONES - Don't Go.mp3"     # fica ramones-dont_go.mp3
# ----------------------------------------------------------------------------
zzarrumanome ()
{
	zzzz -h arrumanome $1 && return

	local arquivo caminho antigo novo recursivo pastas nao i

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-d) pastas=1    ;;
			-r) recursivo=1 ;;
			-n) nao="[-n] " ;;
			 *) break       ;;
		esac
		shift
	done
	
	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso arrumanome; return; }
	
	# Para cada arquivo que o usuário informou...
	for arquivo in "$@"
	do
		# Tira a barra no final do nome da pasta
		[ "$arquivo" != / ] && arquivo=${arquivo%/}
		
		# Ignora arquivos e pastas não existentes
		[ -f "$arquivo" -o -d "$arquivo" ] || continue
		
		# Se for uma pasta...
		if test -d "$arquivo"
		then
			# Arruma arquivos de dentro dela (-r)
			[ "${recursivo:-0}" -eq 1 ] &&
			 	zzarrumanome -r ${pastas:+-d} ${nao:+-n} "$arquivo"/*
			
			# Não renomeia nome da pasta (se não tiver -d)
			[ "${pastas:-0}" -ne 1 ] && continue
		fi
		
		# A pasta vai ser a corrente ou o 'dirname' do arquivo (se tiver)
		caminho='.'
		zztool grep_var / "$arquivo" && caminho="${arquivo%/*}"
		
		# $antigo é o arquivo sem path (basename)
		antigo="${arquivo##*/}"
		
		# $novo é o nome arrumado com a magia negra no Sed
		novo=$(
			echo $antigo | # Sem aspas para aproveitar o 'squeeze'
			zzminusculas |
			sed -e "
				# Remove aspas
				s/[\"']//g
				
				# Hífens no início do nome são proibidos
				s/^-/_/
				
				# Remove acentos
				y/àáâãäåèéêëìíîïòóôõöùúûü/aaaaaaeeeeiiiiooooouuuu/
				y/çñß¢Ð£Øø§µÝý¥¹²³/cnbcdloosuyyy123/
				
				# Qualquer caractere estranho vira sublinhado
				s/[^a-z0-9._-]/_/g
				
				# Remove sublinhados consecutivos
				s/__*/_/g
				
				# Remove sublinhados antes e depois de pontos e hífens
				s/_\([.-]\)/\1/g
				s/\([.-]\)_/\1/g"
		)
		
		# Se der problema com a codificação, é o y/// do Sed anterior quem estoura
		if [ $? -ne 0 ]
		then
			echo "Ops. Problemas com a codificação dos caracteres."
			echo "O arquivo original foi preservado: $arquivo"
			return
		fi
		
		# Nada mudou, então o nome atual já certo
		[ "$antigo" = "$novo" ] && continue
		
		# Se já existir um arquivo/pasta com este nome, vai
		# colocando um número no final, até o nome ser único.
		if test -e "$caminho/$novo"
		then
			i=1
			while test -e "$caminho/$novo.$i"
			do
				i=$((i+1))
			done
			novo="$novo.$i"
		fi

		# Tudo certo, temos um nome novo e único
				
		# Mostra o que será feito
		echo "$nao$arquivo -> $caminho/$novo"

		# E faz
		[ "$nao" ] || mv -- "$arquivo" "$caminho/$novo"
	done
}


# ----------------------------------------------------------------------------
# Renomeia arquivos do diretório atual, arrumando a seqüência numérica.
# Obs.: Útil para passar em arquivos de fotos baixadas de uma câmera.
# Opções: -n  apenas mostra o que será feito, não executa
#         -i  define a contagem inicial
#         -d  número de dígitos para o número
#         -p  prefixo padrão para os arquivos
# Uso: zznomefoto [-n] [-i N] [-d N] [-p TXT] arquivo(s)
# Ex.: zznomefoto -n *                        # tire o -n para renomear!
#      zznomefoto -n -p churrasco- *.JPG      # tire o -n para renomear!
#      zznomefoto -n -d 4 -i 500 *.JPG        # tire o -n para renomear!
# ----------------------------------------------------------------------------
zznomefoto ()
{
	zzzz -h nomefoto $1 && return
	
	local arquivo prefixo contagem extensao nome novo nao previa
	local i=1
	local digitos=3

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-p)
				prefixo="$2"
				shift; shift
			;;
			-i)
				i=$2
				shift; shift
			;;
			-d)
				digitos=$2
				shift; shift
			;;
			-n)
				nao='[-n] '
				shift
			;;
			*)
				break
			;;
		esac
	done

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso nomefoto; return; }

	if ! zztool testa_numero "$digitos"
	then
		echo "Número inválido para a opção -d: $digitos"
		return
	fi
	if ! zztool testa_numero "$i"
	then
		echo "Número inválido para a opção -i: $i"
		return
	fi
	
	# Para cada arquivo que o usuário informou...
	for arquivo in "$@"
	do
		# O arquivo existe?
		zztool arquivo_legivel "$arquivo" || continue
	
		# Componentes do nome novo
		contagem=$(printf "%0${digitos}d" $i)
		
		# Se tiver extensão, guarda para restaurar depois
		if zztool grep_var . "$arquivo"
		then
		 	extensao=".${arquivo##*.}"
		else
			extensao=
		fi

		# O nome começa com o prefixo, se informado pelo usuário
		if [ "$prefixo" ]
		then
			nome=$prefixo
		else
			# Se não tiver prefixo, usa o nome base do arquivo original,
			# sem extensão nem números no final (se houver).
			# Exemplo: DSC123.JPG -> DSC
			nome=$(echo "${arquivo%.*}" | sed 's/[0-9][0-9]*$//')
		fi
	
		# Compõe o nome novo e mostra na tela a mudança
		novo="$nome$contagem$extensao"
		previa="$nao$arquivo -> $novo"
		
		if [ "$novo" = "$arquivo" ]
		then
			# Ops, o arquivo novo tem o mesmo nome do antigo
			echo "$previa" | sed "s/^\[-n\]/[-ERRO-]/"
		else
			echo "$previa"
		fi
		
		# Atualiza a contagem (Ah, sério?)
		i=$((i+1))
		
		# Se não tiver -n, vamos renomear o arquivo
		if ! [ "$nao" ]
		then
			# Não sobrescreve arquivos já existentes
			zztool arquivo_vago "$novo" || return

			# E finalmente, renomeia
			mv -- "$arquivo" "$novo"
		fi
	done
}


# ----------------------------------------------------------------------------
# Mostra a diferença entre dois textos, palavra por palavra.
# Útil para conferir revisões ortográficas ou mudanças pequenas em frases.
# Obs.: Se tiver muitas *linhas* diferentes, use o comando diff.
# Uso: zzdiffpalavra arquivo1 arquivo2
# Ex.: zzdiffpalavra texto-orig.txt texto-novo.txt
# ----------------------------------------------------------------------------
zzdiffpalavra ()
{
	zzzz -h diffpalavra $1 && return
	
	local esc
 	local tmp1="$ZZTMP.diffpalavra.1.$$"
	local tmp2="$ZZTMP.diffpalavra.2.$$"
	local n=$(printf '\a')

	# Verificação dos parâmetros
	[ $# -ne 2 ] && { zztool uso diffpalavra; return; }

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


# ----------------------------------------------------------------------------
# Acha as funções de uma biblioteca da linguagem C (arquivos .h).
# Obs.: O diretório padrão de procura é o /usr/include.
# Uso: zzcinclude nome-biblioteca
# Ex.: zzcinclude stdio
#      zzcinclude /minha/rota/alternativa/stdio.h
# ----------------------------------------------------------------------------
zzcinclude ()
{
	zzzz -h cinclude $1 && return
	
	local arquivo="$1"
	
	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso cinclude; return; }

	# Se não começar com / (caminho relativo), coloca path padrão
	[ "${arquivo#/}" = "$arquivo" ] && arquivo="/usr/include/$arquivo.h"
	
	# Verifica se o arquivo existe
	zztool arquivo_legivel "$arquivo" || return
		
	# Saída ordenada, com um Sed mágico para limpar a saída do cpp
	cpp -E "$arquivo" |
		sed '
			/^ *$/d
			/^# /d
			/^typedef/d
			/^[^a-z]/d
			s/ *(.*//
			s/.* \*\{0,1\}//' |
		sort
}


# ----------------------------------------------------------------------------
# Acha os maiores arquivos/diretórios do diretório atual (ou outros).
# Opções: -r  busca recursiva nos subdiretórios
#         -f  busca somente os arquivos e não diretórios
#         -n  número de resultados (o padrão é 10)
# Uso: zzmaiores [-r] [-f] [-n <número>] [dir1 dir2 ...]
# Ex.: zzmaiores
#      zzmaiores /etc /tmp
#      zzmaiores -r -n 5 ~
# ----------------------------------------------------------------------------
zzmaiores ()
{
	zzzz -h maiores $1 && return

	local pastas recursivo modo
	local limite=10

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-n)
				limite=$2
				shift; shift
			;;
			-f)
				modo='f'
				shift
				# Até queria fazer um -d também para diretórios somente,
				# mas o du sempre mostra os arquivos quando está recursivo
				# e o find não mostra o tamanho total dos diretórios...
			;;
			-r)
				recursivo=1
				shift
			;;
			*)
				break
			;;
		esac
	done

	if [ "$modo" = 'f' ]
	then
		# Usuário só quer ver os arquivos e não diretórios.
		# Como o 'du' não tem uma opção para isso, usaremos o 'find'.
	
		# Se forem várias pastas, compõe a lista glob: {um,dois,três}
		# Isso porque o find não aceita múltiplos diretórios sem glob.
		# Caso contrário tenta $1 ou usa a pasta corrente "."
		if [ "$2" ]
		then
			pastas=$(echo {$*} | tr -s ' ' ',')
		else
			pastas=${1:-.}
			[ "$pastas" = '*' ] && pastas='.'
		fi
	
		tab=$(echo -e '\t')
		[ "$recursivo" ] && recursivo= || recursivo='-maxdepth 1'
		
		resultado=$(
			find $pastas $recursivo -type f -ls |
			 	tr -s ' ' |
			 	cut -d' ' -f7,11- |
				sed "s/ /$tab/" |
			 	sort -nr |
			 	sed "$limite q"
		)
	else
		# Tentei de várias maneiras juntar o glob com o $@
		# para que funcionasse com o ponto e sem argumentos,
		# mas no fim é mais fácil chamar a função de novo...
		pastas="$@"
		if [ ! "$pastas" -o "$pastas" = '.' ]
		then
			zzmaiores ${recursivo:+-r} -n $limite * .[^.]*
			return
			
		fi

		# O du sempre mostra arquivos e diretórios, bacana
		# Basta definir se vai ser recursivo (-a) ou não (-s)
		[ "$recursivo" ] && recursivo='-a' || recursivo='-s'
		
		# Estou escondendo o erro para caso o * ou o .* não expandam
		# Bash2: nullglob, dotglob
		resultado=$(
			du $recursivo $pastas 2>/dev/null |
				sort -nr |
				sed "$limite q"
		)
	fi
	# TODO é K (nem é, só se usar -k -- conferir no SF) se vier do du e bytes se do find
	echo "$resultado"
	# | while read tamanho arquivo
	# do
	# 		echo -e "$(zzbyte $tamanho)\t$arquivo"
	# done
}


# ----------------------------------------------------------------------------
# Conta o número de vezes que uma palavra aparece num arquivo.
# Obs.: É diferente do grep -c, que não conta várias palavras na mesma linha.
# Opções: -i  ignora a diferença de maiúsculas/minúsculas
#         -p  busca parcial, conta trechos de palavras
# Uso: zzcontapalavra [-i|-p] palavra arquivo(s)
# Ex.: zzcontapalavra root /etc/passwd
#      zzcontapalavra -i -p a /etc/passwd      # Compare com grep -ci a
# ----------------------------------------------------------------------------
zzcontapalavra ()
{
	zzzz -h contapalavra $1 && return

	local padrao ignora
	local inteira=1
	
	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-p) inteira=  ;;
			-i) ignora=1  ;;
			 *) break     ;;
		esac
		shift
	done

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso contapalavra; return; }
	
	padrao=$1
	shift
	
	# Contorna a limitação do grep -c pesquisando pela palavra
	# e quebrando o resultado em uma palavra por linha (tr).
	# Então pode-se usar o grep -c para contar.
	grep -h ${ignora:+-i} ${inteira:+-w} -- "$padrao" "$@" |
		tr '\t./ -,:-@[-_{-~' '\n' |
		grep -c ${ignora:+-i} ${inteira:+-w} -- "$padrao"
}


# ----------------------------------------------------------------------------
# Mostra uma linha de um texto, aleatória ou informada pelo número.
# Obs.: Se passado um argumento, restringe o sorteio às linhas com o padrão.
# Uso: zzlinha [número | -t texto] [arquivo(s)]
# Ex.: zzlinha /etc/passwd           # mostra uma linha qualquer, aleatória
#      zzlinha 9 /etc/passwd         # mostra a linha 9 do arquivo
#      zzlinha -2 /etc/passwd        # mostra a penúltima linha do arquivo
#      zzlinha -t root /etc/passwd   # mostra uma das linhas com "root"
#      cat /etc/passwd | zzlinha     # o arquivo pode vir da entrada padrão
# ----------------------------------------------------------------------------
zzlinha ()
{
	zzzz -h linha $1 && return

	local arquivo n padrao resultado num_linhas

	# Opções de linha de comando
	if [ "$1" = '-t' ]
	then
		padrao="$2"
		shift; shift
	fi
	
	# Talvez o $1 é o número da linha desejada?
	if zztool testa_numero_sinal "$1"
	then
		n=$1
		shift
	fi

	if [ "$n" ]
	then
		# Se foi informado um número, mostra essa linha.
		# Nota: Suporte a múltiplos arquivos e entrada padrão (STDIN)
		for arquivo in "${@:--}"
		do
			# O arquivo existe?
			zztool arquivo_legivel "$arquivo" || continue
			
			if [ "$n" -lt 0 ]
			then
				tail -n ${n#-} "$arquivo" | sed 1q
			else
				sed -n ${n}p "$arquivo"
			fi
		done
	else
		# TODO: usar zztool multi_stdin e arquivo_legivel
		
		# Se foi informado um padrão (ou nenhum argumento),
		# primeiro grepa as linhas, depois mostra uma linha
		# aleatória deste resultado.
		# Nota: Suporte a múltiplos arquivos e entrada padrão (STDIN)
		resultado=$(grep -h -i -- "${padrao:-.}" "${@:--}")
		num_linhas=$(echo "$resultado" | sed -n '$=')
		n=$(( (RANDOM % num_linhas) + 1))
		[ $n -eq 0 ] && n=1
		echo "$resultado" | sed -n ${n}p
	fi
}


# ----------------------------------------------------------------------------
# Desordena as linhas de um texto (ordem aleatória)
# Uso: zzshuffle [arquivo(s)]
# Ex.: zzshuffle /etc/passwd         # desordena o arquivo de usuários
#      cat /etc/passwd | zzlinha     # o arquivo pode vir da entrada padrão
# ----------------------------------------------------------------------------
zzshuffle ()
{
	zzzz -h shuffle $1 && return

	local linha

	# Suporte a múltiplos arquivos (cat $@) e entrada padrão (cat -)
	cat "${@:--}" |
	
		# Um número aleatório é colocado no início de cada linha,
		# depois o sort ordena numericamente, bagunçando a ordem
		# original. Então os números são removidos.
	 	while read linha
		do
		 	echo "$RANDOM $linha"
		done |
	 	sort |
	 	cut -d ' ' -f 2-
}



# ----------------------------------------------------------------------------
# #### C Á L C U L O
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# Calculadora.
# Os operadores principais são + - / * ^ %, veja outros em "man bc".
# Obs.: Números fracionados podem vir com vírgulas ou pontos: 1,5 ou 1.5.
# Uso: zzcalcula número operação número
# Ex.: zzcalcula 2,20 + 3.30          # vírgulas ou pontos, tanto faz
#      zzcalcula '2^2*(4-1)'          # 2 ao quadrado vezes 4 menos 1
#      echo 2 + 2 | zzcalcula         # lendo da entrada padrão (STDIN)
# ----------------------------------------------------------------------------
zzcalcula ()
{
	zzzz -h calcula $1 && return
	
	local parametros=$(zztool multi_stdin "$@")

	# Entrada de números com vírgulas ou pontos, saída sempre com vírgulas
	echo "scale=2;$parametros" | sed y/,/./ | bc | sed y/./,/
}


# ----------------------------------------------------------------------------
# Faz cálculos com datas e/ou converte data->num e num->data.
# Que dia vai ser daqui 45 dias? Quantos dias há entre duas datas? zzdata!
# Quando chamada com apenas um parâmetro funciona como conversor de data
# para número inteiro (N dias passados desde Epoch) e vice-versa.
# Obs.: Leva em conta os anos bissextos     (Epoch = 01/01/1970, editável)
# Uso: zzdata data|num [+|- data|num]
# Ex.: zzdata 22/12/1999 + 69
#      zzdata hoje - 5
#      zzdata 01/03/2000 - 11/11/1999
#      zzdata hoje - dd/mm/aaaa         <---- use sua data de nascimento
# ----------------------------------------------------------------------------
zzdata ()
{
	zzzz -h data $1 && return

	local yyyy mm dd dias_ano data dias i n y op
	local epoch=1970
	local primeira_data=1
	local dias_mes='31 28 31 30 31 30 31 31 30 31 30 31'
	local data1=$1
	local operacao=$2
	local data2=$3
	local n1=$data1
	local n2=$data2

	# Referências para ano bissexto:
	#
	# A year is a leap year if it is evenly divisible by 4
	# ...but not if it's evenly divisible by 100
	# ...unless it's also evenly divisible by 400
	# http://timeanddate.com
	# http://www.delorie.com/gnu/docs/gcal/gcal_34.html
	
	# Verificação dos parâmetros
	[ $# -eq 3 -o $# -eq 1 ] || { zztool uso data; return; }

	# Esse bloco gigante define $n1 e $n2 baseado nas datas $data1 e $data2.
	# A data é transformada em um número inteiro (dias desde $epoch).
	# Exemplo: 27/07/2007 -> 13721
	# Este é numero usado para fazer os cálculos.
	for data in $data1 $data2
	do
		dias=0 # Guarda o total que irá para $n1 e $n2
		
		# Atalhos úteis para o dia atual
		if [ "$data" = 'hoje' -o "$data" = 'today' ]
		then
			# Qual a data de hoje?
			data=$(date +%d/%m/%Y)
			[ "$primeira_data" ] && data1=$data || data2=$data
		else
			# Valida o formato da data
			# TODO Muito fraquinho, usar regex (zztool)
			if [ "${data##*[^0-9/]}" != "$data" ]
			then
				echo "Data inválida '$data'"
				return
			fi
		fi
		
		# Se tem /, então é uma data e deve ser transformado em número
		if zztool grep_var / "$data"
		then
			n=1
			y=$epoch
			yyyy=${data##*/}
			mm=${data#*/}
			mm=${mm%/*}
			dd=${data%%/*}

			# Retira o zero dos dias e meses menores que 10
			mm=${mm#0}
			dd=${dd#0}

			# Define qual será a operação: adição ou subtração
			op=+
			[ $yyyy -lt $epoch ] && op=-
			
			# Ano -> dias
			while :
			do
				# Sim, os anos bissextos são levados em conta!
				dias_ano=365
				[ $((y%4)) -eq 0 ] && [ $((y%100)) -ne 0 ] || [ $((y%400)) -eq 0 ] && dias_ano=366
				
				# Vai somando (ou subtraindo) até chegar no ano corrente
				[ $y -eq $yyyy ] && break
				dias=$((dias $op dias_ano))
				y=$((y $op 1))
			done
			
			# Meses -> dias
			for i in $dias_mes
			do
				[ $n -eq $mm ] && break
				n=$((n+1))
				
				# Fevereiro de ano bissexto tem 29 dias
				[ $dias_ano -eq 366 -a $i -eq 28 ] && i=29
				
				dias=$((dias+$i))
			done
			
			# Somando os dias da data aos anos+meses já contados (-1)
			dias=$((dias+dd-1))
			
			[ "$primeira_data" ] && n1=$dias || n2=$dias
		fi
		primeira_data=
	done
	
	# Agora que ambas as datas são números inteiros, a conta é feita
	dias=$(($n1 $operacao $n2))
	
	# Se as duas datas foram informadas como dd/mm/aaaa,
	# o resultado é o próprio número de dias, então terminamos.
	if [ "${data1##??/*}" = "${data2##??/*}" ]
	then
		echo $dias
		return
	fi
	
	# Como não caímos no IF anterior, então o resultado será uma data.
	# É preciso converter o número inteiro para dd/mm/aaaa.
	
	y=$epoch
	mm=1
	dd=$((dias+1))
	
	# Dias -> Ano
	while :
	do
		# Novamente, o ano bissexto é levado em conta
		dias_ano=365
		[ $((y%4)) -eq 0 ] && [ $((y%100)) -ne 0 ] || [ $((y%400)) -eq 0 ] && dias_ano=366
		
		# Vai descontando os dias de cada ano para saber quantos anos cabem
		[ $dd -le $dias_ano ] && break
		dd=$((dd-dias_ano))
		y=$((y+1))
	done
	yyyy=$y
	
	# Dias -> mês
	for i in $dias_mes
	do
		# Fevereiro de ano bissexto tem 29 dias
		[ $dias_ano -eq 366 -a $i -eq 28 ] && i=29
	
		# Calcula quantos meses cabem nos dias que sobraram
		[ $dd -le $i ] && break
		dd=$((dd-i))
		mm=$((mm+1))
	done
	
	# Restaura o zero dos meses menores que 10
	[ $dd -le 9 ] && dd=0$dd
	[ $mm -le 9 ] && mm=0$mm
	
	# E finalmente mostra o resultado em formato de data
	echo $dd/$mm/$yyyy
}


# ----------------------------------------------------------------------------
# Faz cálculos com horários.
# A opção -r torna o cálculo relativo à primeira data, por exemplo:
#   02:00 - 03:30 = -01:30 (sem -r) e 22:30 (com -r)
# Uso: zzhora [-r] hh:mm [+|- hh:mm]
# Ex.: zzhora 8:30 + 17:25        # preciso somar duas horas!
#      zzhora 12:00 - agora       # quando falta para o almoço?
#      zzhora -12:00 + -5:00      # horas negativas!
#      zzhora 1000                # quanto é 1000 minutos?
#      zzhora -r 5:30 - 8:00      # que horas ir dormir para acordar às 5:30?
#      zzhora -r agora + 57:00    # e daqui 57 horas, será quando?
# ----------------------------------------------------------------------------
zzhora ()
{
	zzzz -h hora $1 && return

	local hhmm1 hhmm2 operacao
	local hh1 mm1 hh2 mm2 n1 n2 resultado negativo
	local horas minutos dias horas_do_dia hh mm hh_dia extra
	local relativo=0

	# Opções de linha de comando
	if [ "$1" = '-r' ]
	then
		relativo=1
		shift
	fi
	
	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso hora; return; }
	
	# Dados informados pelo usuário (com valores padrão)
	hhmm1="$1"
	operacao="${2:-+}"
	hhmm2="${3:-00}"

	# Somente adição e subtração são permitidas
	if [ "${operacao#[+-]}" ]
	then
	 	echo "Operação Inválida: $operacao"
		return
	fi
	
	# Atalhos bacanas para a hora atual
	[ "$hhmm1" = 'agora' -o "$hhmm1" = 'now' ] && hhmm1=$(date +%H:%M)
	[ "$hhmm2" = 'agora' -o "$hhmm2" = 'now' ] && hhmm2=$(date +%H:%M)
	
	# Se as horas não foram informadas, coloca 00
	[ "${hhmm1#*:}" = "$hhmm1" ] && hhmm1=00:$hhmm1
	[ "${hhmm2#*:}" = "$hhmm2" ] && hhmm2=00:$hhmm2
	
	# Extrai horas e minutos para variáveis separadas
	hh1=${hhmm1%:*}
	mm1=${hhmm1#*:}
	hh2=${hhmm2%:*}
	mm2=${hhmm2#*:}
	
	# Retira o zero das horas e minutos menores que 10
	hh1=${hh1#0}
	mm1=${mm1#0}
	hh2=${hh2#0}
	mm2=${mm2#0}
	
	# Os cálculos são feitos utilizando apenas minutos.
	# Então é preciso converter as horas:minutos para somente minutos.
	n1=$((hh1*60+mm1))
	n2=$((hh2*60+mm2))
	
	# Tudo certo, hora de fazer o cálculo
	resultado=$(($n1 $operacao $n2))
	
	# Resultado negativo, seta a flag e remove o sinal de menos "-"
	if [ $resultado -lt 0 ]
	then
	 	negativo=-
		resultado=${resultado#-}
	fi
	
	# Agora é preciso converter o resultado para o formato hh:mm

	horas=$((resultado/60))
	minutos=$((resultado%60))
	dias=$((horas/24))
	horas_do_dia=$((horas%24))
	
	# Restaura o zero dos minutos/horas menores que 10
	hh=$horas
	mm=$minutos
	hh_dia=$horas_do_dia
	[ $hh -le 9 ] && hh=0$hh
	[ $mm -le 9 ] && mm=0$mm
	[ $hh_dia -le 9 ] && hh_dia=0$hh_dia
	
	#TODO: usar um exemplo com horas negativas
	# Decide como mostrar o resultado para o usuário.
	#
	# Relativo:
	#   $ zzhora -r 10:00 + 48:00
	#   10:00 (2 dias)
	#
	# Normal:
	#   $ zzhora 10:00 + 48:00
	#   58:00 (2d 10h 0m)
	#
	if [ $relativo -eq 1 ]
	then
	
		# Relativo
	
		# Somente em resultados negativos o relativo é útil.
		# Para valores positivos não é preciso fazer nada.
		if [ "$negativo" ]
		then
			# Para o resultado negativo é preciso refazer algumas contas
			minutos=$(( (60-minutos) % 60))
			dias=$((horas/24 + (minutos>0) ))
			hh_dia=$(( (24 - horas_do_dia - (minutos>0)) % 24))
			mm=$minutos

			# Zeros para dias e minutos menores que 10
			[ $mm -le 9 ] && mm=0$mm
			[ $hh_dia -le 9 ] && hh_dia=0$hh_dia
		fi
		
		# "Hoje", "amanhã" e "ontem" são simpáticos no resultado
		case $negativo$dias in
			1)
			 	extra='amanhã'
			;;
			-1)
			 	extra='ontem'
			;;
			0|-0)
			 	extra='hoje'
			;;
			*)
			 	extra="$negativo$dias dias"
			;;
		esac

		echo "$hh_dia:$mm ($extra)"
	else
	
		# Normal
		
		echo "$negativo$hh:$mm (${dias}d ${horas_do_dia}h ${minutos}m)"
	fi
}


# ----------------------------------------------------------------------------
# Faz várias conversões como: caracteres, temperatura e distância.
#          cf = (C)elsius      para (F)ahrenheit
#          fc = (F)ahrenheit   para (C)elsius
#          ck = (C)elsius      para (K)elvin
#          kc = (K)elvin       para (C)elsius
#          fk = (F)ahrenheit   para (K)elvin
#          kf = (K)elvin       para (F)ahrenheit
#          km = (K)Quilômetros para (M)ilhas
#          mk = (M)ilhas       para (K)Quilômetros
#          db = (D)ecimal      para (B)inário
#          bd = (B)inário      para (D)ecimal
#          cd = (C)aractere    para (D)ecimal
#          dc = (D)ecimal      para (C)aractere
#          dh = (D)ecimal      para (H)exadecimal
#          hd = (H)exadecimal  para (D)ecimal
# Uso: zzconverte <cf|fc|ck|kc|fk|kf|mk|km|db|bd|cd|dh|hd> número
# Ex.: zzconverte cf 5
#      zzconverte dc 65
#      zzconverte db 32
# ----------------------------------------------------------------------------
zzconverte ()
{
	zzzz -h converte $1 && return

	local s2='scale=2'
	local operacao=$1
	
	# Verificação dos parâmetros
	[ "$2" ] || { zztool uso converte; return; }
	
	shift
	while [ "$1" ]
	do
		case "$operacao" in
			cf)
				echo "$1 C = $(echo "$s2;($1*9/5)+32"     | bc) F"
			;;
			fc)
		 		echo "$1 F = $(echo "$s2;($1-32)*5/9"     | bc) C"
			;;
			ck)
				echo "$1 C = $(echo "$s2;$1+273.15"       | bc) K"
			;;
			kc)
		 		echo "$1 K = $(echo "$s2;$1-273.15"       | bc) C"
			;;
			kf)
			 	echo "$1 K = $(echo "$s2;($1*1.8)-459.67" | bc) F"
			;;
			fk)
				echo "$1 F = $(echo "$s2;($1+459.67)/1.8" | bc) K"
			;;
			km)
			 	echo "$1 km = $(echo "$s2;$1*0.6214"      | bc) milhas"
			;;
			mk)
			 	echo "$1 milhas = $(echo "$s2;$1*1.609"   | bc) km"
			;;
			db)
			 	echo "obase=2;$1" | bc -l
			;;
			bd)
			 	echo "$((2#$1))"
			;;
			cd)
			 	echo -n "$1" |
			 		od -d |
			 		tr -s '\t ' ' ' |
					cut -d' ' -f2- |
					sed 's/ *$// ; 1q'
			;;
			dc)
			 	awk "BEGIN { printf(\"%c\n\", $1) }"
			
				# XXX " TextMate syntax gotcha (não remover)
			;;
			dh)
				printf '%X\n' "$1"
			;;
			hd)
				printf '%d\n' "0x$1"
			;;
		esac
		shift
	done
}


# ----------------------------------------------------------------------------
# Gera um CPF válido aleatório ou valida um CPF informado.
# Obs.: O CPF informado pode estar formatado (pontos e hífen) ou não.
# Uso: zzcpf [cpf]
# Ex.: zzcpf 123.456.789-09          # valida o CPF
#      zzcpf 12345678909             # com ou sem formatadores
#      zzcpf                         # gera um CPF válido
# ----------------------------------------------------------------------------
zzcpf ()
{
	zzzz -h cpf $1 && return

	local i n somatoria digito1 digito2 cpf base

	# Remove pontuação do CPF informado, deixando apenas números
	cpf="$(echo $* | tr -d -c 0123456789)"
	
	# Extrai os números da base do CPF:
	# Os 9 primeiros, sem os dois dígitos verificadores.
	# Esses dois dígitos serão calculados adiante.
	if [ "$cpf" ]
	then
		# Faltou ou sobrou algum número...
		if [ ${#cpf} -ne 11 ]
		then
			echo 'CPF inválido (deve ter 11 dígitos)'
			return
		fi
		
		# Apaga os dois últimos dígitos
		base=${cpf%??}
	else
		# Não foi informado nenhum CPF, vamos gerar um escolhendo
		# nove dígitos aleatoriamente para formar a base
		while [ ${#cpf} -lt 9 ]
		do
			cpf="$cpf$((RANDOM % 9))"
		done
		base=$cpf
	fi
	
	# Truque para cada dígito da base ser guardado em $1, $2, $3, ...
	set - $(echo $base | sed 's/./& /g')

	# Explicação do algoritmo de geração/validação do CPF:
	#
	# Os primeiros 9 dígitos são livres, você pode digitar quaisquer
	# números, não há seqüência. O que importa é que os dois últimos
	# dígitos, chamados verificadores, estejam corretos.
	#
	# Estes dígitos são calculados em cima dos 9 primeiros, seguindo
	# a seguinte fórmula:
	#
	# 1) Aplica a multiplicação de cada dígito na máscara de números
	#    que é de 10 a 2 para o primeiro dígito e de 11 a 3 para o segundo.
	# 2) Depois tira o módulo de 11 do somatório dos resultados.
	# 3) Diminui isso de 11 e se der 10 ou mais vira zero.
	# 4) Pronto, achou o primeiro dígito verificador.
	#
	# Máscara   : 10    9    8    7    6    5    4    3    2
	# CPF       :  2    2    5    4    3    7    1    0    1
	# Multiplica: 20 + 18 + 40 + 28 + 18 + 35 +  4 +  0 +  2 = Somatória
	#
	# Para o segundo é praticamente igual, porém muda a máscara (11 - 3)
	# e ao somatório é adicionado o dígito 1 multiplicado por 2.
	
	### Cálculo do dígito verificador 1
	# Passo 1
	somatoria=0
	for i in 10 9 8 7 6 5 4 3 2 # máscara
	do
		# Cada um dos dígitos da base ($n) é multiplicado pelo
		# seu número correspondente da máscara ($i) e adicionado
		# na somatória.
		n=$1
		somatoria=$((somatoria + (i * n)))
		shift
	done
	# Passo 2
	digito1=$((11 - (somatoria % 11)))
	# Passo 3
	[ $digito1 -ge 10 ] && digito1=0
	
	### Cálculo do dígito verificador 2
	# Tudo igual ao anterior, primeiro setando $1, $2, $3, etc e
	# depois fazendo os cálculos já explicados.
	#
	set - $(echo $base | sed 's/./& /g')
	# Passo 1
	somatoria=0
	for i in 11 10 9 8 7 6 5 4 3
	do
		n=$1
		somatoria=$((somatoria + (i * n)))
		shift
	done
	# Passo 1 e meio (o dobro do verificador 1 entra na somatória)
	somatoria=$((somatoria + digito1 * 2))
	# Passo 2
	digito2=$((11 - (somatoria % 11)))
	# Passo 3
	[ $digito2 -ge 10 ] && digito2=0
	
	# Mostra ou valida
	if [ ${#cpf} -eq 9 ]
	then
		# Esse CPF foi gerado aleatoriamente pela função.
		# Apenas adiciona os dígitos verificadores e mostra na tela.
		echo $cpf$digito1$digito2 |
		 	sed 's/\(...\)\(...\)\(...\)/\1.\2.\3-/' # nnn.nnn.nnn-nn
	else
		# Esse CPF foi informado pelo usuário.
		# Compara os verificadores informados com os calculados.
		if [ "${cpf#?????????}" = "$digito1$digito2" ]
		then
			echo CPF válido
		else
			# Boa ação do dia: mostrar quais os verificadores corretos
			echo "CPF inválido (deveria terminar em $digito1$digito2)"
		fi
	fi
}


# ----------------------------------------------------------------------------
# Gera um CNPJ válido aleatório ou valida um CNPJ informado.
# Obs.: O CNPJ informado pode estar formatado (pontos e hífen) ou não.
# Uso: zzcnpj [cnpj]
# Ex.: zzcnpj 12.345.678/0001-95      # valida o CNPJ
#      zzcnpj 12345678000195          # com ou sem formatadores
#      zzcnpj                         # gera um CNPJ válido
# ----------------------------------------------------------------------------
zzcnpj ()
{
	zzzz -h cnpj $1 && return

	local i n somatoria digito1 digito2 cnpj base

	# Atenção:
	# Essa função é irmã-quase-gêmea da zzcpf, que está bem
	# documentada, então não vou repetir aqui os comentários.
	#
	# O cálculo dos dígitos verificadores também é idêntico,
	# apenas com uma máscara numérica maior, devido à quantidade
	# maior de dígitos do CNPJ em relação ao CPF.

	cnpj="$(echo $* | tr -d -c 0123456789)"
	
	if [ "$cnpj" ]
	then
		# CNPJ do usuário

		if [ ${#cnpj} -ne 14 ]
		then
			echo 'CNPJ inválido (deve ter 14 dígitos)'
			return
		fi

		base=${cnpj%??}
	else
		# CNPJ gerado aleatoriamente

		while [ ${#cnpj} -lt 8 ]
		do
			cnpj="$cnpj$((RANDOM % 9))"
		done

		cnpj="${cnpj}0001"
		base=$cnpj
	fi

	# Cálculo do dígito verificador 1

	set - $(echo $base | sed 's/./& /g')

	somatoria=0
	for i in 5 4 3 2 9 8 7 6 5 4 3 2
	do
		n=$1
		somatoria=$((somatoria + (i * n)))
		shift
	done

	digito1=$((11 - (somatoria % 11)))
	[ $digito1 -ge 10 ] && digito1=0

	# Cálculo do dígito verificador 2

	set - $(echo $base | sed 's/./& /g')
	
	somatoria=0
	for i in 6 5 4 3 2 9 8 7 6 5 4 3 2
	do
		n=$1
		somatoria=$((somatoria + (i * n)))
		shift
	done
	somatoria=$((somatoria + digito1 * 2))

	digito2=$((11 - (somatoria % 11)))
	[ $digito2 -ge 10 ] && digito2=0

	# Mostra ou valida o CNPJ
	if [ ${#cnpj} -eq 12 ]
	then
		echo $cnpj$digito1$digito2 |
		 	sed 's|\(..\)\(...\)\(...\)\(....\)|\1.\2.\3/\4-|'
	else
		if [ "${cnpj#????????????}" = "$digito1$digito2" ]
		then
			echo CNPJ válido
		else
			# Boa ação do dia: mostrar quais os verificadores corretos
			echo "CNPJ inválido (deveria terminar em $digito1$digito2)"			
		fi
	fi
}


# ----------------------------------------------------------------------------
# Calcula os endereços de rede e broadcast à partir do IP e máscara da rede.
# Obs.: Se não for especificado a máscara, é assumido a 255.255.255.0.
# Uso: zzcalculaip ip [netmask]
# Ex.: zzcalculaip 127.0.0.1 24
#      zzcalculaip 10.0.0.0/8
#      zzcalculaip 192.168.10.0 255.255.255.240
#      zzcalculaip 10.10.10.0
# ----------------------------------------------------------------------------
zzcalculaip ()
{
	zzzz -h calculaip $1 && return

	local endereco mascara rede broadcast
	local mascara_binario mascara_decimal mascara_ip
	local i ip1 ip2 ip3 ip4 nm1 nm2 nm3 nm4 componente

	# Verificação dos parâmetros
	[ $# -eq 0 -o $# -gt 2 ] && { zztool uso calculaip; return; }

	# Obtém a máscara da rede (netmask)
	if zztool grep_var / "$1"
	then
		endereco=${1%/*}
		mascara="${1#*/}"
	else
		endereco=$1
		mascara=${2:-24}
	fi

	# Verificações básicas
	if ! zztool testa_ip $endereco
	then
		echo "IP inválido: $endereco"
		return
	fi
	if ! (zztool testa_ip $mascara || (
	      zztool testa_numero $mascara && test $mascara -le 32))
	then
		echo "Máscara inválida: $mascara"
		return
	fi

	# Guarda os componentes da máscara em $1, $2, ...
	# Ou é um ou quatro componentes: 24 ou 255.255.255.0
	set - $(echo $mascara | tr . ' ')

	# Máscara no formato NN
	if [ $# -eq 1 ]
	then
		# Converte de decimal para binário
		# Coloca N números 1 grudados '1111111' (N=$1)
		# e completa com zeros à direita até 32, com pontos:
		# $1=12 vira 11111111.11110000.00000000.00000000
		mascara=$(printf "%$1s" 1 | tr ' ' 1)
		mascara=$(
			printf '%-32s' $mascara |
			tr ' ' 0 |
			sed 's/./&./24 ; s/./&./16 ; s/./&./8'
		)
	fi
	
	# Conversão de decimal para binário nos componentes do IP e netmask
	for i in 1 2 3 4
	do
		componente=$(echo $endereco | cut -d'.' -f $i)
		eval ip$i=$(printf '%08d' $(zzconverte db $componente))

		componente=$(echo $mascara | cut -d'.' -f $i)
		if [ "$2" ]
		then
			eval nm$i=$(printf '%08d' $(zzconverte db $componente))
		else
			eval nm$i=$componente
		fi
	done
	
	# Uma verificação na máscara depois das conversões
	mascara_binario=$nm1$nm2$nm3$nm4
	if ! (zztool testa_binario $mascara_binario &&
	      test ${#mascara_binario} -eq 32)
	then
		echo 'Máscara inválida'
		return
	fi
	
	mascara_decimal=$(echo $mascara_binario | tr -d 0)
	mascara_decimal=${#mascara_decimal}
	mascara_ip="$((2#$nm1)).$((2#$nm2)).$((2#$nm3)).$((2#$nm4))"
	
	echo "End. IP  : $endereco"
	echo "Mascara  : $mascara_ip = $mascara_decimal"
	
	rede=$(( ((2#$ip1$ip2$ip3$ip4)) & ((2#$nm1$nm2$nm3$nm4)) ))
	i=$(echo $nm1$nm2$nm3$nm4 | tr 01 10)
	broadcast=$(($rede | ((2#$i)) ))
	
	# Cálculo do endereço de rede
	endereco=""
	for i in 1 2 3 4
	do
		ip1=$((rede & 255))
		rede=$((rede >> 8))
		endereco="$ip1.$endereco"
	done
	
	echo "Rede     : ${endereco%.} / $mascara_decimal"

	# Cálculo do endereço de broadcast
	endereco=''
	for i in 1 2 3 4
	do
		ip1=$((broadcast & 255))
		broadcast=$((broadcast >> 8))
		endereco="$ip1.$endereco"
	done
	echo "Broadcast: ${endereco%.}"
}



#-----------8<---------- Daqui pra baixo, funções que fazem busca na Internet.
#----------------------- Podem parar de funcionar se os sites mudarem.


# ----------------------------------------------------------------------------
# #### C O N S U L T A S                                         (Internet)
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# http://br.invertia.com
# Busca a cotação do dia do dólar (comercial, paralelo e turismo).
# Obs.: As cotações são atualizadas de 10 em 10 minutos.
# Uso: zzdolar
# ----------------------------------------------------------------------------
zzdolar ()
{
	zzzz -h dolar $1 && return

	# Faz a consulta e filtra o resultado
	$ZZWWWDUMP 'http://br.invertia.com/mercados/divisas/tiposdolar.aspx' |
		sed '
			# Você acredita que essa sopa de letrinhas funciona?
			# Pois é, eu também não... Mas funciona :)

			s/^ *//
			/Data:/,/Turismo/!d
			/percent/d
			s/  */ /g
			s/.*Data: \(.*\)/\1 compra   venda   hora/
			s|^[1-9]/|0&|
			s@^\([0-9][0-9]\)/\([0-9]/\)@\1/0\2@
			s/^D.lar //
			s/- Corretora//
			s/ SP//g
			s/ [-+]\{0,1\}[0-9.,]\{1,\}  *%$//
			s/al /& /
			s/lo /&   /
			s/mo /&	/
			s/ \([0-9]\) / \1.000 /
			s/\.[0-9]\>/&0/g
			s/\.[0-9][0-9]\>/&0/g
			/^[^0-9]/s/[0-9] /&  /g
			/Var\.%/d
			s/Turismo../Turismo     /' |
		sed '/^Compra/d'
}


# ----------------------------------------------------------------------------
# http://br.invertia.com
# Busca a cotação de várias moedas (mais de 100!) em relação ao dólar.
# Com a opção -t, mostra TODAS as moedas, sem ela, apenas as principais.
# É possível passar várias palavras de pesquisa para filtrar o resultado.
# Obs.: Hora GMT, Dólares por unidade monetária para o Euro e a Libra.
# Uso: zzmoeda [-t] [pesquisa]
# Ex.: zzmoeda
#      zzmoeda -t
#      zzmoeda euro libra
#      zzmoeda -t peso
# ----------------------------------------------------------------------------
zzmoeda ()
{
	zzzz -h moeda $1 && return

	local extra dados formato linha
	local url='http://br.invertia.com/mercados/divisas'
	local padrao='.'

	# Devemos mostrar todas as moedas?
	if [ "$1" = '-t' ]
	then
		extra='divisasregion.aspx?idtel=TODAS'
		shift
	fi
	
	# Prepara o filtro para pesquisar todas as palavras informadas (OU)
	[ "$1" ] && padrao=$(echo $* | sed 's/ /\\|/g')

	# Faz a consulta e filtra o resultado
	dados=$(
		$ZZWWWDUMP "$url/$extra" |
		sed '
			# Limpeza
			/IFRAME:/d
			s/\[.*]//
			s/^  *//
			/[0-9][0-9]$/!d
			
			# Apaga variação (deixa apenas variação-%)
			s/\(.*\) -\{0,1\}[0-9][0-9]*,[0-9]\{4\}/\1/
			
			# Adiciona '-' nas colunas vazias de compra
			/[0-9][,.][0-9]\{4\}.*[0-9][,.][0-9]\{4\}/!s/[0-9][0-9]*[,.][0-9]\{4\}/-  &/

			# Tira espaço da sigla do Peso Mexicano (MXP 24H)
			s/ \([24][48]H\) /-\1 /

			# Separa os campos por @, do fim ao início da linha
			s/  */ /g
			s/\(.*\) /\1@/
			s/\(.*\) /\1@/
			s/\(.*\) /\1@/
			s/\(.*\) /\1@/
			s/\(.*\) /\1@/
			
			# Manda o nome da moeda lá pro final da linha
			# No início desalinha, o printf %s conta UTF errado
			s/\([^@]*\)@\(.*\)/\2@\1/
			
			# Espaços viram _ para não atrapalharem
			y/ /_/' |
		tr @ \\t |
		grep -i "$padrao"
	)
	
	# Pescamos algo?
	[ "$dados" ] || return
	
	# Sim! Então formate uma tabela bonitinha com o resultado
	formato='%-7s %12s %12s %6s %11s  %s'

	printf "$formato\n" Sigla Compra Venda Var.% Hora Moeda
	
	echo "$dados" |
		while read linha
		do
			printf "$formato\n" $linha | tr _ ' '
		done
}


# DESATIVADA: Agora os sites usam AJAX :(
# # ----------------------------------------------------------------------------
# # http://www.itautrade.com.br e http://www.bovespa.com.br
# # Busca a cotação de uma ação na Bovespa.
# # Obs.: As cotações têm delay de 15 min em relação ao preço atual no pregão
# #       Com a opção -i, é mostrado o índice bovespa
# # Autor: Denis Dias de Lima <denis (a) concatenum com>
# # Uso: zzbovespa [-i] código-da-ação
# # Ex.: zzbovespa petr4
# #      zzbovespa -i
# #      zzbovespa
# # ----------------------------------------------------------------------------
# zzbovespa ()
# {
# 	zzzz -h bovespa $1 && return
#
# 	local url='http://www.bovespa.com.br/'
#
# 	[ "$1" ] || {
# 		$ZZWWWDUMP "$url/Indices/CarteiraP.asp?Indice=Ibovespa" |
# 			sed '/^ *Cód/,/^$/!d'
# 		return
# 	}
# 	[ "$1" = "-i" ] && {
# 		$ZZWWWHTML "$url/Home/HomeNoticias.asp" |
# 			sed -n '
# 				/Ibovespa -->/,/IBrX/ {
# 					//d
# 					s/<[^>]*>//g
# 					s/[[:space:]]*//g
# 					s/^&.*\;//
# 					/^$/d
# 					p
# 				}' |
# 			sed '
# 				/^Pon/ {
# 					N
# 					s/^/		   /
# 					s/\n/   /
# 					b
# 				}
#
# 				/^IBO/ N
# 				N
# 				s/\n/  /g
# 				/^<.-- /d
#
# 				:a
# 				s/^\([^0-9]\{1,10\}\)\([0-9][0-9]*\)/\1 \2/
# 				ta'
# 		return
# 	}
# 	url='http://www.itautrade.com.br/itautradenet/Finder/Finder.aspx?Papel='
# 	$ZZWWWDUMP "$url$1" |
# 		sed '
# 			/Ação/,/Oferta/!d
# 			/Fracionário/,/Oferta/!d
# 			//d
# 			/\.gif/d
# 			s/^ *//
# 			/Milhares/q'
# }


# ----------------------------------------------------------------------------
# http://www.wikipedia.org
# Procura na Wikipédia, a enciclopédia livre.
# Obs.: Se nenhum idioma for especificado, é utilizado o português.
#
# Idiomas: de (alemão)    eo (esperanto)  es (espanhol)  fr (francês)
#          it (italiano)  ja (japonês)    la (latin)     pt (português)
#
# Uso: zzwikipedia [-idioma] palavra(s)
# Ex.: zzwikipedia sed
#      zzwikipedia Linus Torvalds
#      zzwikipedia -pt Linus Torvalds
# ----------------------------------------------------------------------------
zzwikipedia ()
{
	zzzz -h wikipedia $1 && return

	local url
	local idioma='pt'

	# Se o idioma foi informado, guarda-o, retirando o hífen
	if [ "${1#-}" != "$1" ]
	then
		idioma="${1#-}"
		shift
	fi
	
	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso wikipedia; return; }

	# Faz a consulta e filtra o resultado, paginando
	url="http://$idioma.wikipedia.org/wiki/"
	$ZZWWWDUMP "$url$(echo $* | sed 's/  */_/g')" |
		sed '
			# Limpeza do conteúdo
			/^Views$/,$ d
			/^Vistas$/,$ d
			/^   #Wikipedia (/d
			/^   #Editar Wikipedia /d
			/^From Wikipedia,/d
			/^Origem: Wikipédia,/d
			/^   Jump to: /d
			/^   Ir para: /d
			/^   This article does not cite any references/d
			/^   Please help improve this article/d
			/^   Wikipedia does not have an article with this exact name./q
			s/^\[edit\] //
			s/^\[editar\] //
			
			# Guarda URL da página e mostra no final, após Categorias
			/^   Obtido em "/ { H; d; }
			/^   Retrieved from "/ { H; d; }
			/^   Categor[a-z]*: /G' |
		cat -s
}


# DESATIVADA: Consultar 2003 é inútil e os anos atuais é travado com CAPTCHA
# # ----------------------------------------------------------------------------
# # http://www.receita.fazenda.gov.br
# # Consulta os lotes de restituição do imposto de renda.
# # Obs.: Funciona para os anos de 2001, 2002 e 2003.
# # Uso: zzirpf ano número-cpf
# # Ex.: zzirpf 2003 123.456.789-69
# # ----------------------------------------------------------------------------
# zzirpf ()
# {
# 	zzzz -h irpf $1 && return
# 	
# 	local url='http://www.receita.fazenda.gov.br/Scripts/srf/irpf'
# 	local ano=$1
# 	local z=${ano#200}
#
# 	# Verificação dos parâmetros
# 	[ "$2" ] || { zztool uso irpf; return; }
# 	
# 	[ "$z" != 1 -a "$z" != 2 -a "$z" != 3 ] && {
# 		echo "Ano inválido '$ano'. Deve ser 2001, 2002 ou 2003."
# 		return
# 	}
# 	$ZZWWWDUMP "$url/$ano/irpf$ano.dll?VerificaDeclaracao&CPF=$2" |
# 		sed '1,8d; s/^ */  /; /^  \[BUTTON\]/,$d'
# }


# DESATIVADA: Agora o site dos Correios usa AJAX :(
# # ----------------------------------------------------------------------------
# # http://www.correios.com.br/servicos/cep
# # Busca o CEP de qualquer rua de qualquer cidade do país ou vice-versa.
# # Uso: zzcep estado cidade rua
# # Ex.: zzcep PR curitiba rio gran
# #      zzcep RJ 'Rio de Janeiro' Vinte de
# # ----------------------------------------------------------------------------
# zzcep ()
# {
# 	zzzz -h cep $1 && return
#
# 	local r c
# 	local url='http://www.correios.com.br/servicos/cep'
# 	local e="$1"
#
# 	# Verificação dos parâmetros
# 	[ "$3" ] || { zztool uso cep; return; }
#
# 	c=$(echo "$2"| sed "$ZZSEDURL")
# 	shift
# 	shift
# 	r=$(echo "$*"| sed "$ZZSEDURL")
# 	echo "UF=$e&Localidade=$c&Tipo=&Logradouro=$r" |
# 		$ZZWWWPOST "$url" |
# 		sed -n '
# 			/^ *UF:/,/^$/ {
# 				/Página Anter/d
# 				s/.*óxima Pág.*/...CONTINUA/
# 				p
# 			}'
# }


# DESATIVADA: Agora a consulta é travada com CAPTCHA
# # ----------------------------------------------------------------------------
# # http://www.pr.gov.br/detran
# # Consulta débitos do veículo, como licenciamento, IPVA e multas (detran-PR)
# # Uso: zzdetranpr número-renavam
# # Ex.: zzdetranpr 123456789
# # ----------------------------------------------------------------------------
# zzdetranpr ()
# {
# 	zzzz -h detranpr $1 && return
#
# 	local url='http://celepar7.pr.gov.br/detran_novo/consultas/veiculos/deb_novo.asp'
#
# 	# Verificação dos parâmetros
# 	[ "$1" ] || { zztool uso detranpr; return; }
#
# 	# Faz a consulta e filtra o resultado (usando magia negra)
# 	$ZZWWWDUMP "$url?ren=$1" |
# 		sed 's/^  *//' |
# 		sed '
# 			# Remove linhas em branco
# 			/^$/ d
#
# 			# Transforma barra horizontal em linha em branco
# 			s/___*//
#
# 			# Apaga a lixarada
# 			1,/^Data: / d
# 			/^Informa..es do Ve.culo/ d
# 			/^Discrimina..o dos D.bitos/ d
# 			/\[BUTTON\]/,$ d
# 			/^Discrimina..o das Multas/,/^Resumo das Multas/ d
#
# 			# Quebra a linha para dados da segunda coluna da tabela
# 			s/Renavam:/@&/
# 			s/Ano de Fab/@&/
# 			s/Combust.vel:/@&/
# 			s/Cor:/@&/
# 			' |
# 		tr @ '\n'
# }


# ----------------------------------------------------------------------------
# http://www.detran.sp.gov.br
# Consulta débitos do veículo, como licenciamento, IPVA e multas (Detran-SP).
# Autor: Elton Simões Baptista <elton (a) inso com br>
# Uso: zzdetransp número-renavam
# Ex.: zzdetransp 123456789
# ----------------------------------------------------------------------------
zzdetransp ()
{
	zzzz -h detransp $1 && return

	local url='http://www1.ssp.sp.gov.br/multas/detran/resultMultas.asp'

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso detransp; return; }
	
	# Faz a consulta e filtra o resultado
	echo "renavam=$1&submit=Pesquisar" |
		$ZZWWWPOST "$url" |
		sed '
			1d
			s/^  *//
			/^\[/d
			/^Esta pesquisa tem /, $ d'
}


# ----------------------------------------------------------------------------
# http://www1.caixa.gov.br/loterias
# Consulta os resultados da quina, megasena, duplasena, lotomania e lotofácil.
# Obs.: Se nenhum argumento for passado, todas as loterias são mostradas.
# Uso: zzloteria [quina | megasena | duplasena | lotomania | lotofacil]
# Ex.: zzloteria
#      zzloteria quina megasena
# ----------------------------------------------------------------------------
zzloteria ()
{
	zzzz -h loteria $1 && return

	local dump numero_concurso data resultado acumulado tipo
	local url='http://www1.caixa.gov.br/loterias/loterias'
	local tipos='quina megasena duplasena lotomania lotofacil'
	
	# O padrão é mostrar todos os tipos, mas o usuário pode informar alguns
	[ "$1" ] && tipos=$*

	# Para cada tipo de loteria...
	for tipo in $tipos
	do
		zztool eco $tipo:

		# Há várias pegadinhas neste código. Alguns detalhes:
		# - A variável $dump é um cache local do resultado
		# - É usado ZZWWWDUMP+filtros (e não ZZWWWHTML) para forçar a saída em UTF-8
		# - O resultado é deixado como uma única longa linha
		# - O resultado são vários campos separados por pipe |
		# - Cada tipo de loteria traz os dados em posições (e formatos) diferentes :/
		
		dump=$($ZZWWWDUMP "$url/$tipo/${tipo}_pesquisa.asp" |
			tr -d \\n |
			sed 's/  */ /g ; s/^ //')
		
		# O número do concurso é sempre o primeiro campo
		numero_concurso=$(echo "$dump" | cut -d '|' -f 1)

		case "$tipo" in
			lotomania)
				# O resultado vem separado em campos distintos. Exemplo:
				# |01|04|06|12|21|25|27|36|42|44|50|51|53|59|68|69|74|78|87|91|91|
				
				data=$(     echo "$dump" | cut -d '|' -f 42)
				acumulado=$(echo "$dump" | cut -d '|' -f 69,70)
				resultado=$(echo "$dump" | cut -d '|' -f 7-26 |
			 		sed 's/|/@/10 ; s/|/ - /g' |
					tr @ '\n'
				)
			;;
			lotofacil)
				# O resultado vem separado em campos distintos. Exemplo:
				# |01|04|07|08|09|10|12|14|15|16|21|22|23|24|25|
				
				data=$(     echo "$dump" | cut -d '|' -f 35)
				acumulado=$(echo "$dump" | cut -d '|' -f 54,55)
				resultado=$(echo "$dump" | cut -d '|' -f 4-18 |
					sed 's/|/@/10 ; s/|/@/5 ; s/|/ - /g' |
					tr @ '\n'
				)
			;;
			megasena)
				# O resultado vem separado por asteriscos. Exemplo:
				# | * 16 * 58 * 43 * 37 * 52 * 59 |
				
				data=$(     echo "$dump" | cut -d '|' -f 12)
				acumulado=$(echo "$dump" | cut -d '|' -f 22,23)
				resultado=$(echo "$dump" | cut -d '|' -f 21 |
					tr '*' '-'  |
					tr '|' '\n' |
					sed 's/^ - //'
				)
			;;
			duplasena)
				# O resultado vem separado por asteriscos, tendo dois grupos
				# numéricos: o primeiro e segundo resultado. Exemplo:
				# | * 05 * 07 * 09 * 21 * 38 * 40 | * 05 * 17 * 20 * 22 * 31 * 45 |

				data=$(     echo "$dump" | cut -d '|' -f 18)
				acumulado=$(echo "$dump" | cut -d '|' -f 23,24)
				resultado=$(echo "$dump" | cut -d '|' -f 4,5 |
					tr '*' '-'  |
					tr '|' '\n' |
					sed 's/^ - //'
				)
			;;
			quina)
				# O resultado vem duplicado em um único campo, sendo a segunda
				# parte o resultado ordenado numericamente. Exemplo:
				# | * 69 * 42 * 13 * 56 * 07 * 07 * 13 * 42 * 56 * 69 |
				
				data=$(     echo "$dump" | cut -d '|' -f 17)
				acumulado=$(echo "$dump" | cut -d '|' -f 18,19)
				resultado=$(echo "$dump" | cut -d '|' -f 15 |
					sed 's/\* /|/6' |
					tr '*' '-'  |
					tr '|' '\n' |
					sed 's/^ - // ; 1d'
				)
			;;
		esac
		
		# Mostra o resultado na tela (caso encontrado algo)
		if [ "$resultado" ]
		then
			echo "$resultado" | sed 's/^/   /'
			echo "   Concurso $numero_concurso ($data)"
			[ "$acumulado" ] && echo "   Acumulado em R$ $acumulado" | sed 's/|/ para /'
			echo
		fi
	done
}



# ----------------------------------------------------------------------------
# #### P R O G R A M A S                                         (Internet)
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# http://freshmeat.net
# Procura por programas na base do site Freshmeat.
# Uso: zzfreshmeat programa
# Ex.: zzfreshmeat tetris
# ----------------------------------------------------------------------------
zzfreshmeat ()
{
	zzzz -h freshmeat $1 && return
	
	local url='http://freshmeat.net/search/'
	local padrao=$1
	
	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso freshmeat; return; }
	
	# Faz a consulta e filtra o resultado
	$ZZWWWLIST "$url?q=$padrao" |
		sed -n 's@.*\(http.*freshmeat.net/projects/.*\)/@\1@p'
}


# ----------------------------------------------------------------------------
# http://rpmfind.net/linux
# Procura por pacotes RPM em várias distribuições de Linux.
# Obs.: A arquitetura padrão de procura é a i386.
# Uso: zzrpmfind pacote [distro] [arquitetura]
# Ex.: zzrpmfind sed
#      zzrpmfind lilo mandr i586
# ----------------------------------------------------------------------------
zzrpmfind ()
{
	zzzz -h rpmfind $1 && return

	local url='http://rpmfind.net/linux/rpm2html/search.php'
	local pacote=$1
	local distro=$2
	local arquitetura=${3:-i386}
	
	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso rpmfind; return; }
	
	# Faz a consulta e filtra o resultado
	zztool eco 'ftp://rpmfind.net/linux/'
	$ZZWWWLIST "$url?query=$pacote&submit=Search+...&system=$distro&arch=$arquitetura" |
		sed -n '/ftp:\/\/rpmfind/ s@^[^A-Z]*/linux/@  @p' |
		sort
}



# ----------------------------------------------------------------------------
# #### D I V E R S O S                                           (Internet)
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# http://www.iana.org/cctld/cctld-whois.htm
# Busca a descrição de um código de país da internet (.br, .ca etc).
# Uso: zzdominiopais [.]código|texto
# Ex.: zzdominiopais .br
#      zzdominiopais br
#      zzdominiopais republic
# ----------------------------------------------------------------------------
zzdominiopais ()
{
	zzzz -h dominiopais $1 && return

	local url='http://www.iana.org/root-whois/index.html'
	local cache="$ZZTMP.dominiopais"
	local cache_sistema='/usr/share/zoneinfo/iso3166.tab'
	local padrao=$1

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dominiopais; return; }
	
	# Se o padrão inicia com ponto, retira-o e casa somente códigos
	if [ "${padrao#.}" != "$padrao" ]
	then
		padrao="^${padrao#.}"
	fi

	# Primeiro tenta encontrar no cache do sistema
	if test -f "$cache_sistema"
	then
		# O formato padrão de saída é BR - Brazil
		grep -i "$padrao" $cache_sistema |
			tr -s '\t ' ' ' |
			sed '/^#/d ; / - /!s/ / - /'
		return
	fi

	# Ops, não há cache do sistema, então tentamos o cache da Internet

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" |
			sed -n 's/^  *\.// ; s/country-code/-/p' > "$cache"
	fi

	# Pesquisa no cache
	grep -i "$padrao" "$cache"
}


# ----------------------------------------------------------------------------
# http://funcoeszz.net/locales.txt
# Busca o código do idioma (locale). Por exemplo, português é pt_BR.
# Com a opção -c, pesquisa somente nos códigos e não em sua descrição.
# Uso: zzlocale [-c] código|texto
# Ex.: zzlocale chinese
#      zzlocale -c pt
# ----------------------------------------------------------------------------
zzlocale ()
{
	zzzz -h locale $1 && return
	
	local url='http://funcoeszz.net/locales.txt'
	local cache="$ZZTMP.locale"
	local padrao="$1"

	# Opções de linha de comando
	if [ "$1" = '-c' ]
	then
		# Padrão de pesquisa válido para última palavra da linha (código)
		padrao="$2[^ ]*$"
		shift
	fi

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso locale; return; }
	
	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" > "$cache"
	fi
		
	# Faz a consulta
	grep -i -- "$padrao" "$cache"
}


# ----------------------------------------------------------------------------
# http://pgp.mit.edu
# Busca a identificação da chave PGP, fornecido o nome ou e-mail da pessoa.
# Uso: zzchavepgp nome|e-mail
# Ex.: zzchavepgp Carlos Oliveira da Silva
#      zzchavepgp carlos@dominio.com.br
# ----------------------------------------------------------------------------
zzchavepgp ()
{
	zzzz -h chavepgp $1 && return

	local url='http://pgp.mit.edu:11371'
	local padrao=$(echo $*| sed "$ZZSEDURL")

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso chavepgp; return; }

	$ZZWWWDUMP "http://pgp.mit.edu:11371/pks/lookup?search=$padrao&op=index" |
		sed 1,2d
}


# ----------------------------------------------------------------------------
# http://www.dicas-l.unicamp.br
# Procura por dicas sobre determinado assunto na lista Dicas-L.
# Obs.: As opções do grep podem ser usadas (-i já é padrão).
# Uso: zzdicasl [opção-grep] palavra(s)
# Ex.: zzdicasl ssh
#      zzdicasl -w vi
#      zzdicasl -vEw 'windows|unix|emacs'
# ----------------------------------------------------------------------------
zzdicasl ()
{
	zzzz -h dicasl $1 && return

	local opcao_grep
	local url='http://www.dicas-l.com.br/dicas-l/'

	# Guarda as opções para o grep (caso informadas)
	[ "${1##-*}" ] || {
		opcao_grep=$1
		shift
	}

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dicasl; return; }

	# Faz a consulta e filtra o resultado
	zztool eco "$url"
	$ZZWWWHTML "$url" |
		zztool texto_em_iso |
		grep -i $opcao_grep "$*" |
		sed -n 's@^<LI><A HREF=\([^>]*\)> *\([^ ].*\)</A>@\1: \2@p'
}


# ----------------------------------------------------------------------------
# http://registro.br
# Mostra informações sobre domínios brasileiros (.com.br, .org.br, etc).
# Uso: zzwhoisbr domínio
# Ex.: zzwhoisbr abc.com.br
#      zzwhoisbr www.abc.com.br
# ----------------------------------------------------------------------------
zzwhoisbr ()
{
	zzzz -h whoisbr $1 && return

	local url='http://registro.br/cgi-bin/whois/'
	local dominio="${1#www.}" # tira www do início

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso whoisbr; return; }

	# Faz a consulta e filtra o resultado
	$ZZWWWDUMP "$url?qr=$dominio" |
		sed '
			s/^  *//
			1,/^%/d
			/^remarks/,$d
			/^%/d
			/^alterado/d
			/atualizado /d'
}


# ----------------------------------------------------------------------------
# http://www.whatismyip.com
# Mostra o seu número IP (externo) na Internet.
# Uso: zzipinternet
# Ex.: zzipinternet
# ----------------------------------------------------------------------------
zzipinternet ()
{
	zzzz -h ipinternet $1 && return

	local url='http://whatismyip.com/automation/n09230945.asp'

	# O resultado já vem pronto!
	$ZZWWWHTML "$url"
	echo
}


# ----------------------------------------------------------------------------
# http://www.ibiblio.org
# Procura documentos do tipo HOWTO.
# Uso: zzhowto [--atualiza] palavra
# Ex.: zzhowto apache
#      zzhowto --atualiza
# ----------------------------------------------------------------------------
zzhowto ()
{
	zzzz -h howto $1 && return

	local padrao
	local cache="$ZZTMP.howto"
	local url='http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html_single/'

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso howto; return; }

	# Força atualização da listagem apagando o cache
	if [ "$1" = '--atualiza' ]
	then
		rm -f "$cache"
		shift
	fi

	padrao=$1
	
	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWHTML "$url" |
			sed -n '/alt="\[TXT\]"/ {
				s/^.*href="\([^"]*\).*/\1/
				p
			}' > "$cache"
	fi
	
	# Pesquisa o termo (se especificado)
	if [ "$padrao" ]
	then
		zztool eco "$url"
		grep -i "$padrao" "$cache"
	fi
}


# ----------------------------------------------------------------------------
# http://... - vários
# Busca as últimas notícias sobre Linux em sites nacionais.
# Obs.: Cada site tem uma letra identificadora que pode ser passada como
#       parâmetro, para informar quais sites você quer pesquisar:
#
#         Y)ahoo Linux         B)r Linux
#         C)ipsga              N)otícias linux
#         V)iva o Linux        U)nder linux
#
# Uso: zznoticiaslinux [sites]
# Ex.: zznoticiaslinux
#      zznoticiaslinux yn
# ----------------------------------------------------------------------------
zznoticiaslinux ()
{
	zzzz -h noticiaslinux $1 && return

	local url limite
	local n=5
	local sites='byvucin'

	limite="sed ${n}q"
	
	[ "$1" ] && sites="$1"
	
	# Yahoo
	if zztool grep_var y "$sites"
	then
		url='http://br.news.yahoo.com/tecnologia/linux'
		echo
		zztool eco "* Yahoo Linux ($url):"
		$ZZWWWHTML "$url" |
			sed -n '
				/topheadline/ {
					n
					s,</a>.*,,
					s/<[^>]*>//gp
				}
				/^      <a href=/ s/<[^>]*>//gp' |
			sed 's/^[[:blank:]]*//' |
			zztool texto_em_utf8 |
			$limite
	fi
	
	# Viva o Linux
	if zztool grep_var v "$sites"
	then
		url='http://www.vivaolinux.com.br'
		echo
		zztool eco "* Viva o Linux ($url):"
		
		# TODO Em alguns sistemas as notícias vêm gzipadas, tendo que
		# abrir com gzip -d. Reportado por Rodrigo Azevedo.
		
		$ZZWWWHTML "$url/index.rdf" |
			sed -n '1,/<item>/d;s@.*<title>\(.*\)</title>@\1@p' |
			zztool texto_em_utf8 |
			$limite
	fi
	
	# Cipsga
	if zztool grep_var c "$sites"
	then
		url='http://www.cipsga.org.br'
		echo
		zztool eco "* CIPSGA ($url):"
		$ZZWWWDUMP "$url" |
			cat -s |
		 	sed '1,/vantagens exclusivas/d' |
		  	sed -n '/^$/{ n; p; }' |
		 	sed '/^$/q ; s/^  *//' |
			$limite
	fi
	
	# Br Linux
	if zztool grep_var b "$sites"
	then
		url='http://br-linux.org/feed/'
		echo
		zztool eco "* BR Linux ($url):"
		$ZZWWWHTML "$url" |
			sed -n '1,/<item>/d ; s/.*<title>// ; s@</title>@@p' |
			sed 's/&#822[01];/"/g' |
			zztool texto_em_utf8 |
			$limite
	fi
	
	# UnderLinux
	if zztool grep_var u "$sites"
	then
		url='http://feeds.feedburner.com/underlinux'
		echo
		zztool eco "* UnderLinux ($url):"
		$ZZWWWHTML "$url" |
			sed -n '1,/<item>/d ; s/.*<title>// ; s@</title>@@p' |
			zztool texto_em_utf8 |
			$limite
	fi
	
	# Notícias Linux
	if zztool grep_var n "$sites"
	then
		url='http://www.noticiaslinux.com.br'
		echo
		zztool eco "* Notícias Linux ($url):"
		$ZZWWWHTML "$url" |
			sed -n '/<[hH]3>/{s/<[^>]*>//g;s/^[[:blank:]]*//g;p;}' |
			zztool texto_em_iso |
			$limite
	fi
}


# ----------------------------------------------------------------------------
# http://... - vários
# Busca as últimas notícias sobre linux em sites em inglês.
# Obs.: Cada site tem uma letra identificadora que pode ser passada como
#       parâmetro, para informar quais sites você quer pesquisar:
#
#          F)reshMeat         Linux T)oday
#          S)lashDot          Linux W)eekly News
#          N)ewsForge         O)S News
#
# Uso: zzlinuxnews [sites]
# Ex.: zzlinuxnews
#      zzlinuxnews fsn
# ----------------------------------------------------------------------------
zzlinuxnews ()
{
	zzzz -h linuxnews $1 && return

	local url limite
	local n=5
	local sites='fsntwo'

	limite="sed ${n}q"
	
	[ "$1" ] && sites="$1"

	# Freshmeat
	if zztool grep_var f "$sites"
	then
		url='http://freshmeat.net'
		echo
		zztool eco "* FreshMeat ($url):"
		$ZZWWWHTML "$url" |
			sed '/href="\/releases/!d;s/<[^>]*>//g;s/&nbsp;//g;s/^ *- //' |
			$limite
	fi

	# Slashdot
	if zztool grep_var s "$sites"
	then
		url='http://slashdot.org'
		echo
		zztool eco "* SlashDot ($url):"
		$ZZWWWHTML "$url" |
			sed -n '/<div class="title">/,/<\/div>/{/slashdot/{
		  s/<[^>]*>//g;s/^[[:blank:]]*//;p;};}' |
			$limite
	fi

	# Newsforge
	if zztool grep_var n "$sites"
	then
		url='http://www.newsforge.com'
		echo
		zztool eco "* NewsForge - ($url):"
		$ZZWWWHTML "$url" |
			sed -n '/<h3>/{ n; s/<[^>]*>//gp; }' |
			sed 's/^  *//' |
			$limite
	fi

	# Linux Today
	if zztool grep_var t "$sites"
	then
		url='http://linuxtoday.com/backend/biglt.rss'
		echo
		zztool eco "* Linux Today ($url):"
		$ZZWWWHTML "$url" |
			sed -n '1,/<item>/d;s@.*<title>\(.*\)</title>@\1@p' |
			$limite
	fi

	# LWN
	if zztool grep_var w "$sites"
	then
		url='http://lwn.net/Articles'
		echo
		zztool eco "* Linux Weekly News - ($url):"
		$ZZWWWHTML "$url" |
			sed '/class="Headline"/!d;s/^ *//;s/<[^>]*>//g' |
			$limite
	fi

	# OS News
	if zztool grep_var o "$sites"
	then
		url='http://osnews.com'
		echo
		zztool eco "* OS News - ($url):"
		$ZZWWWDUMP "$url" |
			sed -n '/^ *By /{g;s/^ *//;p;};h' |
			$limite
	fi
}


# ----------------------------------------------------------------------------
# http://... - vários
# Busca as últimas notícias em sites especializados em segurança.
# Obs.: Cada site tem uma letra identificadora que pode ser passada como
#       parâmetro, para informar quais sites você quer pesquisar:
#
#       Linux Security B)rasil    Linux T)oday - Security
#       Linux S)ecurity           Security F)ocus
#       C)ERT/CC
#
# Uso: zznoticiassec [sites]
# Ex.: zznoticiassec
#      zznoticiassec bcf
# ----------------------------------------------------------------------------
zznoticiassec ()
{
	zzzz -h noticiassec $1 && return

	local url limite
	local n=5
	local sites='bsctf'

	limite="sed ${n}q"

	[ "$1" ] && sites="$1"

	# LinuxSecurity Brasil
	if zztool grep_var b "$sites"
	then
		url='http://www.linuxsecurity.com.br/share.php'
		echo
		zztool eco "* LinuxSecurity Brasil ($url):"
		$ZZWWWHTML "$url" |
			sed -n '/item/,$ s@.*<title>\(.*\)</title>@\1@p' |
			zztool texto_em_iso |
			$limite
	fi

	# Linux Security
	if zztool grep_var s "$sites"
	then
		url='http://www.linuxsecurity.com/linuxsecurity_advisories.rdf'
		echo
		zztool eco "* Linux Security ($url):"
		$ZZWWWHTML "$url" |
			sed -n '/item/,$ s@.*<title>\(.*\)</title>@\1@p' |
			$limite
	fi

	# CERT/CC
	if zztool grep_var c "$sites"
	then
		url='http://www.us-cert.gov/channels/techalerts.rdf'
		echo
		zztool eco "* CERT/CC ($url):"
		$ZZWWWHTML "$url" |
			sed -n '/item/,$ s@.*<title>\(.*\)</title>@\1@p' |
			$limite
	fi

	# Linux Today - Security
	if zztool grep_var t "$sites"
	then
		url='http://linuxtoday.com/security/index.html'
		echo
		zztool eco "* Linux Today - Security ($url):"
		$ZZWWWHTML "$url" |
			sed -n '/class="nav"><B>/s/<[^>]*>//gp' |
			$limite
	fi

	# Security Focus
	if zztool grep_var f "$sites"
	then
		url='http://www.securityfocus.com/bid'
		echo
		zztool eco "* SecurityFocus Vulns Archive ($url):"
		$ZZWWWDUMP "$url" |
			sed -n '
				/^ *\([0-9]\{4\}-[0-9][0-9]-[0-9][0-9]\)/ {
					G
					s/^ *//
					s/\n//p
				}
				h' |
			$limite
	fi
}


# ----------------------------------------------------------------------------
# http://... - vários
# Mostra os últimos 5 avisos de segurança de sistemas de Linux/UNIX.
# Suportados: Debian Fedora FreeBSD Gentoo Mandriva Slackware Suse Ubuntu.
# Uso: zzsecurity [distros]
# Ex.: zzsecutiry
#      zzsecurity fedora
#      zzsecurity debian gentoo
# ----------------------------------------------------------------------------
zzsecurity ()
{
	zzzz -h security $1 && return

	local url limite distros
	local n=5
	local ano=$(date '+%Y')
	local distros='debian fedora freebsd gentoo mandriva slackware suse ubuntu'
	
	limite="sed ${n}q"

	[ "$1" ] && distros="$(echo $* | zzminusculas)"
	
	# Debian
	if zztool grep_var debian "$distros"
	then
		url='http://www.debian.org'
		echo
		zztool eco '** Atualizações Debian woody'
		echo "$url"
		$ZZWWWDUMP "$url" |
			sed -n '
				/Security Advisories/,/_______/ {
					/\[[0-9]/ s/^ *//p
				}' |
			$limite
	fi

	# Slackware
	if zztool grep_var slackware "$distros"
	then
		echo
		zztool eco '** Atualizações Slackware'
		url="http://www.slackware.com/security/list.php?l=slackware-security&y=$ano"
		echo "$url"
		$ZZWWWDUMP "$url" |
			sed '
				/[0-9]\{4\}-[0-9][0-9]/!d
				s/\[sla.*ty\]//
				s/^  *//' |
			$limite
	fi

	# Gentoo
	if zztool grep_var gentoo "$distros"
	then
		echo
		zztool eco '** Atualizações Gentoo'
		url='http://www.gentoo.org/security/en/index.xml'
		echo "$url"
		$ZZWWWDUMP "$url" |
			sed -n '
				s/^  *//
				/^GLSA/, /^$/ !d
				/[0-9]\{4\}/ {
					s/\([-0-9]* \) *[a-zA-Z]* *\(.*[^ ]\)  *[0-9][0-9]* *$/\1\2/
					p
				}' |
			$limite
	fi

	# Mandriva
	if zztool grep_var mandriva "$distros"
	then
		echo
		zztool eco '** Atualizações Mandriva'
		url='http://www.mandriva.com/en/rss/feed/security'
		echo "$url"
		$ZZWWWHTML "$url" |
			sed -n '/<title>/{
				s/<[^>]*>//g
				s/^ *//
				/^Mandriva/d
				p
			}' |
			$limite
	fi

	# Suse
	if zztool grep_var suse "$distros"
	then
		echo
		zztool eco '** Atualizações Suse'
		url='http://www.novell.com/linux/security/advisories.html'
		echo "$url"
		$ZZWWWDUMP "$url" |
			sed -n 's/^.* \([0-9][0-9] *... *[0-9][0-9][0-9][0-9]\)/\1/p' |
			$limite
	fi

	# Fedora
	if zztool grep_var fedora "$distros"
	then
		echo
		zztool eco '** Atualizações Fedora'
		url='http://www.linuxsecurity.com/content/blogcategory/89/102/'
		echo "$url"
		$ZZWWWDUMP "$url" |
			sed -n 's/^ *\([Ff]edora *[0-9]\{1,\} *[Uu]pdate.*:.*\) *$/\1/p' |
			$limite
	fi

	# FreeBSD
	if zztool grep_var freebsd "$distros"
	then
		echo
		zztool eco '** Atualizações FreeBSD'
		url='http://www.freebsd.org/security/advisories.rdf'
		echo "$url"
		$ZZWWWDUMP "$url" |
			sed -n '
				/<title>/ {
					s/<[^>]*>//g
					s/^ *//
					/BSD-SA/p
				}' |
			$limite
	fi
	
	# Ubuntu
	if zztool grep_var ubuntu "$distros"
	then
		url='http://www.ubuntu.com/taxonomy/term/2/0/feed'
		echo
		zztool eco '** Atualizações Ubuntu'
		echo "$url"
		$ZZWWWDUMP "$url" |
			sed -n '/item/,$ s@.*<title>\(.*\)</title>@\1@p' |
			$limite
	fi
}


# ----------------------------------------------------------------------------
# http://google.com
# Pesquisa no Google diretamente pela linha de comando.
# Uso: zzgoogle [-n <número>] palavra(s)
# Ex.: zzgoogle receita de bolo de abacaxi
#      zzgoogle -n 5 ramones papel higiênico cachorro
# ----------------------------------------------------------------------------
# FIXME: zzgoogle rato roeu roupa rei roma [PPS], [PDF]
zzgoogle ()
{
	zzzz -h google $1 && return

	local padrao
	local limite=10
	local url='http://www.google.com.br/search'

	# Opções de linha de comando
	if [ "$1" = '-n' ]
	then
		limite=$2
		shift; shift
	fi

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso google; return; }

	# Prepara o texto a ser pesquisado
	padrao=$(echo "$*" | sed "$ZZSEDURL")
	[ "$padrao" ] || return 0
	
	# Pesquisa, baixa os resultados e filtra
	#
	# O Google condensa tudo em um única longa linha, então primeiro é preciso
	# inserir quebras de linha antes de cada resultado. Identificadas as linhas
	# corretas, o filtros limpa os lixos e formata o resultado.
	
	$ZZWWWHTML "$url?q=$padrao&num=$limite&ie=UTF-8&oe=UTF-8&hl=pt-BR" |
		sed 's/class=g/\
/g' |
		sed '
			/^><a href="\([^"]*\)" class=l>/!d
			s/^><a href="//
			s/" class=l>/ /
			s/<\/a>.*//
			
			# Remove tags HTML
			s/<[^>]*>//g
			
			# Restaura os caracteres especiais
			s/&gt;/>/g
			s/&lt;/</g
			s/&quot;/"/g
			s/&nbsp;/ /g
			
			s/\([^ ]*\) \(.*\)/\2\
  \1\
/'
}


# DESATIVADA: Não funciona. É preciso encontrar outro site e fazer o filtro.
# # ----------------------------------------------------------------------------
# # http://letssingit.com
# # Busca letras de músicas, procurando pelo nome da música.
# # Obs.: Se encontrar mais de uma, mostra a lista de possibilidades.
# # Uso: zzletrademusica texto
# # Ex.: zzletrademusica punkrock
# #      zzletrademusica kkk took my baby
# # ----------------------------------------------------------------------------
# zzletrademusica ()
# {
# 	zzzz -h letrademusica $1 && return
# 	
# 	local padrao=$(echo "$*" | sed "$ZZSEDURL")
# 	local url=http://letssingit.com/cgi-exe/am.cgi
#
# 	# Verificação dos parâmetros
# 	[ "$1" ] || { zztool uso letrademusica; return; }
# 	
# 	$ZZWWWDUMP "$url?a=search&p=1&s=$padrao&l=song" |
# 		sed -n 's/^ *//;/^artist /,/Page :/p;/^Artist *:/,${/IFRAME\|^\[params/d;p;}'
# }


# DESATIVADA: Não funciona (404).
# # ----------------------------------------------------------------------------
# # http://tudoparana.globo.com/gazetadopovo/cadernog/tv.html
# # Consulta a programação do dia dos canais abertos da TV.
# # Pode-se passar os canais e o horário que se quer consultar.
# #   Identificadores: B)and, C)nt, E)ducativa, G)lobo, R)ecord, S)bt, cU)ltura
# # Uso: zztv canal [horário]
# # Ex.: zztv bsu 19       # band, sbt e cultura, depois das 19:00
# #      zztv . 00         # todos os canais, depois da meia-noite
# #      zztv .            # todos os canais, o dia todo
# # ----------------------------------------------------------------------------
# zztv ()
# {
# 	zzzz -h tv $1 && return
# 	
# 	local a c h
# 	local url='http://tudoparana.globo.com/gazetadopovo/cadernog'
#
# 	# Verificação dos parâmetros
# 	[ "$1" ] || { zztool uso tv; return; }
#
# 	h=$(echo $2 | sed 's/^\(..\).*/\1/;s/[^0-9]//g')
# 	h="($h|$((h+1))|$((h+2)))"
# 	h=$(echo $h | sed 's/24/00/;s/25/01/;s/26/02/;s/\<[0-9]\>/0&/g;s@[(|)]@\\\\&@g')
# 	c=$(
# 		echo $1 |
# 		sed '
# 			s/b/2,/;s/s/4,/;s/c/6,/;
# 			s/r/7,/;s/u/9,/;s/g/12,/;s/e/59,/
# 			s/,$//;s@,@\\\\|@g'
# 	)
# 	c=$(echo $c | sed 's/^\.$/..\\?/')
# 	a=$(
# 		$ZZWWWHTML "$url/capa.phtml" |
# 		sed -n '/ana11azul.*conteudo.phtml?id=.*[tT][vV]/{ s/.*href=\"[^\"]*\/\([^\"]*\)\".*/\1/p;}'
# 	)
# 	[ "$a" ] || {
# 		echo "Programação de hoje não disponivel"
# 		return
# 	}
# 	$ZZWWWDUMP "$url/$a" |
# 		sed -e 's/^ *//;s/[Cc][Aa][Nn][Aa][Ll]/CANAL/;/^[012C]/!d;/^C[^A]/d;/^C/i \' -e . |
# 		sed "/^CANAL \($c\) *$/,/^.$/!d;/^C/,/^$h/{/^C\|^$h/!d;};s/^\.//"
# }


# ----------------------------------------------------------------------------
# http://www.acronymfinder.com
# Dicionário de siglas, sobre qualquer assunto (como DVD, IMHO, WYSIWYG).
# Obs.: Há um limite diário de consultas por IP, pode parar temporariamente.
# Uso: zzsigla sigla
# Ex.: zzsigla RTFM
# ----------------------------------------------------------------------------
zzsigla ()
{
	zzzz -h sigla $1 && return
	
	local url=http://www.acronymfinder.com/af-query.asp

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso sigla; return; }

	# Pesquisa, baixa os resultados e filtra
	$ZZWWWDUMP "$url?String=exact&Acronym=$1&Find=Find" |
		grep '\*\*\*\*' |
		sed '
			s/more info from.*//
			s/\[[a-z0-9]*\.gif\]//
			s/  *$//
			s/^ *\*\** *//'
}


# ----------------------------------------------------------------------------
# http://www.m-w.com
# Fala a pronúncia correta de uma palavra em inglês.
# Uso: zzpronuncia palavra
# Ex.: zzpronuncia apple
# ----------------------------------------------------------------------------
zzpronuncia ()
{
	zzzz -h pronuncia $1 && return

	local wav_file wav_dir wav_url
	local palavra=$1
	local cache="$ZZTMP.$palavra.wav"
	local url='http://www.m-w.com/cgi-bin/dictionary'
	local url2='http://cougar.eb.com/soundc11'

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso pronuncia; return; }

	# O 'say' é um comando do Mac OS X, aí não precisa baixar nada
	if test -x /usr/bin/say
	then
		say $*
		return
	fi

	# Busca o arquivo WAV na Internet caso não esteja no cache
	if ! test -f "$cache"
	then
		# Extrai o nome do arquivo no site do dicionário
		wav_file=$(
			$ZZWWWHTML "$url?va=$palavra" |
			sed -n "/.*audio.pl?\([a-z0-9]*\.wav\)=$palavra.*/{s//\1/p;q;}")

		# Ops, não extraiu nada
		if test -z "$wav_file"
		then
			echo "$palavra: palavra não encontrada"
			return
		fi
		
		# O nome da pasta é a primeira letra do arquivo (/a/apple001.wav)
		# Ou "number" se iniciar com um número (/number/9while01.wav)
		wav_dir=$(echo $wav_file | cut -c1)
		echo $wav_dir | grep '[0-9]' >/dev/null && wav_dir='number'
		
		# Compõe a URL do arquivo e salva-o localmente (cache)
		wav_url="$url2/$wav_dir/$wav_file"
		echo "URL: $wav_url"
		$ZZWWWHTML "$wav_url" > $cache
		echo "Gravado o arquivo '$cache'"
	fi
	
	# Fala que eu te escuto
	play $cache
}


# ----------------------------------------------------------------------------
# http://weather.noaa.gov/
# Mostra as condições do tempo (clima) em um determinado local.
# Se nenhum parâmetro for passado, são listados os países disponíveis.
# Se só o país for especificado, são listadas as suas localidades.
# As siglas também podem ser usadas, por exemplo SBPA = Porto Alegre.
# Uso: zztempo <país> <localidade>
# Ex.: zztempo 'United Kingdom' 'London City Airport'
#      zztempo brazil 'Curitiba Aeroporto'
#      zztempo brazil SBPA
# ----------------------------------------------------------------------------
zztempo ()
{
	zzzz -h tempo $1 && return

	local codigo_pais codigo_localidade localidades
	local pais="$1"
	local localidade="$2"
	local cache_paises=$ZZTMP.tempo
	local cache_localidades=$ZZTMP.tempo
	local url='http://weather.noaa.gov'

	# Se o cache de países está vazio, baixa listagem da Internet
	if ! test -s "$cache_paises"
	then
		$ZZWWWHTML "$url" | sed -n '
			/="country"/,/\/select/ {
				s/.*="\([a-zA-Z]*\)">\(.*\) <.*/\1 \2/p
			}' > "$cache_paises"
	fi

	# Se nenhum parâmetro for passado, são listados os países disponíveis		
	if ! [ "$pais" ]
	then
		sed 's/^[^ ]*  *//' "$cache_paises"
		return
	fi

	# Grava o código deste país (BR  Brazil -> BR)
	codigo_pais=$(grep -i "$1" "$cache_paises" | sed 's/  .*//' | sed 1q)

	# O país existe?
	if ! [ "$codigo_pais" ]
	then
		echo "País \"$pais\" não encontrado"
		return
	fi

	# Se o cache de locais está vazio, baixa listagem da Internet
	cache_localidades=$cache_localidades.$codigo_pais
	if ! test -s "$cache_localidades"
	then
		$ZZWWWHTML "$url/weather/${codigo_pais}_cc.html" | sed -n '
			/="cccc"/,/\/select/ {
				//d
				s/.*="\([a-zA-Z]*\)">/\1 /p
			}' > "$cache_localidades"
	fi

	# Se só o país for especificado, são listadas as localidades deste país
	if ! [ "$localidade" ]
	then
		cat "$cache_localidades"
		return
	fi

	# Pesquisa nas localidades
	localidades=$(grep -i "$localidade" "$cache_localidades")
	
	# A localidade existe?
	if ! [ "$localidades" ]
	then
		echo "Localidade \"$localidade\" não encontrada"
		return
	fi	
	
	# Se mais de uma localidade for encontrada, mostre-as
	if test $(echo "$localidades" | sed -n '$=') != 1
	then
		echo "$localidades"
		return
	fi

	# Grava o código do local (SBCO  Porto Alegre -> SBCO)
	codigo_localidade=$(echo "$localidades" | sed 's/  .*//')

	# Faz a consulta e filtra o resultado
	echo
	$ZZWWWDUMP "$url/weather/current/${codigo_localidade}.html" | sed -n '
		/Current Weather/,/24 Hour/ {
			//d
			/____*/d
			p
		}'
}


# ----------------------------------------------------------------------------
# http://www.worldtimeserver.com
# Mostra a hora certa de um determinado local.
# Se nenhum parâmetro for passado, são listados as localidades disponíveis.
# O parâmetro pode ser tanto a sigla quando o nome da localidade.
# A opção -s realiza a busca somente na sigla.
# Uso: zzhoracerta [-s] local
# Ex.: zzhoracerta rio grande do sul
#      zzhoracerta -s br
#      zzhoracerta rio
#      zzhoracerta us-ny
# ----------------------------------------------------------------------------
zzhoracerta ()
{
	zzzz -h horacerta $1 && return

	local codigo localidade localidades
	local cache=$ZZTMP.horacerta
	local url='http://www.worldtimeserver.com'

	# Opções de linha de comando
	if [ "$1" = '-s' ]
	then
		shift
		codigo="$1"
	else
		localidade="$*"	
	fi
	
	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWHTML "$url/country.html" |
			sed -n 's/.*current_time_in_\([^.]*\)\.aspx">\([^<]*\)<.*/\1 -- \2/p' > "$cache"
	fi

	# Se nenhum parâmetro for passado, são listados os países disponíveis		
	if ! [ "$localidade$codigo" ]
	then
		cat "$cache"
		return
	fi

	# Faz a pesquisa por codigo ou texto
	if [ "$codigo" ]
	then
		localidades=$(grep -i "^[^ ]*$codigo" "$cache")
	else
		localidades=$(grep -i "$localidade" "$cache")		
	fi

	# Se mais de uma localidade for encontrada, mostre-as
	if test $(echo "$localidades" | sed -n '$=') != 1
	then
		echo "$localidades"
		return
	fi

	# A localidade existe?
	if ! [ "$localidades" ]
	then
		echo "Localidade \"$localidade$codigo\" não encontrada"
		return
	fi	
	
	# Grava o código da localidade (BR-RS -- Rio Grande do Sul -> BR-RS)
	localidade=$(echo "$localidades" | sed 's/ .*//')
	
	# Faz a consulta e filtra o resultado
	$ZZWWWDUMP "$url/current_time_in_$localidade.aspx" |
		sed -n '/The current time/,/UTC/p'
}


# DESATIVADA: Agora a consulta é travada com CAPTCHA
# # ----------------------------------------------------------------------------
# # http://www.nextel.com.br
# # Envia uma mensagem para um telefone NEXTEL (via rádio).
# # Obs.: O número especificado é o número próprio do telefone (não o ID!).
# # Uso: zznextel de para mensagem
# # Ex.: zznextel aurélio 554178787878 minha mensagem mala
# # ----------------------------------------------------------------------------
# zznextel ()
# {
# 	zzzz -h nextel $1 && return
# 	
# 	local msg
# 	local url=http://page.nextel.com.br/cgi-bin/sendPage_v3.cgi
# 	local subj=zznextel
# 	local from="$1"
# 	local to="$2"
#
# 	# Verificação dos parâmetros
# 	[ "$3" ] || { zztool uso nextel; return; }
#
# 	shift; shift
# 	msg=$(echo "$*" | sed "$ZZSEDURL")
#
# 	echo "to=$to&from=$from&subject=$subj&message=$msg&count=0&Enviar=Enviar" |
# 		$ZZWWWPOST "$url" |
# 		sed '1,/^ *CENTRAL/d ; s/.*Individual/ / ; N ; q'
# }



# ----------------------------------------------------------------------------
# #### T R A D U T O R E S   e   D I C I O N Á R I O S           (Internet)
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# http://babelfish.altavista.digital.com
# Faz traduções de palavras/frases/textos entre idiomas.
# Basta especificar quais os idiomas de origem e destino e a frase.
# Obs.: Se os idiomas forem omitidos, a tradução será inglês -> português.
#
# Idiomas: pt_en pt_fr es_en es_fr it_en it_fr de_en de_fr
#          fr_en fr_de fr_el fr_it fr_pt fr_nl fr_es
#          ja_en ko_en zh_en zt_en el_en el_fr nl_en nl_fr ru_en
#          en_zh en_zt en_nl en_fr en_de en_el en_it en_ja
#          en_ko en_pt en_ru en_es
#
# Uso: zzdicbabelfish [idiomas] palavra(s)
# Ex.: zzdicbabelfish my dog is green
#      zzdicbabelfish pt_en falcão é massa
#      zzdicbabelfish en_de my hovercraft if full of eels
# ----------------------------------------------------------------------------
zzdicbabelfish ()
{
	zzzz -h dicbabelfish $1 && return
	
	local padrao
	local url='http://babelfish.yahoo.com/translate_txt'
	local extra='ei=UTF-8&eo=UTF-8&doit=done&fr=bf-home&intl=1&tt=urltext'
	local lang=en_pt

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dicbabelfish; return; }

	if [ "${1#[a-z][a-z]_[a-z][a-z]}" = '' ]
	then
		lang=$1
		shift
	elif [ "$1" = 'i' ]
	then
		lang=pt_en
		shift
	fi

	padrao=$(echo "$*" | sed "$ZZSEDURL")
	$ZZWWWHTML "$url?$extra&trtext=$padrao&lp=$lang" |
		sed -n '
			/<div id="result">/ {
		 		s/<[^>]*>//g
				s/^ *//p
			}'
}


# ----------------------------------------------------------------------------
# http://www.babylon.com
# Tradução de UMA PALAVRA em inglês para vários idiomas.
# Francês, alemão, japonês, italiano, hebreu, espanhol, holandês e português.
# Se nenhum idioma for informado, o padrão é o português.
# Uso: zzdicbabylon [idioma] palavra   #idioma:dut fre ger heb ita jap ptg spa
# Ex.: zzdicbabylon hardcore
#      zzdicbabylon jap tree
# ----------------------------------------------------------------------------
zzdicbabylon ()
{
	zzzz -h dicbabylon $1 && return

	local idioma='ptg'
	local idiomas=' dut fre ger heb ita jap ptg spa '
	local tab=$(echo -e \\t)

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dicbabylon; return; }
	
	# O primeiro argumento é um idioma?
	if [ "${idiomas% $1 *}" != "$idiomas" ]
	then
		idioma=$1
		shift
	fi
	
	$ZZWWWHTML "http://online.babylon.com/cgi-bin/trans.cgi?lang=$idioma&word=$1" |
		sed "
			/SEARCH RESULT/,/<\/td>/!d
			s/^[$tab ]*//
			s/<[^>]*>//g
			/^$/d" |
		zztool texto_em_iso
}


# ----------------------------------------------------------------------------
# http://www.portoeditora.pt/dol
# Dicionário de português (de Portugal).
# Uso: zzdicportugues palavra
# Ex.: zzdicportugues bolacha
# ----------------------------------------------------------------------------
zzdicportugues ()
{
	zzzz -h dicportugues $1 && return

	local url='http://www.priberam.pt/dlpo/definir_resultados.aspx'
	local ini='^\(Não \)\{0,1\}[Ff]oi\{0,1\}\(ram\)\{0,1\} encontrad'
	local fim='^Imprimir *$'

	# TODO Verificar alternativa brasileira (enviada por Luciano ES)
	# local URL=http://www.agal-gz.org/estraviz/modules.php
	# local parm='name=Dictionary&file=pesquisar&searchType=exact&dicSearch=maçã'

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dicportugues; return; }

	$ZZWWWDUMP "$url?pal=$1" |
		sed -n "
			s/^ *//
			/^$/d
			s/\[transparent.gif]//
			/$ini/,/$fim/ {
				/$ini/d
				/$fim/d
				/Duplo clique nas palavras/d
				/^ *$/d
				p
			}" |
		sed '
			/\(.*\.\),$/ {
		 		s//[\1]/
				H
				s/.*//
				x
			}' # \n + [categoria]
}


# ----------------------------------------------------------------------------
# http://catb.org/jargon/
# Dicionário de jargões de informática, em inglês.
# Uso: zzdicjargon palavra(s)
# Ex.: zzdicjargon vi
#      zzdicjargon all your base are belong to us
# ----------------------------------------------------------------------------
zzdicjargon ()
{
	zzzz -h dicjargon $1 && return
	
	local achei achei2 num mais
	local url='http://catb.org/jargon/html'
	local cache=$ZZTMP.jargonfile
	local padrao=$(echo "$*" | sed 's/ /-/g')

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dicjargon; return; }

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWLIST "$url/go01.html" |
			sed '
				/^ *[0-9][0-9]*\. /!d
				s@.*/html/@@
				/^[A-Z0]\//!d' > "$cache"
	fi
	
	achei=$(grep -i "$padrao" $cache)
	num=$(echo "$achei" | sed -n '$=')

	[ "$achei" ] || return

	if [ $num -gt 1 ]
	then
		mais=$achei
		achei2=$(echo "$achei" | grep -w "$padrao" | sed 1q)
		[ "$achei2" ] && achei="$achei2" && num=1
	fi

	if [ $num -eq 1 ]
	then
		$ZZWWWDUMP -width=72 "$url/$achei" |
			sed '1,/_\{9\}/d;/_\{9\}/,$d'
		[ "$mais" ] && zztool eco '\nTermos parecidos:'
	else
		zztool eco 'Achei mais de um! Escolha qual vai querer:'
	fi
	
	[ "$mais" ] && echo "$mais" | sed 's/..// ; s/\.html$//'
}


# ----------------------------------------------------------------------------
# Usa todas as funções de dicionário e tradução de uma vez.
# Uso: zzdictodos palavra
# Ex.: zzdictodos Linux
# ----------------------------------------------------------------------------
zzdictodos ()
{
	zzzz -h dictodos $1 && return

	local dic
	
	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso dictodos; return; }
	
	for dic in babelfish babylon jargon portugues
	do
		zztool eco "zzdic$dic:"
		zzdic$dic $1
	done
}


# ----------------------------------------------------------------------------
# http://aurelio.net/doc/misc/ramones.txt
# Mostra uma frase aleatória, das letras de músicas da banda punk Ramones.
# Obs.: Informe uma palavra se quiser frases sobre algum assunto especifico.
# Uso: zzramones [palavra]
# Ex.: zzramones punk
#      zzramones
# ----------------------------------------------------------------------------
zzramones ()
{
	zzzz -h ramones $1 && return

	local url='http://aurelio.net/doc/misc/ramones.txt'
	local cache=$ZZTMP.ramones
	local padrao=$1

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" > "$cache"
	fi

	# Mostra uma linha qualquer (com o padrão, se informado)
	zzlinha -t "${padrao:-.}" "$cache"
}


# ----------------------------------------------------------------------------
# http://www.ibb.org.br/vidanet
# A mensagem "Feliz Natal" em vários idiomas.
# Uso: zznatal [palavra]
# Ex.: zznatal                   # busca um idioma aleatório
#      zznatal russo             # Feliz Natal em russo
# ----------------------------------------------------------------------------
zznatal ()
{
	zzzz -h natal $1 && return

	local url='http://www.ibb.org.br/vidanet/outras/msg239.htm'
	local cache=$ZZTMP.natal
	local padrao=$1

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" | sed '
			/^      /!d
			/\[/d
			s/^  *//
			/^Outras/d
			s/^(/Chinês  &/
			s/  */: /' > "$cache"
	fi

	# Mostra uma linha qualquer (com o padrão, se informado)
	echo -n '"Feliz Natal" em '
	zzlinha -t "${padrao:-.}" "$cache"
}


# ----------------------------------------------------------------------------
## Incluindo as funções extras
[ "$ZZEXTRA" -a -f "$ZZEXTRA" ] && source "$ZZEXTRA"


# ----------------------------------------------------------------------------
## Lidando com a chamada pelo executável

# Se há parâmetros, é porque o usuário está nos chamando pela
# linha de comando, e não pelo comando source.
if [ "$1" ]
then

	case "$1" in
	
		# Mostra a tela de ajuda
		-h | --help)
	
			cat - <<-FIM

				Uso: funcoeszz <função> [<parâmetros>]
				     funcoeszz <função> --help

				Dica: Inclua as Funções ZZ no seu login shell,
				      e depois chame-as diretamente pelo nome:

				    prompt$ funcoeszz zzzz --bashrc
				    prompt$ source ~/.bashrc
				    prompt$ zz<TAB><TAB>

				Lista das funções:

				    prompt$ funcoeszz zzzz

			FIM
		;;

		# Mostra a versão das funções
		-v | --version)
			echo "Funções ZZ v$ZZVERSAO"
		;;
	
		# Chama a função informada em $1, caso ela exista
		*)
			func="$1"

			# Garante que a zzzz possa ser chamada por zz somente
			[ "$func" = 'zz' ] && func='zzzz'
			
			# O prefixo zz é opcional: zzdata e data funcionam
			func="zz${func#zz}"
			
			# A função existe?
			if type $func >/dev/null 2>&1
			then
				shift
				$func "$@"
			else
				echo "Função inexistente '$func' (tente --help)"
			fi
		;;
	esac
fi
