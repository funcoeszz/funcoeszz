# ----------------------------------------------------------------------------
# Busca vários indicadores econômicos e financeiros, da Valor Econômico.
# As opções são categorizadas conforme segue:
#
# 1. Indicadores Financeiros
# 2. Índices Macroeconômicos
# 3. Mercado Externo
# 4. Bolsas
# 5. Commodities
# moedas       Variações de moedas internacionais
#
# Para mais detalhes digite: zzve <número>
#
# Uso: zzve <opção>
# Ex.: zzve tr         # Tabela de Taxa Referencial, Poupança e TBF.
#      zzve moedas     # Cotações do Dólar, Euro e outras moedas.
#      zzve 3          # Mais detalhes de ajuda sobre "Mercado Externo".
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2013-07-28
# Versão: 4
# Licença: GPL
# Requisitos: zzuniq
# ----------------------------------------------------------------------------
# DESATIVADA: 2018-01-06 Informação acessível apenas a assinantes no site.
zzve ()
{
	zzzz -h ve "$1" && return

	test -n "$1" || { zztool -e uso ve; return 1; }

	case $1 in
	1)
		echo "Indicadores Financeiros:
	contas ou indicadores              Variação dos indicadores no período
	crédito                            Linhas de crédito
	tr, poupança ou tbf                Taxa Referencial, Poupança e TBF
	custo ou dinheiro                  Custo do dinheiro
	aplicações                         Evolução das aplicações financeiras
	ima ou anbima                      IMA - Índices de Mercado Anbima
	mercado                            Indicadores do mercado
	renda_fixa ou insper               Índice de Renda Fixa Valor/Insper
	futuro                             Mercado futuro
	estoque_cetip                      Estoque CETIP
	volume_cetip                       Volume CETIP
	cetip                              Estoque e Volume CETIP" | expand -t 2
		return
	;;
	2)
		echo "Índices Macroeconômicos:
	atividade                          Atividade econômica
	inflação                           Variação da Inflação
	produção                           Produção e investimento
	dívida_pública ou pública          Dívida e necessidades de financiamento
	receitas_tributária ou tributária  Principais receitas tributárias
	resultado_fiscal ou fiscal         Resultado fiscal do governo central
	previdenciaria ou previdência      Contribuição previdenciária
	ir_fonte                           IR na fonte
	ir_quota                           Imposto de Renda Pessoa Física" | expand -t 2
		return
	;;
	3)
		echo "Mercado Externo:
	bonus                              Bônus corporativo
	captação                           Captações de recursos no exterior
	juros_externos                     Juros externos
	cds                                Prêmio de risco do CDS
	reservas_internacionais            Reservas internacionais" | expand -t 2
		return
	;;
	4)
		echo "Bolsa Nacional:
	cotações                           Cotações intradia
	investimento                       Investimentos, debêntures e títulos
	direitos                           Direitos e recibos
	imobiliário                        Fundo imobiliário
	vista                              Mercado à vista
	compra                             Opções de compra
	venda                              Opções de venda
	venda_indice                       Opções de venda de índice
	recuperação                        Recuperação judicial

