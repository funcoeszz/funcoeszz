$ cat _dados.txt
1:um:one
2:dois:two
3:tres:three
4:quatro:four
5:cinco:five
$

# Sem argumentos
$ zzcontapalavra				#→ --regex ^Uso:

# Uso normal
$ zzcontapalavra one _dados.txt			#→ 1
$ zzcontapalavra -i one _dados.txt		#→ 1

# Conta ambas quando há duas ocorrências na mesma linha
# (diferente do grep -c)
$ zzcontapalavra -p o _dados.txt		#→ 6
$ zzcontapalavra -i -p o _dados.txt		#→ 6

# Palavra parcial, mas sem -p
$ zzcontapalavra o _dados.txt			#→ 0

# Não conta símbolos
$ zzcontapalavra : _dados.txt			#→ 0

