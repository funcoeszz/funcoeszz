$ now=$(  date +'%H:%M (0d %kh %Mm)' | sed 's/  / /;s/0\(.m\)/\1/') # %k bugged
$ now_hour=$(date +'%H:%M')
$ hoje=$(date +'hoje: %d/%m/%Y')
$ ontem=$(date -d "-1days" +'ontem: %d/%m/%Y')
$ amanha=$(date -d "+1days" +'amanhã: %d/%m/%Y')
$ depois_de_amanha=$(date -d "+2days" +'depois de amanhã: %d/%m/%Y')
$ anteontem=$(date -d "-2days" +'anteontem: %d/%m/%Y')
$ now_mais_10d=$(date -d "+10days" +'10 dias: %d/%m/%Y')
$ now_menos_10d=$(date -d "-10days" +'-10 dias: %d/%m/%Y')
$

$ zzhora agora						#=> --eval echo "$now"
$ zzhora -r	agora					#=> --eval echo "$now_hour ($hoje)"
$ zzhora 	600					#=> 10:00 (0d 10h 0m)
$ zzhora -r	600					#=> --eval echo "10:00 ($hoje)"
$ zzhora 	240:					#=> 240:00 (10d 0h 0m)
$ zzhora -r	240:					#=> --eval echo "00:00 ($now_mais_10d)"
$ zzhora 	-600					#=> -10:00 (0d 10h 0m)
$ zzhora -r	-600					#=> --eval echo "14:00 ($ontem)"
$ zzhora 	-240:					#=> -240:00 (10d 0h 0m)
$ zzhora -r	-240:					#=> --eval echo "00:00 ($now_menos_10d)"

# Faltando argumentos

$ zzhora 						#=> --regex ^Uso:
$ zzhora -r						#=> --regex ^Uso:
$ zzhora -r	01:00	02:00	#=> --regex ^Uso:
$ zzhora 	01:00	+	02:00	+		#=> --regex ^Uso:
$ zzhora 01:00	+	02:00	+	03:00	+	#=> --regex ^Uso:
$ zzhora 	01:00	02:00	#=> --regex ^Uso:

# Hora inválida

$ zzhora 	foo					#=> Horário inválido 'foo', deve ser HH:MM
$ zzhora 	foo:12					#=> Horário inválido 'foo:12', deve ser HH:MM
$ zzhora 	12:foo					#=> Horário inválido '12:foo', deve ser HH:MM
$ zzhora 	agora	+	foo			#=> Horário inválido 'foo', deve ser HH:MM
$ zzhora 	agora	+	foo:12			#=> Horário inválido 'foo:12', deve ser HH:MM
$ zzhora 	agora	+	12:foo			#=> Horário inválido '12:foo', deve ser HH:MM
$ zzhora 	01:00	+	02:00	+	foo	#=> Horário inválido 'foo', deve ser HH:MM

# Operação inválida

$ zzhora 	agora	/	'8:00'			#=> Operação inválida '/'. Deve ser + ou -.
$ zzhora -r	agora	/	'8:00'			#=> Operação inválida '/'. Deve ser + ou -.
$ zzhora 	01:00	+	02:00	03:00		#=> --regex ^Uso:

# Opção -r e cálculos múltiplos
$ zzhora -r	10	+	20	+	03:00	#=> --eval echo "03:30 ($hoje)"
$ zzhora -r	01:00	+	02:00	+	03:00	#=> --eval echo "06:00 ($hoje)"
$ zzhora -r	24:00	+	01:00	+	02:00	+	03:00	#=> --eval echo "06:00 ($amanha)"
$ zzhora -r	48:00	+	01:00	+	02:00	+	03:00	#=> --eval echo "06:00 ($depois_de_amanha)"
$ zzhora -r	-24:00	+	01:00	+	02:00	+	03:00	#=> --eval echo "06:00 ($ontem)"
$ zzhora -r	-48:00	+	01:00	+	02:00	+	03:00	#=> --eval echo "06:00 ($anteontem)"
$ zzhora -r	-48:00	+	01:00	+	02:00	+	03:00	#=> --eval echo "06:00 ($anteontem)"
$ zzhora -r	-47:00	-	00:59	+	00:01	#=> --eval echo "00:02 ($anteontem)"
$ zzhora -r	240:00	+	00:59	+	00:01	#=> --eval echo "01:00 ($now_mais_10d)"
$ zzhora -r	-240:00	+	00:59	+	00:01	#=> --eval echo "01:00 ($now_menos_10d)"

# Faltando pedaços (completa com valor default=0)

