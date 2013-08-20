
# Variáveis para comparar no resultado
$ ano=$(date '+%Y')
$ mes=$(date '+%m')
$ dia=$(date '+%d')
$ hoje=$dia/$mes/$ano
$

# Especial: parâmetros com espaços em branco, preciso do $protected
$ zzdatafmt	-f	'D M AA'		01/02/2003	#→ 1 2 03
$ zzdatafmt	-f	'DD MM AAAA'		01/02/2003	#→ 01 02 2003
$ zzdatafmt	-f	'D de MES de AAAA'	01/02/2003	#→ 1 de fevereiro de 2003

# Reconhecimento de data textual com conversão de idioma
$ zzdatafmt	--de	'19 de março de 2012'			#→ 19. März 2012


# Reconhecimento de datas textuais: abreviado, completo, com/sem "de", maiúsculas/minúsculas
$ zzdatafmt	'31/jan/2013'				#→ 31/01/2013
$ zzdatafmt	'31-jan-2013'				#→ 31/01/2013
$ zzdatafmt	'31.jan.2013'				#→ 31/01/2013
$ zzdatafmt	'31 jan 2013'				#→ 31/01/2013

$ zzdatafmt	'31/janeiro/2013'			#→ 31/01/2013
$ zzdatafmt	'31-janeiro-2013'			#→ 31/01/2013
$ zzdatafmt	'31.janeiro.2013'			#→ 31/01/2013
$ zzdatafmt	'31 janeiro 2013'			#→ 31/01/2013

$ zzdatafmt	'31 DE JAN DE 2013'			#→ 31/01/2013
$ zzdatafmt	'31 de jan de 2013'			#→ 31/01/2013
$ zzdatafmt	'31 de jan 2013'			#→ 31/01/2013
$ zzdatafmt	'31 jan de 2013'			#→ 31/01/2013

$ zzdatafmt	'31 DE JANEIRO DE 2013'			#→ 31/01/2013
$ zzdatafmt	'31 de janeiro de 2013'			#→ 31/01/2013
$ zzdatafmt	'31 de janeiro 2013'			#→ 31/01/2013
$ zzdatafmt	'31 janeiro de 2013'			#→ 31/01/2013



# Data textual passada em $1, $2, $3, etc (sem aspas)
$ zzdatafmt	31	de	jan	de	2013	#→ 31/01/2013
$ zzdatafmt	31	de	janeiro	de	2013	#→ 31/01/2013


# Erro: formato desconhecido (sem e com -f)
$ zzdatafmt				foo		#→ Erro: Data em formato desconhecido 'foo'
$ zzdatafmt				001/02/2003	#→ Erro: Data em formato desconhecido '001/02/2003'
$ zzdatafmt				01/002/2003	#→ Erro: Data em formato desconhecido '01/002/2003'
$ zzdatafmt				01/02/20003	#→ Erro: Data em formato desconhecido '01/02/20003'
$ zzdatafmt				aa/bb/cccc	#→ Erro: Data em formato desconhecido 'aa/bb/cccc'
$ zzdatafmt		-f	AAAA	foo		#→ Erro: Data em formato desconhecido 'foo'
$ zzdatafmt		-f	AA	001/02/2003	#→ Erro: Data em formato desconhecido '001/02/2003'
$ zzdatafmt		-f	AA	01/002/2003	#→ Erro: Data em formato desconhecido '01/002/2003'
$ zzdatafmt		-f	AA	01/02/20003	#→ Erro: Data em formato desconhecido '01/02/20003'
$ zzdatafmt		-f	AA	aa/bb/cccc	#→ Erro: Data em formato desconhecido 'aa/bb/cccc'

