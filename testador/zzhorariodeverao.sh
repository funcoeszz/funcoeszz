# Erros

$ zzhorariodeverao 01/01/1970	#→ Ano inválido '01/01/1970'
$ zzhorariodeverao -2000 	#→ Ano inválido '-2000'
$ zzhorariodeverao 0 		#→ Ano inválido '0'
$ zzhorariodeverao foo 		#→ Ano inválido 'foo'

# Epoch

$ zzhorariodeverao 1		#→ Antes de 2008 não havia regra fixa para o horário de verão
$ zzhorariodeverao 10 		#→ Antes de 2008 não havia regra fixa para o horário de verão
$ zzhorariodeverao 100 		#→ Antes de 2008 não havia regra fixa para o horário de verão
$ zzhorariodeverao 1969 	#→ Antes de 2008 não havia regra fixa para o horário de verão
$ zzhorariodeverao 1995		#→ Antes de 2008 não havia regra fixa para o horário de verão
$ zzhorariodeverao 2007		#→ Antes de 2008 não havia regra fixa para o horário de verão

# Uso normal

$ zzhorariodeverao 2008
19/10/2008
15/02/2009
$ zzhorariodeverao 2009
18/10/2009
21/02/2010
$ zzhorariodeverao 2010
17/10/2010
20/02/2011
$