$ minute_value="00:01 ($hoje)"
$ hour_value="01:00 ($hoje)"
$ zzhora -r	1:00	-	0:59			#=> --eval echo "$minute_value"
$ zzhora 	1:00	-	0:59			#=> 00:01 (0d 0h 1m)
$ zzhora -r	:02	-	:01			#=> --eval echo "$minute_value"
$ zzhora 	:02	-	:01			#=> 00:01 (0d 0h 1m)
$ zzhora -r	:2	-	:1			#=> --eval echo "$minute_value"
$ zzhora 	:2	-	:1			#=> 00:01 (0d 0h 1m)
$ zzhora -r	2	-	1			#=> --eval echo "$minute_value"
$ zzhora 	2	-	1			#=> 00:01 (0d 0h 1m)
$ zzhora -r	02	-	01			#=> --eval echo "$minute_value"
$ zzhora 	02	-	01			#=> 00:01 (0d 0h 1m)
$ zzhora -r	02:	-	01:			#=> --eval echo "$hour_value"
$ zzhora 	02:	-	01:			#=> 01:00 (0d 1h 0m)
$ zzhora -r	2:	-	1:			#=> --eval echo "$hour_value"
$ zzhora 	2:	-	1:			#=> 01:00 (0d 1h 0m)

$ zzhora -r	01:00	-	00:59			#=> --eval echo "00:01 ($hoje)"
$ zzhora -r	01:00	-	01:00			#=> --eval echo "00:00 ($hoje)"
$ zzhora -r	01:00	-	01:01			#=> --eval echo "23:59 ($ontem)"
$ zzhora -r	01:00	-	02:00			#=> --eval echo "23:00 ($ontem)"

$ zzhora -r	01:00	-	24:59			#=> --eval echo "00:01 ($ontem)"
$ zzhora -r	01:00	-	25:00			#=> --eval echo "00:00 ($ontem)"
$ zzhora -r	01:00	-	25:01			#=> --eval echo "23:59 ($anteontem)"

$ zzhora -r	23:00	+	00:59			#=> --eval echo "23:59 ($hoje)"
$ zzhora -r	23:00	+	01:00			#=> --eval echo "00:00 ($amanha)"
$ zzhora -r	23:00	+	01:01			#=> --eval echo "00:01 ($amanha)"

$ zzhora -r	23:00	+	24:59			#=> --eval echo "23:59 ($amanha)"
$ zzhora -r	23:00	+	25:00			#=> --eval echo "00:00 ($depois_de_amanha)"
$ zzhora -r	23:00	+	25:01			#=> --eval echo "00:01 ($depois_de_amanha)"

$ zzhora 	01:00	-	00:59			#=> 00:01 (0d 0h 1m)
$ zzhora 	01:00	-	01:00			#=> 00:00 (0d 0h 0m)
$ zzhora 	01:00	-	01:01			#=> -00:01 (0d 0h 1m)

$ zzhora 	01:00	-	24:59			#=> -23:59 (0d 23h 59m)
$ zzhora 	01:00	-	25:00			#=> -24:00 (1d 0h 0m)
$ zzhora 	01:00	-	25:01			#=> -24:01 (1d 0h 1m)

$ zzhora 	23:00	+	00:59			#=> 23:59 (0d 23h 59m)
$ zzhora 	23:00	+	01:00			#=> 24:00 (1d 0h 0m)
$ zzhora 	23:00	+	01:01			#=> 24:01 (1d 0h 1m)

$ zzhora 	23:00	+	24:59			#=> 47:59 (1d 23h 59m)
$ zzhora 	23:00	+	25:00			#=> 48:00 (2d 0h 0m)
$ zzhora 	23:00	+	25:01			#=> 48:01 (2d 0h 1m)

# Horas negativas

$ zzhora 	01:01	+	03:03			#=> 04:04 (0d 4h 4m)
$ zzhora 	01:01	-	03:03			#=> -02:02 (0d 2h 2m)
$ zzhora 	01:01	+	-03:03			#=> -02:02 (0d 2h 2m)
$ zzhora 	01:01	-	-03:03			#=> 04:04 (0d 4h 4m)
$ zzhora 	-01:01	+	03:03			#=> 02:02 (0d 2h 2m)
$ zzhora 	-01:01	-	03:03			#=> -04:04 (0d 4h 4m)
$ zzhora 	-01:01	+	-03:03			#=> -04:04 (0d 4h 4m)
$ zzhora 	-01:01	-	-03:03			#=> 02:02 (0d 2h 2m)

# Cálculos múltiplos

$ zzhora	1:01	+	2:01	+	3:01			#=> 06:03 (0d 6h 3m)
$ zzhora	1:01	+	2:01	+	3:01	+	4:01	#=> 10:04 (0d 10h 4m)
$ zzhora	1:01	+	2:01	+	3:01	-	4:01	#=> 02:02 (0d 2h 2m)
$ zzhora	1:01	-	2:01	-	3:01	+	4:01	#=> 00:00 (0d 0h 0m)
$ zzhora	24:	+	24:	+	24:	+	24:	#=> 96:00 (4d 0h 0m)
$ zzhora	-24:	+	-24:	+	-24:	+	-24:	#=> -96:00 (4d 0h 0m)
