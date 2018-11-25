# Sem arquivo e nem argumentos de apostas
$ zzconfere quina
Não consegui ler o arquivo quina.txt
Quantidade da apostas válidas para quina incorretas
$

$ zzconfere quina --apostas _tmp1               #→ Não consegui ler o arquivo _tmp1

# Quantidade de apostas numericas insuficientes
$ zzconfere quina -c 4500 12 25 36 27 aa        #→ Quantidade da apostas válidas para quina incorretas

# Quantidade de apostas em excesso
$ zzconfere quina -c 4500 1 7 12 21 25 27 30 35 36 42 48 51 53 56 59 62 75
Não consegui ler o arquivo quina.txt
Quantidade da apostas válidas para quina incorretas
$

# Palpites nos argumentos
$ zzconfere quina -c 4500 1 7 12 21 27 35 36 42 48 51 53 62 67 75 78
2 acerto(s): 01 [07] 12 21 27 35 [36] 42 48 51 53 62 67 75 78
$ zzconfere megasena -c 2000 04 10 12 15 34 54
2 acerto(s): 04 [10] 12 15 [34] 54
$ zzconfere timemania -c 1200 15 31 32 37 48 51 62 65 68 70
3 acerto(s): [15] 31 32 37 48 51 [62] [65] 68 70
$ zzconfere lotofacil -c 1700  01 03 05 07 09 10 11 13 14 15 16 18 19 21 23
8 acerto(s): [01] [03] 05 [07] 09 10 11 [13] [14] 15 [16] 18 19 [21] [23]
$ zzconfere lotomania -c 1900 00 01 03 04 09 10 12 13 14 15 17 18 20 23 25 27 28 29 30 31 35 40 44 45 47 52 53 55 60 61 64 65 67 68 69 71 72 73 74 75 80 81 82 86 88 90 91 95 96 98
9 acerto(s): 00 01 [03] 04 09 10 12 13 14 [15] 17 18 20 23 [25] 27 28 29 30 31 35 40 [44] 45 47 [52] 53 55 60 61 64 65 67 68 69 71 72 73 74 [75] 80 81 [82] 86 [88] 90 [91] 95 96 98
$ zzconfere duplasena -c 1400 7 22 27 35 45 48
1º Sorteio - 2 acerto(s): 07 22 [27] 35 [45] 48

2º Sorteio - 1 acerto(s): [07] 22 27 35 45 48
$

# Palpites em um arquivo
$ zzconfere quina -c 3300 --apostas zzconfere.in.txt 
1 acerto(s): 06 10 [14] 27 30 36 44 52
2 acerto(s): 02 [14] 27 30 34 36 39 47 [67] 72
1 acerto(s): 09 10 [14] 28 32 41 44 53 55
0 acerto(s): 06 30 32 39 44 53
0 acerto(s): 30 33 41 52 53 71 77
$ zzconfere megasena -c 1110 --apostas zzconfere.in.txt 
2 acerto(s): [06] 10 [14] 27 30 36 44 52
1 acerto(s): 02 [14] 27 30 34 36 39 47 67 72
2 acerto(s): 09 10 [14] [28] 32 41 44 53 55
1 acerto(s): [06] 30 32 39 44 53
0 acerto(s): 30 33 41 52 53 71 77
$ zzconfere timemania -c 225 --apostas zzconfere.in.txt
3 acerto(s): [02] 14 27 [30] 34 36 39 [47] 67 72
$ zzconfere lotomania -c 1650 --apostas zzconfere.in.txt 
14 acerto(s): 00 [01] 03 [04] 05 06 08 [10] [13] 16 [17] 19 21 23 27 29 34 36 37 38 39 [40] 41 42 [43] [45] 47 48 [50] 52 54 61 [63] 65 [67] 69 [76] [78] 79 80 81 86 88 [89] 90 91 93 94 95 99
$ zzconfere lotofacil -c 900 --apostas zzconfere.in.txt
2 acerto(s): [06] [10] 14 27 30 36 44 52
1 acerto(s): [02] 14 27 30 34 36 39 47 67 72
1 acerto(s): 09 [10] 14 28 32 41 44 53 55
1 acerto(s): [06] 30 32 39 44 53
0 acerto(s): 30 33 41 52 53 71 77
$ zzconfere duplasena -c 900 --apostas zzconfere.in.txt
1º Sorteio - 0 acerto(s): 06 30 32 39 44 53
1º Sorteio - 0 acerto(s): 30 33 41 52 53 71 77
1º Sorteio - 1 acerto(s): 02 14 [27] 30 34 36 39 47 67 72
1º Sorteio - 1 acerto(s): 06 10 14 [27] 30 36 44 52
1º Sorteio - 1 acerto(s): [09] 10 14 28 32 41 44 53 55

2º Sorteio - 0 acerto(s): 02 14 27 30 34 36 39 47 67 72
2º Sorteio - 0 acerto(s): 06 30 32 39 44 53
2º Sorteio - 1 acerto(s): 06 [10] 14 27 30 36 44 52
2º Sorteio - 1 acerto(s): 30 33 [41] 52 53 71 77
2º Sorteio - 3 acerto(s): 09 [10] 14 [28] 32 [41] 44 53 55
$

# 

