# ----------------------------------------------------------------------------
# Lista os estados do Brasil e suas capitais.
# Obs.: Sem argumentos, mostra a lista completa.
#
# Opções: --sigla        Mostra somente as siglas
#         --nome         Mostra somente os nomes
#         --capital      Mostra somente as capitais
#         --slug         Mostra somente os slugs (nome simplificado)
#         --formato FMT  Você escolhe o formato de saída, use os tokens:
#                        {sigla}, {nome}, {capital}, {slug}, \n , \t
#         --python       Formata como listas/dicionários do Python
#         --javascript   Formata como arrays do JavaScript
#         --php          Formata como arrays do PHP
#         --html         Formata usando a tag <SELECT> do HTML
#         --xml          Formata como arquivo XML
#         --url,--url2   Exemplos simples de uso da opção --formato
#
# Uso: zzestado [--OPÇÃO]
# Ex.: zzestado                      # [mostra a lista completa]
#      zzestado --sigla              # AC AL AP AM BA …
#      zzestado --html               # <option value="AC">AC - Acre</option> …
#      zzestado --python             # siglas = ['AC', 'AL', 'AP', …
#      zzestado --formato '{sigla},'             # AC,AL,AP,AM,BA,…
#      zzestado --formato '{sigla} - {nome}\n'   # AC - Acre …
#      zzestado --formato '{capital}-{sigla}\n'  # Rio Branco-AC …
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2013-02-21
# Versão: 4
# Licença: GPL
# ----------------------------------------------------------------------------
zzestado ()
{
	zzzz -h estado "$1" && return

	local sigla nome slug capital fmt resultado

	# {sigla}:{nome}:{slug}:{capital}
	local dados="\
AC:Acre:acre:Rio Branco
AL:Alagoas:alagoas:Maceió
AP:Amapá:amapa:Macapá
AM:Amazonas:amazonas:Manaus
BA:Bahia:bahia:Salvador
CE:Ceará:ceara:Fortaleza
DF:Distrito Federal:distrito-federal:Brasília
ES:Espírito Santo:espirito-santo:Vitória
GO:Goiás:goias:Goiânia
MA:Maranhão:maranhao:São Luís
MT:Mato Grosso:mato-grosso:Cuiabá
MS:Mato Grosso do Sul:mato-grosso-do-sul:Campo Grande
MG:Minas Gerais:minas-gerais:Belo Horizonte
PA:Pará:para:Belém
PB:Paraíba:paraiba:João Pessoa
PR:Paraná:parana:Curitiba
PE:Pernambuco:pernambuco:Recife
PI:Piauí:piaui:Teresina
RJ:Rio de Janeiro:rio-de-janeiro:Rio de Janeiro
RN:Rio Grande do Norte:rio-grande-do-norte:Natal
RS:Rio Grande do Sul:rio-grande-do-sul:Porto Alegre
RO:Rondônia:rondonia:Porto Velho
RR:Roraima:roraima:Boa Vista
SC:Santa Catarina:santa-catarina:Florianópolis
SP:São Paulo:sao-paulo:São Paulo
SE:Sergipe:sergipe:Aracaju
TO:Tocantins:tocantins:Palmas"


	case "$1" in
		--sigla  ) echo "$dados" | cut -d : -f 1 ;;
		--nome   ) echo "$dados" | cut -d : -f 2 ;;
		--slug   ) echo "$dados" | cut -d : -f 3 ;;
		--capital) echo "$dados" | cut -d : -f 4 ;;

		--formato)
			fmt="$2"
			echo "$dados" |
			(
				IFS=:
				while read sigla nome slug capital
				do
					resultado=$(printf %s "$fmt" | sed "
						s/{sigla}/$sigla/g
						s/{nome}/$nome/g
						s/{slug}/$slug/g
						s/{capital}/$capital/g
					")
					printf "$resultado"
				done
			)
		;;
		--python | --py)
			sigla=$(  zzestado --formato "'{sigla}', "   | sed 's/, $//')
			nome=$(   zzestado --formato "'{nome}', "    | sed 's/, $//')
			capital=$(zzestado --formato "'{capital}', " | sed 's/, $//')

			printf   'siglas = [%s]\n\n' "$sigla"
			printf    'nomes = [%s]\n\n' "$nome"
			printf 'capitais = [%s]\n\n' "$capital"

			echo 'estados = {'
			zzestado --formato "  '{sigla}': '{nome}',\n"
			echo '}'
			echo
			echo 'estados = {'
			zzestado --formato "  '{sigla}': ('{nome}', '{capital}', '{slug}'),\n"
			echo '}'
		;;
		--php)
			sigla=$(  zzestado --formato '"{sigla}", '   | sed 's/, $//')
			nome=$(   zzestado --formato '"{nome}", '    | sed 's/, $//')
			capital=$(zzestado --formato '"{capital}", ' | sed 's/, $//')

			printf   '$siglas = array(%s);\n\n' "$sigla"
			printf    '$nomes = array(%s);\n\n' "$nome"
			printf '$capitais = array(%s);\n\n' "$capital"

			echo '$estados = array('
			zzestado --formato '  "{sigla}" => "{nome}",\n'
			echo ');'
			echo
			echo '$estados = array('
			zzestado --formato '  "{sigla}" => array("{nome}", "{capital}", "{slug}"),\n'
			echo ');'
		;;
		--javascript | --js)
			sigla=$(  zzestado --formato "'{sigla}', "   | sed 's/, $//')
			nome=$(   zzestado --formato "'{nome}', "    | sed 's/, $//')
			capital=$(zzestado --formato "'{capital}', " | sed 's/, $//')

			printf   'var siglas = [%s];\n\n' "$sigla"
			printf    'var nomes = [%s];\n\n' "$nome"
			printf 'var capitais = [%s];\n\n' "$capital"

			echo 'var estados = {'
			zzestado --formato "  {sigla}: '{nome}',\n" | sed '$ s/,$//'
			echo '};'
			echo
			echo 'var estados = {'
			zzestado --formato "  {sigla}: ['{nome}', '{capital}', '{slug}'],\n" | sed '$ s/,$//'
			echo '}'
		;;
		--html)
			echo '<select>'
			zzestado --formato '  <option value="{sigla}">{sigla} - {nome}</option>\n'
			echo '</select>'
		;;
		--xml)
			echo '<estados>'
			zzestado --formato '\t<uf sigla="{sigla}">\n\t\t<nome>{nome}</nome>\n\t\t<capital>{capital}</capital>\n\t\t<slug>{slug}</slug>\n\t</uf>\n'
			echo '</estados>'
		;;
		--url)
			zzestado --formato 'http://foo.{sigla}.gov.br\n' | tr '[A-Z]' '[a-z]'
		;;
		--url2)
			zzestado --formato 'http://foo.com.br/{slug}/\n'
		;;
		*)
			zzestado --formato '{sigla}\t{nome}\t{capital}\n' | expand -t 6,29
		;;
	esac
}
