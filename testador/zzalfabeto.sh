# Testa todos os tipos de alfabetos

$ zzalfabeto --militar ABC
Alpha
Bravo
Charlie
$ zzalfabeto --radio ABC
Alpha
Bravo
Charlie
$ zzalfabeto --fone ABC
Alpha
Bravo
Charlie
$ zzalfabeto --otan ABC
Alpha
Bravo
Charlie
$ zzalfabeto --nato ABC
Alpha
Bravo
Charlie
$ zzalfabeto --icao ABC
Alpha
Bravo
Charlie
$ zzalfabeto --itu ABC
Alpha
Bravo
Charlie
$ zzalfabeto --imo ABC
Alpha
Bravo
Charlie
$ zzalfabeto --faa ABC
Alpha
Bravo
Charlie
$ zzalfabeto --ansi ABC
Alpha
Bravo
Charlie
$ zzalfabeto --romano ABC
A
B
C
$ zzalfabeto --latino ABC
A
B
C
$ zzalfabeto --royal-navy ABC
Apples
Butter
Charlie
$ zzalfabeto --royal ABC
Apples
Butter
Charlie
$ zzalfabeto --signalese ABC
Ack
Beer
Charlie
$ zzalfabeto --western-front ABC
Ack
Beer
Charlie
$ zzalfabeto --raf24 ABC
Ace
Beer
Charlie
$ zzalfabeto --raf42 ABC
Apple
Beer
Charlie
$ zzalfabeto --raf43 ABC
Able/Affirm
Baker
Charlie
$ zzalfabeto --raf ABC
Able/Affirm
Baker
Charlie
$ zzalfabeto --us41 ABC
Able
Baker
Charlie
$ zzalfabeto --us ABC
Able
Baker
Charlie
$ zzalfabeto --portugal ABC
Aveiro
Bragança
Coimbra
$ zzalfabeto --pt ABC
Aveiro
Bragança
Coimbra
$ zzalfabeto --name ABC
Alan
Bobby
Charlie
$ zzalfabeto --names ABC
Alan
Bobby
Charlie
$ zzalfabeto --lapd ABC
Adam
Boy
Charles
$ zzalfabeto --morse ABC
.-
-...
-.-.
$

# Se o texto não for informado, mostra o alfabeto completo

$ zzalfabeto
A
B
C
D
E
F
G
H
I
J
K
L
M
N
O
P
Q
R
S
T
U
V
W
X
Y
Z
$ zzalfabeto --militar
Alpha
Bravo
Charlie
Delta
Echo
Foxtrot
Golf
Hotel
India
Juliet
Kilo
Lima
Mike
November
Oscar
Papa
Quebec
Romeo
Sierra
Tango
Uniform
Victor
Whiskey
X-ray/Xadrez
Yankee
Zulu
$

# Pegadinhas

$ zzalfabeto 'A B C'
A
 
B
 
C
$ zzalfabeto --otan A-B.C
Alpha
-
Bravo
.
Charlie
$ zzalfabeto --otan 1234
1
2
3
4
$ zzalfabeto --otan '.[+*({\!'
.
[
+
*
(
{
\
!
$
