$ zzve 1
Indicadores Financeiros:
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
  cetip                              Estoque e Volume CETIP
$ zzve contas | awk '$1 ~ /\// { print NF }' | uniq	#→ 11
$ zzve credito | awk '/.*\. *[0-9]+,/ { sub(/.*a\.[am]\. */,""); print NF }' | uniq	#→ 6
$ zzve tr | awk '/\/[0-9][0-9] a [0-9][0-9]\//{ print NF }' | uniq	#→ 14
$ zzve custo | awk '/ ao (ano|mês)/ { sub(/.*ao (ano|mês)\)* */,""); print NF }' | uniq	#→ 6
$ zzve aplicacoes | sed -n '/[0-9],[0-9]/{/para o mês de/d;s/ *IBrX 50 *//;s/.*[a-zA-Z)] *//g;p;}' | awk '{ print NF }' | uniq	#→ 8
$ zzve ima  | awk '/I[RM].-/ { gsub(/\*/,""); print NF }' | uniq	#→ 6
$ zzve mercado | awk '/[0-9],[0-9]/ { sub(/.*[)*] */,""); print NF }' | uniq	#→ 6
$ zzve insper | sed -n '/[0-9],/{s/.*dias//;s/^[^0-9]*//;s/[0-9.]*,[0-9]*/9,9/g;s/  */ /g;s/ $//;p;}'
9,9 9,9 9,9 9,9 9,9
9,9% 9,9% 9,9% 9,9% 9,9%
9,9% 9,9% 9,9% 9,9% 9,9%
9,9% 9,9% 9,9% 9,9% 9,9%
$ zzve futuro | sed -n '/Contratos de /{s|.*/.. ||;p;}' | awk '{ print NF }' | uniq	#→ 6
$ zzve cetip | sed -n '/[0-9],/{s/[^0-9]* \([0-9]\)/\1/;s/[0-9.]*,[0-9]* */ 9,9/g;p;}' | uniq	#→  9,9 9,9
$ zzve 2
Índices Macroeconômicos:
  atividade                          Atividade econômica
  inflação                           Variação da Inflação
  produção                           Produção e investimento
  dívida_pública ou pública          Dívida e necessidades de financiamento
  receitas_tributária ou tributária  Principais receitas tributárias
  resultado_fiscal ou fiscal         Resultado fiscal do governo central
  previdenciaria ou previdência      Contribuição previdenciária
  ir_fonte                           IR na fonte
  ir_quota                           Imposto de Renda Pessoa Física
$ zzve atividade | awk '/[0-9],[0-9]/{ for (i=NF-5;i<NF;i++) printf $i " "; print $NF }' | sed 's/[0-9-]*,[0-9]*/9,9/g;s/-/9,9/g' | uniq
9,9 9,9 9,9 9,9 9,9 9,9
$ zzve inflação | awk '/[0-9],[0-9]/{ for (i=NF-4;i<NF;i++) printf $i " "; print $NF }' | sed '$d;s/[0-9-]*,[0-9]*/9,9/g;s/-/9,9/g' | uniq
9,9 9,9 9,9 9,9 9,9
$ zzve produção | awk '/[0-9],[0-9]/{ for (i=NF-5;i<NF;i++) printf $i " "; print $NF }' | sed 's/[.0-9-]*,[0-9]*/9,9/g;s/-/9,9/g' | uniq
9,9 9,9 9,9 9,9 9,9 9,9
$ zzve pública | awk '/[0-9],[0-9]/{ for (i=NF-5;i<NF;i++) printf $i " "; print $NF }' | sed 's/[.0-9-]*,[0-9]*/9,9/g;s/-/9,9/g' | uniq
9,9 9,9 9,9 9,9 9,9 9,9
$ zzve tributária | awk '/[0-9],[0-9]/{ for (i=NF-5;i<NF;i++) printf $i " "; print $NF }' | sed 's/[.0-9-]*,[0-9]*/9,9/g;s/-/9,9/g' | uniq
9,9 9,9 9,9 9,9 9,9 9,9
$ zzve fiscal | awk '/[0-9],[0-9]/{ for (i=NF-5;i<NF;i++) printf $i " "; print $NF }' | sed 's/[.0-9-]*,[0-9]*/9,9/g;s/-/9,9/g' | uniq
9,9 9,9 9,9 9,9 9,9 9,9
$ zzve 3
Mercado Externo:
  bonus                              Bônus corporativo
  captação                           Captações de recursos no exterior
  juros_externos                     Juros externos
  cds                                Prêmio de risco do CDS
  reservas_internacionais            Reservas internacionais