# Erro: formato conhecido, mas zztool testa_data falhou (sem e com -f)
$ zzdatafmt				99/99/9999	#→ --regex ^Data inválida 
$ zzdatafmt				99/99/999	#→ --regex ^Data inválida 
$ zzdatafmt				99/99/99	#→ --regex ^Data inválida 
$ zzdatafmt				99/99/9		#→ --regex ^Data inválida 
$ zzdatafmt				9/99/99		#→ --regex ^Data inválida 
$ zzdatafmt				99/9/99		#→ --regex ^Data inválida 
$ zzdatafmt				31/02/2003	#→ --regex ^Data inválida 
$ zzdatafmt		-f	AA	99/99/9999	#→ --regex ^Data inválida 
$ zzdatafmt		-f	AA	99/99/999	#→ --regex ^Data inválida 
$ zzdatafmt		-f	AA	99/99/99	#→ --regex ^Data inválida 
$ zzdatafmt		-f	AA	99/99/9		#→ --regex ^Data inválida 
$ zzdatafmt		-f	AA	9/99/99		#→ --regex ^Data inválida 
$ zzdatafmt		-f	AA	99/9/99		#→ --regex ^Data inválida 
$ zzdatafmt		-f	AA	31/02/2003	#→ --regex ^Data inválida 

# ok
$ zzdatafmt				05/08/1977	#→ 05/08/1977

# -f
$ zzdatafmt		-f	AAAA		01/02/2003	#→ 2003
$ zzdatafmt		-f	AAA		01/02/2003	#→ 033
$ zzdatafmt		-f	AA		01/02/2003	#→ 03
$ zzdatafmt		-f	A		01/02/2003	#→ 3
$ zzdatafmt		-f	ANO		01/02/2003	#→ dois mil e três
$ zzdatafmt		-f	ANOA		01/02/2003	#→ dois mil e três3
$ zzdatafmt		-f	AANO		01/02/2003	#→ 03NO
$ zzdatafmt		-f	MES		01/02/2003	#→ fevereiro
$ zzdatafmt		-f	MESM		01/02/2003	#→ fevereiro2
$ zzdatafmt		-f	MMES		01/02/2003	#→ 02ES
$ zzdatafmt		-f	MMMMMM		01/02/2003	#→ fevfev
$ zzdatafmt		-f	MMMMM		01/02/2003	#→ fev02
$ zzdatafmt		-f	MMMM		01/02/2003	#→ fev2
$ zzdatafmt		-f	MMM		01/02/2003	#→ fev
$ zzdatafmt		-f	MM		01/02/2003	#→ 02
$ zzdatafmt		-f	M		01/02/2003	#→ 2
$ zzdatafmt		-f	DDDD		01/02/2003	#→ 0101
$ zzdatafmt		-f	DDD		01/02/2003	#→ 011
$ zzdatafmt		-f	DD		01/02/2003	#→ 01
$ zzdatafmt		-f	D		01/02/2003	#→ 1
$ zzdatafmt		-f	DIA		01/02/2003	#→ um
$ zzdatafmt		-f	DIAD		01/02/2003	#→ um1
$ zzdatafmt		-f	DDIA		01/02/2003	#→ 01I3
$ zzdatafmt		-f	DIAA		01/02/2003	#→ um3
$ zzdatafmt		-f	D/M/AA		01/02/2003	#→ 1/2/03
$ zzdatafmt		-f	DD/MM/AAAA	01/02/2003	#→ 01/02/2003
$ zzdatafmt		-f	D.de.MES.de.AA	01/02/2003	#→ 1.de.fevereiro.de.03
$ zzdatafmt		-f	A		11/12/2013	#→ 13
$ zzdatafmt		-f	M		11/12/2013	#→ 12
$ zzdatafmt		-f	D		11/12/2013	#→ 11
$ zzdatafmt		-f	A		11/12/2000	#→ 0

