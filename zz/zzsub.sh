# ----------------------------------------------------------------------------
# Substitui strings dentro de strings maiores.
# Uso: zzsub 0|1 string fonte, string a ser subst., string substituta 
# Ex.: zzsub 0 olátchau olá oi			#Retorna: oitchau
#      zzsub 1 Serelepe e a			#Retorna: Saralapa
#
# Autor: Guilherme Smethurst Albuquerque <guitrompa (a) gmail com>
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------

zzsub()
{
	zzzz -h chaves "$1" && return
	
	if test "$1" -eq 0; then	#Procura e substitui a primeira ocorrência
		echo "$2" | sed s/$3/$4/
	elif test "$1" -eq 1; then	#Procura e substitui todas as ocorrências
		echo "$2" | sed s/$3/$4/g
	else 
		echo "Uso: 0|1 string fonte, string a ser subst., string substituta"
		echo "Onde 0: 1ª ocorrência; 1: Todas as ocorrências"
	fi	
}

