$ zzbissexto 2000		#→ 2000 é bissexto
$ zzbissexto 2001		#→ 2001 não é bissexto
$ zzbissexto 2002		#→ 2002 não é bissexto
$ zzbissexto 2003		#→ 2003 não é bissexto
$ zzbissexto 2004		#→ 2004 é bissexto
$ zzbissexto 2005		#→ 2005 não é bissexto
$ zzbissexto 2006		#→ 2006 não é bissexto
$ zzbissexto 2007		#→ 2007 não é bissexto
$ zzbissexto 2008		#→ 2008 é bissexto
$ zzbissexto 2009		#→ 2009 não é bissexto
$ zzbissexto 2010		#→ 2010 não é bissexto
$ zzbissexto 2011		#→ 2011 não é bissexto
$ zzbissexto 2012		#→ 2012 é bissexto

# Epoch
$ zzbissexto 1968		#→ 1968 é bissexto
$ zzbissexto 1969		#→ 1969 não é bissexto
$ zzbissexto 1970		#→ 1970 não é bissexto
$ zzbissexto 1971		#→ 1971 não é bissexto
$ zzbissexto 1972		#→ 1972 é bissexto

# Divisível por 100 e não divisível por 4 não é
$ zzbissexto 1900		#→ 1900 não é bissexto

# Erros
$ zzbissexto 01/01/1970		#→ Ano inválido '01/01/1970'
$ zzbissexto -2000 		#→ Ano inválido '-2000'
$ zzbissexto 0 			#→ Ano inválido '0'
$ zzbissexto foo 		#→ Ano inválido 'foo'