# nomes dos dias em Português
$ zzdatafmt		-f	DIA	01/01/2003	#→ um
$ zzdatafmt		-f	DIA	02/01/2003	#→ dois
$ zzdatafmt		-f	DIA	03/01/2003	#→ três
$ zzdatafmt		-f	DIA	04/01/2003	#→ quatro
$ zzdatafmt		-f	DIA	05/01/2003	#→ cinco
$ zzdatafmt		-f	DIA	06/01/2003	#→ seis
$ zzdatafmt		-f	DIA	07/01/2003	#→ sete
$ zzdatafmt		-f	DIA	08/01/2003	#→ oito
$ zzdatafmt		-f	DIA	09/01/2003	#→ nove
$ zzdatafmt		-f	DIA	10/01/2003	#→ dez
$ zzdatafmt		-f	DIA	11/01/2003	#→ onze
$ zzdatafmt		-f	DIA	12/01/2003	#→ doze
$ zzdatafmt		-f	DIA	13/01/2003	#→ treze
$ zzdatafmt		-f	DIA	14/01/2003	#→ catorze
$ zzdatafmt		-f	DIA	15/01/2003	#→ quinze
$ zzdatafmt		-f	DIA	16/01/2003	#→ dezesseis
$ zzdatafmt		-f	DIA	17/01/2003	#→ dezessete
$ zzdatafmt		-f	DIA	18/01/2003	#→ dezoito
$ zzdatafmt		-f	DIA	19/01/2003	#→ dezenove
$ zzdatafmt		-f	DIA	20/01/2003	#→ vinte
$ zzdatafmt		-f	DIA	21/01/2003	#→ vinte e um
$ zzdatafmt		-f	DIA	22/01/2003	#→ vinte e dois
$ zzdatafmt		-f	DIA	23/01/2003	#→ vinte e três
$ zzdatafmt		-f	DIA	24/01/2003	#→ vinte e quatro
$ zzdatafmt		-f	DIA	25/01/2003	#→ vinte e cinco
$ zzdatafmt		-f	DIA	26/01/2003	#→ vinte e seis
$ zzdatafmt		-f	DIA	27/01/2003	#→ vinte e sete
$ zzdatafmt		-f	DIA	28/01/2003	#→ vinte e oito
$ zzdatafmt		-f	DIA	29/01/2003	#→ vinte e nove
$ zzdatafmt		-f	DIA	30/01/2003	#→ trinta
$ zzdatafmt		-f	DIA	31/01/2003	#→ trinta e um

# nomes dos anos em Português
$ zzdatafmt		-f	ANO	01/01/1000	#→ mil
$ zzdatafmt		-f	ANO	01/01/1900	#→ mil e novecentos
$ zzdatafmt		-f	ANO	01/01/1990	#→ mil novecentos e noventa
$ zzdatafmt		-f	ANO	01/01/1999	#→ mil novecentos e noventa e nove
$ zzdatafmt		-f	ANO	01/01/2000	#→ dois mil
$ zzdatafmt		-f	ANO	01/01/2001	#→ dois mil e um
$ zzdatafmt		-f	ANO	01/01/2010	#→ dois mil e dez
$ zzdatafmt		-f	ANO	01/01/2123	#→ dois mil cento e vinte e três

