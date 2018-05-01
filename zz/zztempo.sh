# ----------------------------------------------------------------------------
# Mostra previsão do tempo obtida em http://wttr.in/ por meio do comando curl.
# Mostra as condições do tempo (clima) em um determinado local.
# Se nenhum parâmetro for passado, é apresentada a previsão de Brasília.
# As siglas de aeroporto também podem ser utilizadas.
#
# Opções:
#
# -l, --lang, --lingua
#    Exibe a previsão em uma das línguas disponíveis: az be bg bs ca cy cs
#    da de el eo es et fi fr hi hr hu hy is it  ja jv ka kk ko ky lt lv mk
#    ml nl nn pt pl ro ru sk sl sr sr-lat sv sw th tr uk uz vi zh zu
#
# -u, --us
#    Retorna leitura em unidades USCS - United States customary units -
#    Unidades Usuais nos Estados Unidos. Isto é: "°F" para temperatura,
#    "mph" para velocidade do vento,  "mi" para visibilidade e "in" para
#    precipitação.
#
# -v, --vento
#    Retorna vento em m/s ao invés de km/h ou mph.
#
# -m, --monocromatico
#    Nao utiliza comandos de cores no terminal
#
# -s, --simples
#    Retorna versão curta, com previsão de meio-dia e noite apenas.
#    Utiliza 63 caracteres de largura contra os 125 da resposta completa.
#
# -c, --completo
#    Retorna versão completa, com 4 horários ao longo do dia.
#    Utiliza 125 caracteres de largura.
#
# -d, --dias
# Determina o número de dias (entre 0 e 3) de previsão apresentados.
#    -d 0 = apenas tempo atual. Também pode se chamado com -0
#    -d 1 = tempo atual mais 1 dia. Também pode se chamado com -1
#    -d 2 = tempo atual mais 2 dias. Também pode se chamado com -2
#    -d 3 = tempo atual mais 3 dias. Padrão.
#
# Uso: zztempo [parametros] <localidade>
# Ex.: zztempo 'São Paulo'
#      zztempo cwb
#      zztempo -d 0 Curitiba
#      zztempo -2 -l fr -s Miami
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2004-02-19
# Versão: 2
# Licença: GPL
# Tags: internet, consulta
# ----------------------------------------------------------------------------
zztempo ()
{
	zzzz -h tempo "$1" && return

	# Embrulhamos os principais parametros disponiveis em wttr.in/:help
	# Em novos comandos "aportuguesados".

	# Inicializa os modificadores com seus valores padrão.
	local lingua="pt"     # Lingua PT
	local unidade="m"     # Unidades SI
	local vento=""        # Vento Km/h
	local dias="3"        # Máximo número de dias de previsão
	local semcores=""     # Usa terminal colorido
	local simplificado    # Previsao completa ou simplificada

	#Altera para simplificado se largura do shell não comportar
	if [ 125 -gt $(tput cols) ]
	then
		simplificado="n"   # Previsao simplificada
	else
		simplificado=""    # Previsao completa
	fi

	#leitura dos parametros de entrada
	while test "${1#-}" != "$1"
	do
		case "$1" in
		-l | --lang | --lingua)
			lingua="$2";
			shift;shift ;;
		-u | --us)
			unidade="u";
			shift ;;
		-v | --vento)
			vento="M";
			shift ;;
		-s | --simples)
			simplificado="n";
			shift ;;
		-c | --completo)
			simplificado="";
			shift ;;
		-m | --monocromatico)
			semcores="T";
			shift;;
		-d | --dias)
			if zztool testa_numero "$2"
			then
				dias="$2";
			else
				zztool erro "Número de dias inválido: $2";
				return 1;
			fi
			shift; shift;;
		-0)
			dias="0";
			shift ;;
		-1)
			dias="1";
			shift;;
		-2)
			dias="2";
			shift;;
		--) shift; break ;;
		-*) zztool erro "Opção inválida: $1"; return 1 ;;
		*) break;;
		esac
	done


	# Comando bash proposto pelo site em: "wttr.in/:bash.function"
	# Chama Previsão de Brasília se outro parâmetro não for passado

	local opcoes="${unidade}${vento}${simplificado}${dias}${semcores}"
	curl -s -H "Accept-Language: ${lingua}" ${lingua}.wttr.in/"${1:-Brazil}?${opcoes}" |
	sed '/^Follow /d; /^New feature:/d'
}
