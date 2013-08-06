# Preparativos

$ file="foo.JPG"
$ touch "$file"
$

# Erros

$ zztrocaextensao					#→ --regex ^Uso:
$ zztrocaextensao	-n				#→ --regex ^Uso:
$ zztrocaextensao	-n	JPG			#→ --regex ^Uso:
$ zztrocaextensao	-n	JPG	BMP		#→ --regex ^Uso:
$ zztrocaextensao	-n	JPG	BMP	_fake_	#→ Não consegui ler o arquivo _fake_

# Ignora quando é a mesmo extensão

$ zztrocaextensao	-n 	JPG	JPG	"$file"
$

# Operação normal

$ zztrocaextensao	-n 	JPG	BMP	"$file"	#→ [-n] foo.JPG -> foo.BMP
$ zztrocaextensao	-n 	.JPG	.BMP	"$file"	#→ [-n] foo.JPG -> foo.BMP

# Faxina

$ rm -f "$file"
$