# nomes dos meses em Português
$ zzdatafmt		-f	MES	01/01/2000	#→ janeiro
$ zzdatafmt		-f	MES	01/02/2000	#→ fevereiro
$ zzdatafmt		-f	MES	01/03/2000	#→ março
$ zzdatafmt		-f	MES	01/04/2000	#→ abril
$ zzdatafmt		-f	MES	01/05/2000	#→ maio
$ zzdatafmt		-f	MES	01/06/2000	#→ junho
$ zzdatafmt		-f	MES	01/07/2000	#→ julho
$ zzdatafmt		-f	MES	01/08/2000	#→ agosto
$ zzdatafmt		-f	MES	01/09/2000	#→ setembro
$ zzdatafmt		-f	MES	01/10/2000	#→ outubro
$ zzdatafmt		-f	MES	01/11/2000	#→ novembro
$ zzdatafmt		-f	MES	01/12/2000	#→ dezembro
# Inglês
$ zzdatafmt	--en	-f	MES	01/01/2000	#→ January
$ zzdatafmt	--en	-f	MES	01/02/2000	#→ February
$ zzdatafmt	--en	-f	MES	01/03/2000	#→ March
$ zzdatafmt	--en	-f	MES	01/04/2000	#→ April
$ zzdatafmt	--en	-f	MES	01/05/2000	#→ May
$ zzdatafmt	--en	-f	MES	01/06/2000	#→ June
$ zzdatafmt	--en	-f	MES	01/07/2000	#→ July
$ zzdatafmt	--en	-f	MES	01/08/2000	#→ August
$ zzdatafmt	--en	-f	MES	01/09/2000	#→ September
$ zzdatafmt	--en	-f	MES	01/10/2000	#→ October
$ zzdatafmt	--en	-f	MES	01/11/2000	#→ November
$ zzdatafmt	--en	-f	MES	01/12/2000	#→ December
# Espanhol
$ zzdatafmt	--es	-f	MES	01/01/2000	#→ Enero
$ zzdatafmt	--es	-f	MES	01/02/2000	#→ Febrero
$ zzdatafmt	--es	-f	MES	01/03/2000	#→ Marzo
$ zzdatafmt	--es	-f	MES	01/04/2000	#→ Abril
$ zzdatafmt	--es	-f	MES	01/05/2000	#→ Mayo
$ zzdatafmt	--es	-f	MES	01/06/2000	#→ Junio
$ zzdatafmt	--es	-f	MES	01/07/2000	#→ Julio
$ zzdatafmt	--es	-f	MES	01/08/2000	#→ Agosto
$ zzdatafmt	--es	-f	MES	01/09/2000	#→ Septiembre
$ zzdatafmt	--es	-f	MES	01/10/2000	#→ Octubre
$ zzdatafmt	--es	-f	MES	01/11/2000	#→ Noviembre
$ zzdatafmt	--es	-f	MES	01/12/2000	#→ Diciembre
# Alemão
$ zzdatafmt	--de	-f	MES	01/01/2000	#→ Januar
$ zzdatafmt	--de	-f	MES	01/02/2000	#→ Februar
$ zzdatafmt	--de	-f	MES	01/03/2000	#→ März
$ zzdatafmt	--de	-f	MES	01/04/2000	#→ April
$ zzdatafmt	--de	-f	MES	01/05/2000	#→ Mai
$ zzdatafmt	--de	-f	MES	01/06/2000	#→ Juni
$ zzdatafmt	--de	-f	MES	01/07/2000	#→ Juli
$ zzdatafmt	--de	-f	MES	01/08/2000	#→ August
$ zzdatafmt	--de	-f	MES	01/09/2000	#→ September
$ zzdatafmt	--de	-f	MES	01/10/2000	#→ Oktober
$ zzdatafmt	--de	-f	MES	01/11/2000	#→ November
$ zzdatafmt	--de	-f	MES	01/12/2000	#→ Dezember
# Francês
$ zzdatafmt	--fr	-f	MES	01/01/2000	#→ Janvier
$ zzdatafmt	--fr	-f	MES	01/02/2000	#→ Février
$ zzdatafmt	--fr	-f	MES	01/03/2000	#→ Mars
$ zzdatafmt	--fr	-f	MES	01/04/2000	#→ Avril
$ zzdatafmt	--fr	-f	MES	01/05/2000	#→ Mai
$ zzdatafmt	--fr	-f	MES	01/06/2000	#→ Juin
$ zzdatafmt	--fr	-f	MES	01/07/2000	#→ Juillet
$ zzdatafmt	--fr	-f	MES	01/08/2000	#→ Août
$ zzdatafmt	--fr	-f	MES	01/09/2000	#→ Septembre
$ zzdatafmt	--fr	-f	MES	01/10/2000	#→ Octobre
$ zzdatafmt	--fr	-f	MES	01/11/2000	#→ Novembre
$ zzdatafmt	--fr	-f	MES	01/12/2000	#→ Décembre
# Italiano
$ zzdatafmt	--it	-f	MES	01/01/2000	#→ Gennaio
$ zzdatafmt	--it	-f	MES	01/02/2000	#→ Febbraio
$ zzdatafmt	--it	-f	MES	01/03/2000	#→ Marzo
$ zzdatafmt	--it	-f	MES	01/04/2000	#→ Aprile
$ zzdatafmt	--it	-f	MES	01/05/2000	#→ Maggio
$ zzdatafmt	--it	-f	MES	01/06/2000	#→ Giugno
$ zzdatafmt	--it	-f	MES	01/07/2000	#→ Luglio
$ zzdatafmt	--it	-f	MES	01/08/2000	#→ Agosto
$ zzdatafmt	--it	-f	MES	01/09/2000	#→ Settembre
$ zzdatafmt	--it	-f	MES	01/10/2000	#→ Ottobre
$ zzdatafmt	--it	-f	MES	01/11/2000	#→ Novembre
$ zzdatafmt	--it	-f	MES	01/12/2000	#→ Dicembre