$ zzve bonus | sed -n '/[0-9],[0-9]/{s|.* \([0-9][0-9]/[0-9]\)|\1|;p;}' | awk '{ print NF }' | uniq	#→ 7
$ zzve captação | sed -n '/[0-9],[0-9]/{s|.*/[0-9][0-9] *||;p;}' | awk '{ print NF }' | uniq	#→ 5
$ zzve juros_externos | awk '/[0-9],[0-9]/{ for (i=NF-5;i<NF;i++) printf $i " "; print $NF }' | sed 's/[0-9-]*,[0-9]*/9,9/g;s/-/9,9/g;s/Feriado/9,9/g' | uniq
9,9 9,9 9,9 9,9 9,9 9,9
$ zzve cds | awk '/[0-9],[0-9]/{ for (i=NF-6;i<NF;i++) printf $i " "; print $NF }' | sed 's/[0-9-]*,[0-9]*/9,9/g;s/-/9,9/g' | uniq
9,9 9,9 9,9 9,9 9,9 9,9 9,9
$ zzve reservas_internacionais | awk '/\// { print NF }' | uniq	#→ 4
$ zzve 4
Bolsa Nacional:
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
  bolsas                             Bolsas de valores internacionais
$ zzve cotações | sed '1,/^ *Nome/d;/^ *Cotações/,$d' | awk 'END {print (NR>0?1:0)}'	#→ 1
$ zzve investimento | awk '/[0-9],[0-9]/{ for (i=NF-8;i<NF;i++) printf $i " "; print $NF }' | sed 's/[+.,0-9-]*/9/g' | uniq
9 9 9 9 9 9 9 9 9
$ zzve direitos | awk '/[0-9],[0-9]/{ for (i=NF-8;i<NF;i++) printf $i " "; print $NF }' | sed 's/[+.,0-9-]*/9/g' | uniq
9 9 9 9 9 9 9 9 9
$ zzve imobiliário | awk '/[0-9],[0-9]/{ for (i=NF-8;i<NF;i++) printf $i " "; print $NF }' | sed 's/[+.,0-9-]*/9/g' | uniq
9 9 9 9 9 9 9 9 9
$ zzve vista | awk '/[0-9],[0-9]/{ for (i=NF-9;i<NF;i++) printf $i " "; print $NF }' | sed 's/[+.,0-9-]*/9/g' | uniq
9 9 9 9 9 9 9 9 9 9
$ zzve recuperação | awk '/[0-9],[0-9]/{ for (i=NF-8;i<NF;i++) printf $i " "; print $NF }' | sed 's/[+.,0-9-]*/9/g' | uniq
9 9 9 9 9 9 9 9 9
$ zzve venda_indice | awk '/[0-9],[0-9]/{ for (i=NF-8;i<NF;i++) printf $i " "; print $NF }' | sed 's/[+.,0-9-]*/9/g' | uniq
9 9 9 9 9 9 9 9 9
$ zzve 5
Commodities:
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
    metais       cobre        outros_metais      petróleo
$ zzve metais | awk '/[0-9],[0-9]/{ print $(NF-2), $(NF-1), $NF }' | sed 's/[.0-9-]*,[0-9]*/9,9/g' | uniq
9,9 9,9 9,9
$ zzve petróleo | awk '$1 ~ /\// {$1="DATA";print}' | sed 's/[.0-9-]*,[0-9]*/9,9/g' | uniq
DATA 9,9 9,9 9,9 9,9 9,9
$
