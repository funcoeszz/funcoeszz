# ----------------------------------------------------------------------------
# Jogo do bicho.
# Com um número como argumento indica o bicho e o grupo.
# Se o for um número entre 1 e 25 seguido de "g", lista os números do grupo.
# Sem argumento ou com apenas "g" lista todos os grupos de bichos.
#
# Uso: zzbicho [numero] [g]
# Ex.: zzbicho 123456
#      zzbicho 14 g
#      zzbicho g
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2012-08-27
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zzbicho ()
{
	zzzz -h bicho "$1" && return

	# Verificação dos parâmetros: se há $1, ele deve ser 'g' ou um número
	if [ $# -gt 0 ] && [ "$1" != 'g' ] && ! zztool testa_numero "$1"
	then
		zztool uso bicho
		return 1
	fi

	echo "$*" |
	awk '{
		grupo[01]="Avestruz"
		grupo[02]="Águia"
		grupo[03]="Burro"
		grupo[04]="Borboleta"
		grupo[05]="Cachorro"
		grupo[06]="Cabra"
		grupo[07]="Carneiro"
		grupo[08]="Camelo"
		grupo[09]="Cobra"
		grupo[10]="Coelho"
		grupo[11]="Cavalo"
		grupo[12]="Elefante"
		grupo[13]="Galo"
		grupo[14]="Gato"
		grupo[15]="Jacaré"
		grupo[16]="Leão"
		grupo[17]="Macaco"
		grupo[18]="Porco"
		grupo[19]="Pavão"
		grupo[20]="Peru"
		grupo[21]="Touro"
		grupo[22]="Tigre"
		grupo[23]="Urso"
		grupo[24]="Veado"
		grupo[25]="Vaca"

		if ($2=="g" && $1 >= 1 && $1 <= 25) {
			numero = $1 * 4
			for (numero = ($1 * 4) - 3;numero <= ($1 *4); numero++) {
				printf "%.2d ", substr(numero,length(numero)-1,2)
			}
			print ""
		}
		else if ($1 == "g" || $1 == "") {
			for (num=1;num<=25;num++) {
				printf "%.2d %s\n",num, grupo[num]
			}
		}
		else {
			numero = substr($1,length($1)-1,2)=="00"?25:int((substr($1,length($1)-1,2) + 3) / 4)
			print grupo[numero], "(" numero ")"
		}
	}' |
	sed 's/ $//'
}