# nomes dos meses, abreviado, em Português
$ zzdatafmt		-f	MMM	01/01/2000	#→ jan
$ zzdatafmt		-f	MMM	01/02/2000	#→ fev
$ zzdatafmt		-f	MMM	01/03/2000	#→ mar
$ zzdatafmt		-f	MMM	01/04/2000	#→ abr
$ zzdatafmt		-f	MMM	01/05/2000	#→ mai
$ zzdatafmt		-f	MMM	01/06/2000	#→ jun
$ zzdatafmt		-f	MMM	01/07/2000	#→ jul
$ zzdatafmt		-f	MMM	01/08/2000	#→ ago
$ zzdatafmt		-f	MMM	01/09/2000	#→ set
$ zzdatafmt		-f	MMM	01/10/2000	#→ out
$ zzdatafmt		-f	MMM	01/11/2000	#→ nov
$ zzdatafmt		-f	MMM	01/12/2000	#→ dez
# Inglês
$ zzdatafmt	--en	-f	MMM	01/01/2000	#→ Jan
$ zzdatafmt	--en	-f	MMM	01/02/2000	#→ Feb
$ zzdatafmt	--en	-f	MMM	01/03/2000	#→ Mar
$ zzdatafmt	--en	-f	MMM	01/04/2000	#→ Apr
$ zzdatafmt	--en	-f	MMM	01/05/2000	#→ May
$ zzdatafmt	--en	-f	MMM	01/06/2000	#→ Jun
$ zzdatafmt	--en	-f	MMM	01/07/2000	#→ Jul
$ zzdatafmt	--en	-f	MMM	01/08/2000	#→ Aug
$ zzdatafmt	--en	-f	MMM	01/09/2000	#→ Sep
$ zzdatafmt	--en	-f	MMM	01/10/2000	#→ Oct
$ zzdatafmt	--en	-f	MMM	01/11/2000	#→ Nov
$ zzdatafmt	--en	-f	MMM	01/12/2000	#→ Dec
# Espanhol
$ zzdatafmt	--es	-f	MMM	01/01/2000	#→ Ene
$ zzdatafmt	--es	-f	MMM	01/02/2000	#→ Feb
$ zzdatafmt	--es	-f	MMM	01/03/2000	#→ Mar
$ zzdatafmt	--es	-f	MMM	01/04/2000	#→ Abr
$ zzdatafmt	--es	-f	MMM	01/05/2000	#→ May
$ zzdatafmt	--es	-f	MMM	01/06/2000	#→ Jun
$ zzdatafmt	--es	-f	MMM	01/07/2000	#→ Jul
$ zzdatafmt	--es	-f	MMM	01/08/2000	#→ Ago
$ zzdatafmt	--es	-f	MMM	01/09/2000	#→ Sep
$ zzdatafmt	--es	-f	MMM	01/10/2000	#→ Oct
$ zzdatafmt	--es	-f	MMM	01/11/2000	#→ Nov
$ zzdatafmt	--es	-f	MMM	01/12/2000	#→ Dic
# Alemão
$ zzdatafmt	--de	-f	MMM	01/01/2000	#→ Jan
$ zzdatafmt	--de	-f	MMM	01/02/2000	#→ Feb
$ zzdatafmt	--de	-f	MMM	01/03/2000	#→ Mär
$ zzdatafmt	--de	-f	MMM	01/04/2000	#→ Apr
$ zzdatafmt	--de	-f	MMM	01/05/2000	#→ Mai
$ zzdatafmt	--de	-f	MMM	01/06/2000	#→ Jun
$ zzdatafmt	--de	-f	MMM	01/07/2000	#→ Jul
$ zzdatafmt	--de	-f	MMM	01/08/2000	#→ Aug
$ zzdatafmt	--de	-f	MMM	01/09/2000	#→ Sep
$ zzdatafmt	--de	-f	MMM	01/10/2000	#→ Okt
$ zzdatafmt	--de	-f	MMM	01/11/2000	#→ Nov
$ zzdatafmt	--de	-f	MMM	01/12/2000	#→ Dez
# Francês
$ zzdatafmt	--fr	-f	MMM	01/01/2000	#→ Jan
$ zzdatafmt	--fr	-f	MMM	01/02/2000	#→ Fév
$ zzdatafmt	--fr	-f	MMM	01/03/2000	#→ Mar
$ zzdatafmt	--fr	-f	MMM	01/04/2000	#→ Avr
$ zzdatafmt	--fr	-f	MMM	01/05/2000	#→ Mai
$ zzdatafmt	--fr	-f	MMM	01/06/2000	#→ Jui
$ zzdatafmt	--fr	-f	MMM	01/07/2000	#→ Jui
$ zzdatafmt	--fr	-f	MMM	01/08/2000	#→ Aoû
$ zzdatafmt	--fr	-f	MMM	01/09/2000	#→ Sep
$ zzdatafmt	--fr	-f	MMM	01/10/2000	#→ Oct
$ zzdatafmt	--fr	-f	MMM	01/11/2000	#→ Nov
$ zzdatafmt	--fr	-f	MMM	01/12/2000	#→ Déc
# Italiano
$ zzdatafmt	--it	-f	MMM	01/01/2000	#→ Gen
$ zzdatafmt	--it	-f	MMM	01/02/2000	#→ Feb
$ zzdatafmt	--it	-f	MMM	01/03/2000	#→ Mar
$ zzdatafmt	--it	-f	MMM	01/04/2000	#→ Apr
$ zzdatafmt	--it	-f	MMM	01/05/2000	#→ Mag
$ zzdatafmt	--it	-f	MMM	01/06/2000	#→ Giu
$ zzdatafmt	--it	-f	MMM	01/07/2000	#→ Lug
$ zzdatafmt	--it	-f	MMM	01/08/2000	#→ Ago
$ zzdatafmt	--it	-f	MMM	01/09/2000	#→ Set
$ zzdatafmt	--it	-f	MMM	01/10/2000	#→ Ott
$ zzdatafmt	--it	-f	MMM	01/11/2000	#→ Nov
$ zzdatafmt	--it	-f	MMM	01/12/2000	#→ Dic