Bolsas Internacionais:
	adr_brasil ou adr                  ADR Brasil
	adr_indices                        ADR - Índices
	bolsas                             Bolsas de valores internacionais" | expand -t 2
		return
	;;
	5)
		echo "Commodities:
	agrícolas                          Indicadores
	óleo_soja                          Óleo de Soja
	farelo ou farelo_soja              Farelo de Soja
	óleo_vegetal                       Óleos Vegetais
	suco_laranja                       Suco de Laranja
	estoque_metais                     Estoques de Metais

	Outro itens em commodities:
		açucar       algodão      arroz              batata
		bezerro      boi          cacau              ovos
		café         cebola       etanol             feijão
		frango       laranja      laticínios         madeira
		madioca      milho        trigo              soja
		suínos ou porcos
		metais       cobre        outros_metais      petróleo" | expand -t 2
		return
	;;
	esac

	local url_base='http://www.valor.com.br/valor-data'
	local fim='Ver tabela completa'
	local url_atual url inicio

	# Índices Financeiros - Créditos e Taxas
	url_atual="${url_base}/indices-financeiros/creditos-e-taxas-referenciais"
	case "$1" in
		contas | indicadores)   inicio='Variação dos indicadores no período'; url=$url_atual;;
		cr[eé]dito)             inicio='Crédito *$'; url=$url_atual;;
		tr | poupan[çc]a | tbf) inicio='Taxa Referencial, Poupança e TBF'; url=$url_atual;;
	esac

	# Índides Financeiros - Mercado
	url_atual="${url_base}/indices-financeiros/indicadores-de-mercado"
	case "$1" in
		custo | dinheiro)                   inicio='Custo do dinheiro'; url=$url_atual;;
		aplica[çc][ãa]o | aplica[çc][oõ]es) inicio='Evolução das aplicações financeiras'; url=$url_atual;;
		ima | anbima)                       inicio='IMA - Índices de Mercado Anbima'; url=$url_atual;;
		mercado)                            inicio='Indicadores do mercado'; url=$url_atual;;
		renda_fixa | insper)                inicio='Índice de Renda Fixa Valor'; url=$url_atual;;
		futuro)                             inicio='Mercado futuro'; url=$url_atual;;
		estoque_cetip)                      inicio='Estoque CETIP'; url=$url_atual;;
		volume_cetip)                       inicio='Volume CETIP'; url=$url_atual;;
		cetip)
			zzve estoque_cetip
			echo
			zzve volume_cetip
			return
		;;
	esac

	# Índices Macroeconômicos - Atividade Econômica
	url_atual="${url_base}/indices-macroeconomicos/atividade-economica"
	case "$1" in
		atividade)       inicio='Atividade econômica'; url=$url_atual;;
		infla[çc][ãa]o)  inicio='Inflação'; url=$url_atual;;
		produ[çc][ãa]o)  inicio='Produção e investimento'; url=$url_atual;;
	esac

	# Índices Macroeconômicos - Finanças Públicas
	url_atual="${url_base}/indices-macroeconomicos/financas-publicas"
	case "$1" in
		d[íi]vida_p[úu]blica | p[úu]blica)      inicio='Dívida e necessidades de financiamento'; url=$url_atual;;
		receitas_tribut[áa]ria | tribut[áa]ria) inicio='Principais receitas tributárias'; url=$url_atual;;
		resultado_fiscal | fiscal)              inicio='Resultado fiscal do governo central'; url=$url_atual;;
	esac

	# Índice Macroeconômicos - Tributos
	url_atual="${url_base}/indices-macroeconomicos/tributos"
	case "$1" in
		previdenciaria | previd[êe]ncia) inicio='Contribuição previdenciária'; url=$url_atual;;
		ir_fonte)                        inicio='IR na fonte'; url=$url_atual;;
		ir_quota)                        inicio='Imposto de Renda Pessoa Física'; url=$url_atual;;
	esac

	# Commodities - Agrícolas
	url_atual="${url_base}/commodities/agricolas"
	case "$1" in
		agr[íi]colas)         inicio='Indicadores *$'; url=$url_atual;;
		a[çc]ucar)            inicio='Açúcar'; url=$url_atual;;
		algod[ãa]o)           inicio='Algodão'; url=$url_atual;;
		arroz)                inicio='Arroz'; url=$url_atual;;
		batata)               inicio='Batata'; url=$url_atual;;
		bezerro)              inicio='Bezerro'; url=$url_atual;;
		boi)                  inicio='Boi'; url=$url_atual;;
		cacau)                inicio='Cacau'; url=$url_atual;;
		caf[ée])              inicio='Café *$'; url=$url_atual;;
		cebola)               inicio='Cebola'; url=$url_atual;;
		etanol)               inicio='Etanol'; url=$url_atual;;
		farelo | farelo_soja) inicio='Farelo de Soja'; url=$url_atual;;
		[óo]leo_soja)         inicio='Óleo de Soja'; url=$url_atual;;
		feij[ãa]o)            inicio='Feijão'; url=$url_atual;;
		frango)               inicio='Frango'; url=$url_atual;;
		laranja)              inicio='Laranja'; url=$url_atual;;
		latic[íi]nios)        inicio='Laticínios'; url=$url_atual;;
		madeira)              inicio='Madeira'; url=$url_atual;;
		mandioca)             inicio='Mandioca'; url=$url_atual;;
		milho)                inicio='Milho'; url=$url_atual;;
		[óo]leo_vegetal)      inicio='Óleos Vegetais'; url=$url_atual;;
		ovos)                 inicio='Ovos'; url=$url_atual;;
		soja)                 inicio='Soja *$'; url=$url_atual;;
		suco_laranja)         inicio='Suco de Laranja'; url=$url_atual;;
		su[íi]nos | porcos)   inicio='Suínos'; url=$url_atual;;
		trigo)                inicio='Trigo'; url=$url_atual;;
	esac

	# Commodities - Minerais
	url_atual="${url_base}/commodities/minerais"
	case "$1" in
		cobre)          inicio='Cobre'; url=$url_atual;;
		estoque_metais) inicio='Estoques de Metais'; url=$url_atual;;
		metais)         inicio='Metais'; url=$url_atual;;
		outros_metais)  inicio='Outros metais'; url=$url_atual;;
		petr[óo]leo)    inicio='Petróleo'; url=$url_atual;;
	esac

	# Mercado Externo - Captações de Recursos no Exterior
	url_atual="${url_base}/internacional/mercado-externo"
	case "$1" in
		bonus)                   inicio='Bônus corporativo';url=$url_atual;;
		capta[çc][ãa]o)          inicio='Captações de recursos no exterior'; url=$url_atual;;
		juros_externos)          inicio='Juros externos'; url=$url_atual;;
		cds)                     inicio='Prêmio de risco do CDS'; url=$url_atual;;
		reservas_internacionais) inicio='Reservas internacionais'; url=$url_atual;;
	esac

	# Bolsa Nacional
	url_atual="${url_base}/bolsas/nacionais"
	case "$1" in
		cota[cç][oõ]es)    inicio='Cotações intradia';url=$url_atual;;
		investimento)      inicio='Certificados de investimentos, debêntures e outros títulos';url=$url_atual;;
		direitos)          inicio='Direitos e recibos';url=$url_atual;;
		imobili[aá]rio)    inicio='Fundo imobiliário';url=$url_atual;;
		vista)             inicio='Mercado à vista';url=$url_atual;;
		compra)            inicio='Opções de compra';url=$url_atual;;
		venda)             inicio='Opções de venda';url=$url_atual;;
		venda_indice)      inicio='Opções de venda de índice';url=$url_atual;;
		recupera[cç][aã]o) inicio='Recuperação judicial';url=$url_atual;;
	esac

	# Bolsas Internacionais
	url_atual="${url_base}/bolsas/internacionais"
	case "$1" in
		adr_brasil| adr) inicio='ADR Brasil';url=$url_atual;;
		adr_indices)     inicio='ADR - Índices';url=$url_atual;;
		bolsas)          inicio='Bolsas de valores internacionais';url=$url_atual;;
	esac

	# Moedas estrangeiras
	case "$1" in
		moedas)
			inicio='Dólar & Euro'
			fim='Valor'
			url="${url_base}/moedas"
		;;
	esac

	zztool dump "$url" |
		sed -n "/^ *${inicio}/,/^ *${fim}/p" |
		if test "$1" = "investimento"
		then
			zzuniq
		else
			cat -
		fi |
		sed '/^[:space:]*$/d;$d' |
		awk '{
			if ($0 ~ /^ *Fonte/) { print ""; print $0; print ""}
			else {print $0}
		}' |
		case "$inicio" in
			"ADR Brasil")
				sed '3,$ {
					s/^   //
					s/ financeiro / /
					s/Número de ações por /Açoes\//
					s/Data do ú/Ú/;s/ em /-/g
					s/Volume/    Volume/
					s/ \{22\}Fec/Fec/
					s/    Maior/Maior    /
					s/No dia/  Dia /g
					s/No mês/  Mês /
					s/No ano/  Ano /
					s/Em 12 meses/ 12 meses /
					s/\([0-9]\) \{14\}/\1/
					s/\([0-9]\) \{15\}/\1        /
					}'
			;;
			"Variação dos indicadores no período")
				sed 's/^ *//;s/Em //g;s/12 meses \*/12_meses(*)/;' |
				awk '
					NR == 1
					NR == 3 {
						printf "%-12s %6s %12s %12s %7s %9s %8s %8s %10s %8s %12s\n", "Mês", "TR(1)", "Poupança(2)", "Poupança(3)", "TBF(1)", "Selic(4)", "TJLP(%)", "FGTS(5)", "CUB/SP(%)", "UPC(R$)", "Salário mínimo(R$)"
					}
					NF == 11 && NR > 3 {
						printf "%-12s %6s %12s %12s %7s %9s %8s %8s %10s %8s %12s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
					}
					NF !=11 && NR > 3 {print}'
				;;
			*) cat - ;;
		esac
}
