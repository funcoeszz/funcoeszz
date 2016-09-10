# ----------------------------------------------------------------------------
# http://cinemark.com.br/programacao
# Exibe a programação dos cinemas Cinemark de sua cidade.
# Sem argumento lista todas as cidades e todas as salas mostrando os códigos.
# Com o cógigo da cidade lista as salas dessa cidade.
# Com o código das salas mostra os filmes do dia.
# Um segundo argumento caso pode ser a data, para listar os filmes desse dia.
# As datas devem ser futuras e conforme a padrão zzdata
#
# Uso: zzcinemark [codigo_cidade | codigo_cinema] [data]
# Ex.: zzcinemark 1            # Lista os cinemas de São Paulo
#      zzcinemark 662 sab      # Filmes de Raposo Shopping no sábado
#
# Autor: Thiago Moura Witt <thiago.witt (a) gmail.com> <@thiagowitt>
# Desde: 2011-07-05
# Versão: 2
# Licença: GPL
# Requisitos: zzdatafmt zzxml zzunescape zztrim
# Tags: cinema
# ----------------------------------------------------------------------------
zzcinemark ()
{
	zzzz -h cinemark "$1" && return

	local codigo dia linha
	local url="http://cinemark.com.br/programacao"
	local cidades='1	São Paulo
2	Santo André
3	São Bernardo do Campo
4	Barueri
5	São José dos Campos
6	Ribeirão Preto
8	Santos
9	Rio de Janeiro
10	Aracaju
11	Porto Alegre
12	Canoas
13	Campo Grande
14	Brasília
15	Manaus
16	Campinas
17	Taguatinga
18	Curitiba
19	Jacareí
20	Niterói
21	Belo Horizonte
22	Natal
23	Goiânia
24	Florianópolis
25	Vitória
26	Salvador
27	Guarulhos
28	São José dos Pinhais
29	Osasco
30	Cotia
31	Palmas
32	São Caetano do Sul
33	Uberlândia
34	Recife
35	Cuiabá
36	Taubaté
37	Londrina
38	Betim
39	Vila Velha
40	Mogi das Cruzes
41	Lages
43	Varginha
44	Camaçari
45	Boa Vista
46	Juazeiro da Bahia
47	Foz do Iguaçu'

	local cinemas='
1 = 716, Aricanduva, 690, Boulevard Tatuape, 699, Center Norte, 705, Central Plaza, 682, Cidade Jardim, 2119, Cidade Sao Paulo, 715, Eldorado, 714, Interlagos, 2114, Lar Center, 688, Market Place, 684, Metro Santa Cruz, 711, Metro Tatuape, 758, Metro Tucuruvi, 2103, Mooca Plaza Shopping, 721, Patio Higienopolis, 723, Patio Paulista, 662, Raposo Shopping, 710, SP Market, 687, Shopping D, 707, Shopping Iguatemi SP, 2110, Tiete Plaza Shopping, 727, Villa Lobos
2 = 2115, Atrium Shopping, 713, Grand Plaza Shopping
3 = 724, Extra Anchieta, 2109, Golden Square
4 = 717, Shopping Tambore
5 = 696, Center Vale, 712, Colinas Shopping
6 = 726, Novo Shopping
8 = 709, Praiamar Shopping
9 = 728, Botafogo, 692, Carioca Shopping, 2118, Center Shopping Rio - Jacarepagua, 719, Downtown, 2112, Metropolitano Barra, 2106, Village Mall
10 = 706, Shopping Jardins, 755, Shopping Riomar
11 = 704, Barra Shopping Sul, 695, Bourbon Ipiranga
12 = 693, Canoas Shopping
13 = 694, Shopping Campo Grande
14 = 769, Iguatemi Brasilia, 720, Pier 21
15 = 708, Studio 5 Shopping
16 = 725, Campinas Iguatemi
17 = 718, Taguatinga Shopping
18 = 700, ParkShoppingBarigui, 698, Shopping Mueller
19 = 689, Jacarei Shopping
20 = 691, Plaza Shopping Niteroi
21 = 768, BH Shopping, 767, Diamond Mall, 697, Patio Savassi
22 = 681, Midway Mall Natal
23 = 893, Flamboyant, 2113, Passeio das Águas
24 = 703, Floripa Shopping
25 = 702, Shopping Vitoria
26 = 785, Salvador Shopping
27 = 759, Cinemark Internacional Shopping Guarulhos
28 = 894, Shopping Sao Jose
29 = 757, Cinemark Osasco
30 = 663, Shopping Granja Vianna
31 = 661, Capim Dourado
32 = 2100, Park Shopping Sao Caetano
33 = 2101, Uberlândia Shopping
34 = 2107, Riomar Recife
35 = 2108, Goiabeiras Shopping
36 = 2105, Via Vale Taubate
37 = 2104, Boulevard Londrina
38 = 2111, Partage Shopping Betim
39 = 2117, Shopping Vila Velha
40 = 2120, Mogi das Cruzes
41 = 2121, Lages Garden Shopping
43 = 2122, Via Cafe
44 = 2130, Camaçari
45 = 2123, Roraima
46 = 2127, Jua Garden Shopping
47 = 2129, Foz do Iguaçu'

	if test $# = 0
	then
		# mostra opções cidades e cinemas
		echo "$cidades" |
		while read linha
		do
			codigo="${linha%	*}"
			zztool eco "$codigo ${linha#*	}"
			echo "$cinemas" |
			sed -n "/^${codigo} / { s/.* = //; p; }" |
			awk -F ', ' '{ for (i=1; i<=NF; i++) { printf " %s", $i; if (i%2==0) print "" }}'
			echo
		done
	elif zztool testa_numero $1 && echo "$cidades" | grep --color=NEVER "^$1	" 2>/dev/null >/dev/null
	then
		zztool eco $(echo "$cidades" | sed -n "/^$1	/s/	/ /p")
		echo "$cinemas" |
		sed -n "/^$1 / { s/.* = //; p; }" |
		awk -F ', ' '{ for (i=1; i<=NF; i++) { printf " %s", $i; if (i%2==0) print "" }}'
		return 0
	elif zztool testa_numero $1 && echo "$cinemas" | grep --color=NEVER "$1, " 2>/dev/null >/dev/null
	then
		zztool eco $(echo "$cinemas" | sed -n "/$1, / { s/.*$1, //; s/,.*//; p; }")
		if test -n "$2"
		then
			case "$2" in
					# apelidos
					hoje | amanh[ãa])
						dia=$(zzdatafmt -f "DD-MM-AAAA" $2)
					;;
					# semana (curto)
					dom | seg | ter | qua | qui | sex | sab)
						dia=$(zzdatafmt -f "DD-MM-AAAA" $2)
					;;
					# semana (longo)
					domingo | segunda | ter[cç]a | quarta | quinta | sexta | s[aá]bado)
						dia=$(zzdatafmt -f "DD-MM-AAAA" $2)
					;;
			esac

			if test -z "$dia"
			then
				if zztool testa_data $2
				then
					dia=$(zzdatafmt -f "DD-MM-AAAA" $2)
				else
					dia=$(zzdatafmt -f "DD-MM-AAAA" hoje)
				fi
			fi
		else
			dia=$(zzdatafmt -f "DD-MM-AAAA" hoje)
		fi

		zztool source "${url}/cinema/$1" |
		sed -n '/class="date-tab-content"/,/_Cidades/p' |
		sed -n '/class="date-tab-content"/p;/<h4>/p;/[0-9]h[0-9]/p;/images\/\(exibicao\|censura\)\//p' |
		awk '{
			if ($0 ~ /images/) {reserva=$0 }
			else if ($0 ~ /date-tab-content/) {print; print ""}
			else if ($0 ~ /[0-9]h[0-9]/){ print reserva; print; print "" }
			else print
			}' |
		sed '/date-/{ s/.*date-\(....\)-\(..\)-\(..\).*/Dia: \3-\2-\1/; }' |
		sed '/class="exibicao"/d;s/<[^>]*alt="\([A-Za-z0-9 ]*\)">/\1  /g' |
		zztrim |
		sed -n "/${dia}/,/Dia: /p" | sed '$d' |
		zzxml --untag | zzunescape --html
	fi
}