# formato padrão de cada idioma
$ zzdatafmt	--pt	31/03/2000			#→ 31 de março de 2000
$ zzdatafmt	--ptt	31/03/2000			#→ trinta e um de março de dois mil
$ zzdatafmt	--en	31/03/2000			#→ March, 31 2000
$ zzdatafmt	--it	31/03/2000			#→ 31 da Marzo 2000
$ zzdatafmt	--es	31/03/2000			#→ 31 de Marzo de 2000
$ zzdatafmt	--de	31/03/2000			#→ 31. März 2000
$ zzdatafmt	--fr	31/03/2000			#→ Le 31 Mars 2000

# ano 4 dígitos, sem alterações
$ zzdatafmt				01/02/0003	#→ 01/02/0003
$ zzdatafmt				01/02/0033	#→ 01/02/0033
$ zzdatafmt				01/02/0333	#→ 01/02/0333
$ zzdatafmt				01/02/3333	#→ 01/02/3333

# ano 3 dígitos, completa com um zero
$ zzdatafmt				01/02/003	#→ 01/02/0003
$ zzdatafmt				01/02/033	#→ 01/02/0033
$ zzdatafmt				01/02/333	#→ 01/02/0333

# ano 2 dígitos, pode ser 19.. ou 20..
$ zzdatafmt				01/02/40	#→ 01/02/1940
$ zzdatafmt				01/02/41	#→ 01/02/1941
$ zzdatafmt				01/02/50	#→ 01/02/1950
$ zzdatafmt				01/02/60	#→ 01/02/1960
$ zzdatafmt				01/02/70	#→ 01/02/1970
$ zzdatafmt				01/02/80	#→ 01/02/1980
$ zzdatafmt				01/02/90	#→ 01/02/1990
$ zzdatafmt				01/02/99	#→ 01/02/1999
$ zzdatafmt				01/02/00	#→ 01/02/2000
$ zzdatafmt				01/02/01	#→ 01/02/2001
$ zzdatafmt				01/02/10	#→ 01/02/2010
$ zzdatafmt				01/02/20	#→ 01/02/2020
$ zzdatafmt				01/02/30	#→ 01/02/2030
$ zzdatafmt				01/02/38	#→ 01/02/2038
$ zzdatafmt				01/02/39	#→ 01/02/2039

# ano 1 dígito, é sempre 200.
$ zzdatafmt				01/02/0		#→ 01/02/2000
$ zzdatafmt				01/02/1		#→ 01/02/2001
$ zzdatafmt				01/02/2		#→ 01/02/2002
$ zzdatafmt				01/02/3		#→ 01/02/2003
$ zzdatafmt				01/02/4		#→ 01/02/2004
$ zzdatafmt				01/02/5		#→ 01/02/2005
$ zzdatafmt				01/02/6		#→ 01/02/2006
$ zzdatafmt				01/02/7		#→ 01/02/2007
$ zzdatafmt				01/02/8		#→ 01/02/2008
$ zzdatafmt				01/02/9		#→ 01/02/2009

