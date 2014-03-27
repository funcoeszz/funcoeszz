# ----------------------------------------------------------------------------
# Arruma o nome da cidade informada: maiúsculas, abreviações, acentos, etc.
#
# Uso: zzarrumacidade [cidade]
# Ex.: zzarrumacidade SAO PAULO                     # São Paulo
#      zzarrumacidade rj                            # Rio de Janeiro
#      zzarrumacidade Floripa                       # Florianópolis
#      echo Floripa | zzarrumacidade                # Florianópolis
#      cat cidades.txt | zzarrumacidade             # [uma cidade por linha]
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2013-02-21
# Versão: 3
# Licença: GPL
# Requisitos: zzcapitalize
# ----------------------------------------------------------------------------
zzarrumacidade ()
{
	zzzz -h arrumacidade "$1" && return

	# 1. Texto via STDIN ou argumentos
	# 2. Deixa todas as iniciais em maiúsculas
	# 3. sed mágico®
	zztool multi_stdin "$@" | zzcapitalize | sed "

		# Volta algumas iniciais para minúsculas
		s/ E / e /g
		s/ De / de /g
		s/ Da / da /g
		s/ Do / do /g
		s/ Das / das /g
		s/ Dos / dos /g

		# Expande abreviações comuns
		s/^Sp$/São Paulo/
		s/^Rj$/Rio de Janeiro/
		s/^Bh$/Belo Horizonte/
		s/^Bsb$/Brasília/
		s/^Rio$/Rio de Janeiro/
		s/^Sampa$/São Paulo/
		s/^Floripa$/Florianópolis/
		# s/^Poa$/Porto Alegre/  # Perigoso, pois existe: Poá - SP

		# Abreviações comuns a Belo Horizonte
		s/^B\. H\.$/Belo Horizonte/
		s/^Bhte$/Belo Horizonte/
		s/^B\. Hte$/Belo Horizonte/
		s/^B\. Hzte$/Belo Horizonte/
		s/^Belo Hte$/Belo Horizonte/
		s/^Belo Hzte$/Belo Horizonte/


		### Restaura acentuação de maneira pontual:

		# Restaura acentuação às capitais
		s/^Belem$/Belém/
		s/^Brasilia$/Brasília/
		s/^Cuiaba$/Cuiabá/
		s/^Florianopolis$/Florianópolis/
		s/^Goiania$/Goiânia/
		s/^Joao Pessoa$/João Pessoa/
		s/^Macapa$/Macapá/
		s/^Maceio$/Maceió/
		s/^S[ãa]o Lu[ií][sz]$/São Luís/
		s/^Vitoria$/Vitória/

		# Muitas cidades emprestam o nome do estado
		#   Santana do Piauí
		#   Teresina de Goiás
		#   Pontal do Paraná
		# então é útil acentuar os nomes de estados.
		#
		s/Amapa$/Amapá/
		s/Ceara$/Ceará/
		s/Goias$/Goiás/
		s/Maranhao$/Maranhão/
		s/Para$/Pará/
		s/Paraiba$/Paraíba/
		s/Parana$/Paraná/
		s/Piaui$/Piauí/
		s/Rondonia$/Rondônia/

		# O nome de alguns estados pode aparecer no início/meio
		#   Paraíba do Sul
		#   Pará de Minas
		#
		s/Amapa /Amapá /
		s/Espirito /Espírito /
		s/Para /Pará /
		s/Paraiba /Paraíba /


		### Restaura acentuação de maneira genérica:

		# Uberlândia, Rolândia
		s/landia /lândia /g
		s/landia$/lândia/

		# Florianópolis, Virginópolis
		s/opolis /ópolis /g
		s/opolis$/ópolis/

		# Palavras terminadas em 'ao' viram 'ão'.
		# Exemplos: São, João, Ribeirão, Capão
		#
		# Não achei nenhum caso de cidade com 'ao' no final:
		#   $ zzcidade 'ao '
		#   $
		#
		# Exceção: duas cidades com aó:
		#   $ zzcidade 'aó '
		#   Alto Caparaó (MG)
		#   Caparaó (MG)
		#   $
		#
		# Exceção da exceção: algum Caparão?
		#   $ zzcidade Caparão
		#   $
		#
		# Então resolvida a exceção Caparaó, é seguro fazer a troca.
		#
		s/Caparao$/Caparaó/
		s/ao /ão /g
		s/ao$/ão/


		### Exceções pontuais:

		# Morro Cabeça no Tempo
		s/ No / no /g

		# Passa-e-Fica
		s/-E-/-e-/g

		# São João del-Rei
		s/ Del-Rei/ del-Rei/g

		# Xangri-lá: Wikipédia
		# Xangri-Lá: http://www.xangrila.rs.gov.br
		# ** Vou ignorar a Wikipédia, não precisa arrumar este

		# Nomes de Papas
		s/^Pedro Ii$/Pedro II/
		s/^Pio Ix$/Pio IX/
		s/^Pio Xii$/Pio XII/

		# Estrela d'Oeste
		# Sítio d'Abadia
		# Dias d'Ávila
		# …
		s/ D'/ d'/g

		# São João do Pau-d'Alho
		# Olhos-d'Água
		# Pau-d'Arco
		# …
		s/-D'/-d'/g
	"
}
