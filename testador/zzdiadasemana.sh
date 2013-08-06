# Epoch
$ zzdiadasemana		04/01/1970	#→ domingo
$ zzdiadasemana		03/01/1970	#→ sábado
$ zzdiadasemana		02/01/1970	#→ sexta-feira
$ zzdiadasemana		01/01/1970	#→ quinta-feira
$ zzdiadasemana		31/12/1969	#→ quarta-feira
$ zzdiadasemana		30/12/1969	#→ terça-feira
$ zzdiadasemana		29/12/1969	#→ segunda-feira
$ zzdiadasemana		01/01/1900	#→ segunda-feira

# Epoch numérico
$ zzdiadasemana	-n	04/01/1970	#→ 1
$ zzdiadasemana	-n	03/01/1970	#→ 7
$ zzdiadasemana	-n	02/01/1970	#→ 6
$ zzdiadasemana	-n	01/01/1970	#→ 5
$ zzdiadasemana	-n	31/12/1969	#→ 4
$ zzdiadasemana	-n	30/12/1969	#→ 3
$ zzdiadasemana	-n	29/12/1969	#→ 2
$ zzdiadasemana	-n	01/01/1900	#→ 2

# Fev 2008, ano bissexto
$ zzdiadasemana		01/02/2008	#→ sexta-feira
$ zzdiadasemana		02/02/2008	#→ sábado
$ zzdiadasemana		03/02/2008	#→ domingo
$ zzdiadasemana		04/02/2008	#→ segunda-feira
$ zzdiadasemana		05/02/2008	#→ terça-feira
$ zzdiadasemana		06/02/2008	#→ quarta-feira
$ zzdiadasemana		07/02/2008	#→ quinta-feira
$ zzdiadasemana		08/02/2008	#→ sexta-feira
$ zzdiadasemana		09/02/2008	#→ sábado
$ zzdiadasemana		10/02/2008	#→ domingo
$ zzdiadasemana		11/02/2008	#→ segunda-feira
$ zzdiadasemana		12/02/2008	#→ terça-feira
$ zzdiadasemana		13/02/2008	#→ quarta-feira
$ zzdiadasemana		14/02/2008	#→ quinta-feira
$ zzdiadasemana		15/02/2008	#→ sexta-feira
$ zzdiadasemana		16/02/2008	#→ sábado
$ zzdiadasemana		17/02/2008	#→ domingo
$ zzdiadasemana		18/02/2008	#→ segunda-feira
$ zzdiadasemana		19/02/2008	#→ terça-feira
$ zzdiadasemana		20/02/2008	#→ quarta-feira
$ zzdiadasemana		21/02/2008	#→ quinta-feira
$ zzdiadasemana		22/02/2008	#→ sexta-feira
$ zzdiadasemana		23/02/2008	#→ sábado
$ zzdiadasemana		24/02/2008	#→ domingo
$ zzdiadasemana		25/02/2008	#→ segunda-feira
$ zzdiadasemana		26/02/2008	#→ terça-feira
$ zzdiadasemana		27/02/2008	#→ quarta-feira
$ zzdiadasemana		28/02/2008	#→ quinta-feira
$ zzdiadasemana		29/02/2008	#→ sexta-feira

# Sem os zeros (por enquanto não é suportado)
$ zzdiadasemana		1/2/2008	#→ --regex ^Data inválida 
$ zzdiadasemana		01/2/2008	#→ --regex ^Data inválida 
$ zzdiadasemana		1/02/2008	#→ --regex ^Data inválida 

# Erros
$ zzdiadasemana		1970		#→ --regex ^Data inválida 
$ zzdiadasemana		-2000 		#→ --regex ^Data inválida 
$ zzdiadasemana		0 		#→ --regex ^Data inválida 
$ zzdiadasemana		foo 		#→ --regex ^Data inválida 
$ zzdiadasemana		29.02.2008	#→ --regex ^Data inválida 