# mês 1 dígito
$ zzdatafmt				01/1/2003	#→ 01/01/2003
$ zzdatafmt				01/2/2003	#→ 01/02/2003
$ zzdatafmt				01/3/2003	#→ 01/03/2003
$ zzdatafmt				01/4/2003	#→ 01/04/2003
$ zzdatafmt				01/5/2003	#→ 01/05/2003
$ zzdatafmt				01/6/2003	#→ 01/06/2003
$ zzdatafmt				01/7/2003	#→ 01/07/2003
$ zzdatafmt				01/8/2003	#→ 01/08/2003
$ zzdatafmt				01/9/2003	#→ 01/09/2003

# dia 1 dígito
$ zzdatafmt				1/02/2003	#→ 01/02/2003
$ zzdatafmt				2/02/2003	#→ 02/02/2003
$ zzdatafmt				3/02/2003	#→ 03/02/2003
$ zzdatafmt				4/02/2003	#→ 04/02/2003
$ zzdatafmt				5/02/2003	#→ 05/02/2003
$ zzdatafmt				6/02/2003	#→ 06/02/2003
$ zzdatafmt				7/02/2003	#→ 07/02/2003
$ zzdatafmt				8/02/2003	#→ 08/02/2003
$ zzdatafmt				9/02/2003	#→ 09/02/2003

# faltando zeros, misturado
$ zzdatafmt				1/2/2003	#→ 01/02/2003
$ zzdatafmt				1/2/003		#→ 01/02/0003
$ zzdatafmt				1/2/03		#→ 01/02/2003
$ zzdatafmt				1/2/3		#→ 01/02/2003
$ zzdatafmt				1/2/73		#→ 01/02/1973
$ zzdatafmt				1/02/003	#→ 01/02/0003
$ zzdatafmt				1/02/03		#→ 01/02/2003
$ zzdatafmt				1/02/3		#→ 01/02/2003
$ zzdatafmt				1/02/73		#→ 01/02/1973
$ zzdatafmt				01/2/003	#→ 01/02/0003
$ zzdatafmt				01/2/03		#→ 01/02/2003
$ zzdatafmt				01/2/3		#→ 01/02/2003
$ zzdatafmt				01/2/73		#→ 01/02/1973

# Apelidos
$ zzdatafmt				hoje		#→ --eval echo "$hoje"

# formato iso
$ zzdatafmt				1977-08-05	#→ 05/08/1977

# delimitador diferente
$ zzdatafmt				05-08-1977	#→ 05/08/1977
$ zzdatafmt				05-08-77	#→ 05/08/1977
$ zzdatafmt				05-08-7		#→ 05/08/2007
$ zzdatafmt				5-08-1977	#→ 05/08/1977
$ zzdatafmt				5-08-77		#→ 05/08/1977
$ zzdatafmt				5-08-7		#→ 05/08/2007
$ zzdatafmt				05-8-1977	#→ 05/08/1977
$ zzdatafmt				05-8-77		#→ 05/08/1977
$ zzdatafmt				05-8-7		#→ 05/08/2007
$ zzdatafmt				5-8-1977	#→ 05/08/1977
$ zzdatafmt				5-8-77		#→ 05/08/1977
$ zzdatafmt				5-8-7		#→ 05/08/2007
#
$ zzdatafmt				05.08.1977	#→ 05/08/1977
$ zzdatafmt				05.08.77	#→ 05/08/1977
$ zzdatafmt				05.08.7		#→ 05/08/2007
$ zzdatafmt				5.08.1977	#→ 05/08/1977
$ zzdatafmt				5.08.77		#→ 05/08/1977
$ zzdatafmt				5.08.7		#→ 05/08/2007
$ zzdatafmt				05.8.1977	#→ 05/08/1977
$ zzdatafmt				05.8.77		#→ 05/08/1977
$ zzdatafmt				05.8.7		#→ 05/08/2007
$ zzdatafmt				5.8.1977	#→ 05/08/1977
$ zzdatafmt				5.8.77		#→ 05/08/1977
$ zzdatafmt				5.8.7		#→ 05/08/2007

# sem delimitador
$ zzdatafmt				05081977	#→ 05/08/1977
$ zzdatafmt				050877		#→ 05/08/1977
$ zzdatafmt				050817		#→ 05/08/2017

# dia e mês
$ zzdatafmt				05/06		#→ --eval echo "05/06/$ano"
$ zzdatafmt				05/6		#→ --eval echo "05/06/$ano"
$ zzdatafmt				5/06		#→ --eval echo "05/06/$ano"
$ zzdatafmt				5/6		#→ --eval echo "05/06/$ano"

### Daqui pra baixo ainda não foi implementado
### (e ainda não sei se deve ser)

# # só dia
# $ zzdatafmt				1		#→ --eval echo "01/$mes/$ano"
# $ zzdatafmt				2		#→ --eval echo "02/$mes/$ano"
# $ zzdatafmt				3		#→ --eval echo "03/$mes/$ano"
# $ zzdatafmt				4		#→ --eval echo "04/$mes/$ano"
# $ zzdatafmt				5		#→ --eval echo "05/$mes/$ano"
# $ zzdatafmt				6		#→ --eval echo "06/$mes/$ano"
# $ zzdatafmt				7		#→ --eval echo "07/$mes/$ano"
# $ zzdatafmt				8		#→ --eval echo "08/$mes/$ano"
# $ zzdatafmt				9		#→ --eval echo "09/$mes/$ano"
# $ zzdatafmt				01		#→ --eval echo "01/$mes/$ano"
# $ zzdatafmt				02		#→ --eval echo "02/$mes/$ano"
# $ zzdatafmt				03		#→ --eval echo "03/$mes/$ano"
# $ zzdatafmt				04		#→ --eval echo "04/$mes/$ano"
# $ zzdatafmt				05		#→ --eval echo "05/$mes/$ano"
# $ zzdatafmt				06		#→ --eval echo "06/$mes/$ano"
# $ zzdatafmt				07		#→ --eval echo "07/$mes/$ano"
# $ zzdatafmt				08		#→ --eval echo "08/$mes/$ano"
# $ zzdatafmt				09		#→ --eval echo "09/$mes/$ano"
# $ zzdatafmt				10		#→ --eval echo "10/$mes/$ano"
# $ zzdatafmt				11		#→ --eval echo "11/$mes/$ano"
# $ zzdatafmt				12		#→ --eval echo "12/$mes/$ano"
# $ zzdatafmt				13		#→ --eval echo "13/$mes/$ano"
# $ zzdatafmt				14		#→ --eval echo "14/$mes/$ano"
# $ zzdatafmt				15		#→ --eval echo "15/$mes/$ano"
# $ zzdatafmt				16		#→ --eval echo "16/$mes/$ano"
# $ zzdatafmt				17		#→ --eval echo "17/$mes/$ano"
# $ zzdatafmt				18		#→ --eval echo "18/$mes/$ano"
# $ zzdatafmt				19		#→ --eval echo "19/$mes/$ano"
# $ zzdatafmt				20		#→ --eval echo "20/$mes/$ano"
# $ zzdatafmt				21		#→ --eval echo "21/$mes/$ano"
# $ zzdatafmt				22		#→ --eval echo "22/$mes/$ano"
# $ zzdatafmt				23		#→ --eval echo "23/$mes/$ano"
# $ zzdatafmt				24		#→ --eval echo "24/$mes/$ano"
# $ zzdatafmt				25		#→ --eval echo "25/$mes/$ano"
# $ zzdatafmt				26		#→ --eval echo "26/$mes/$ano"
# $ zzdatafmt				27		#→ --eval echo "27/$mes/$ano"
# $ zzdatafmt				28		#→ --eval echo "28/$mes/$ano"
# $ zzdatafmt				29		#→ --eval echo "29/$mes/$ano"
# $ zzdatafmt				30		#→ --eval echo "30/$mes/$ano"
# $ zzdatafmt				31		#→ --eval echo "31/$mes/$ano"
#
# # só mês e ano
# $ zzdatafmt				08/1977		#→ --eval echo "$dia/08/1977"
# $ zzdatafmt				8/1977		#→ --eval echo "$dia/08/1977"
#
# # só o ano
# $ zzdatafmt				1977		#→ --eval echo "$dia/$mes/1977"

