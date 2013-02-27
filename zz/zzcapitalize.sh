# ----------------------------------------------------------------------------
# Altera Um Texto Para Deixar Todas As Iniciais De Palavras Em Maiúsculas.
# Use a opção -1 para converter somente a primeira letra de cada linha.
# Use a opção -w para adicionar caracteres de palavra (Padrão: A-Za-z0-9áéí…)
#
# Uso: zzcapitalize [texto]
# Ex.: zzcapitalize root                                 # Root
#      zzcapitalize kung fu panda                        # Kung Fu Panda
#      zzcapitalize -1 kung fu panda                     # Kung fu panda
#      zzcapitalize quero-quero                          # Quero-Quero
#      echo eu_uso_camel_case | zzcapitalize             # Eu_Uso_Camel_Case
#      echo "i don't care" | zzcapitalize                # I Don'T Care
#      echo "i don't care" | zzcapitalize -w \'          # I Don't Care
#      cat arquivo.txt | zzcapitalize
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2013-02-21
# Versão: 5
# Licença: GPL
# Requisitos: zzminusculas
# ----------------------------------------------------------------------------
zzcapitalize ()
{
	zzzz -h capitalize "$1" && return

	local primeira todas filtros extra x
	local acentuadas='àáâãäåèéêëìíîïòóôõöùúûüçñÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÇÑ'
	local palavra='A-Za-z0-9'
	local soh_primeira=0

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-1)
				soh_primeira=1
				shift
			;;
			-w)
				# Escapa a " pra não dar problema no sed adiante
				extra=$(echo "$2" | sed 's/"/\\"/g')
				shift
				shift
			;;
			*) break ;;
		esac
	done

	# Aqui está a lista de caracteres que compõem uma palavra.
	# Estes caracteres *não* disparam a capitalização da letra seguinte.
	# Esta regex é usada na variável $todas, a seguir.
	x="[^$palavra$acentuadas$extra]"

	# Filtro que converte pra maiúsculas somente a primeira letra da linha
	primeira='
		s_^a_A_ ; s_^n_N_ ; s_^à_À_ ; s_^ï_Ï_ ;
		s_^b_B_ ; s_^o_O_ ; s_^á_Á_ ; s_^ò_Ò_ ;
		s_^c_C_ ; s_^p_P_ ; s_^â_Â_ ; s_^ó_Ó_ ;
		s_^d_D_ ; s_^q_Q_ ; s_^ã_Ã_ ; s_^ô_Ô_ ;
		s_^e_E_ ; s_^r_R_ ; s_^ä_Ä_ ; s_^õ_Õ_ ;
		s_^f_F_ ; s_^s_S_ ; s_^å_Å_ ; s_^ö_Ö_ ;
		s_^g_G_ ; s_^t_T_ ; s_^è_È_ ; s_^ù_Ù_ ;
		s_^h_H_ ; s_^u_U_ ; s_^é_É_ ; s_^ú_Ú_ ;
		s_^i_I_ ; s_^v_V_ ; s_^ê_Ê_ ; s_^û_Û_ ;
		s_^j_J_ ; s_^w_W_ ; s_^ë_Ë_ ; s_^ü_Ü_ ;
		s_^k_K_ ; s_^x_X_ ; s_^ì_Ì_ ; s_^ç_Ç_ ;
		s_^l_L_ ; s_^y_Y_ ; s_^í_Í_ ; s_^ñ_Ñ_ ;
		s_^m_M_ ; s_^z_Z_ ; s_^î_Î_ ;
	'
	# Filtro que converte pra maiúsculas a primeira letra de cada palavra.
	# Note que o delimitador usado no s///g foi o espaço em branco.
	todas="
		s \($x\)a \1A g ; s \($x\)n \1N g ; s \($x\)à \1À g ; s \($x\)ï \1Ï g ;
		s \($x\)b \1B g ; s \($x\)o \1O g ; s \($x\)á \1Á g ; s \($x\)ò \1Ò g ;
		s \($x\)c \1C g ; s \($x\)p \1P g ; s \($x\)â \1Â g ; s \($x\)ó \1Ó g ;
		s \($x\)d \1D g ; s \($x\)q \1Q g ; s \($x\)ã \1Ã g ; s \($x\)ô \1Ô g ;
		s \($x\)e \1E g ; s \($x\)r \1R g ; s \($x\)ä \1Ä g ; s \($x\)õ \1Õ g ;
		s \($x\)f \1F g ; s \($x\)s \1S g ; s \($x\)å \1Å g ; s \($x\)ö \1Ö g ;
		s \($x\)g \1G g ; s \($x\)t \1T g ; s \($x\)è \1È g ; s \($x\)ù \1Ù g ;
		s \($x\)h \1H g ; s \($x\)u \1U g ; s \($x\)é \1É g ; s \($x\)ú \1Ú g ;
		s \($x\)i \1I g ; s \($x\)v \1V g ; s \($x\)ê \1Ê g ; s \($x\)û \1Û g ;
		s \($x\)j \1J g ; s \($x\)w \1W g ; s \($x\)ë \1Ë g ; s \($x\)ü \1Ü g ;
		s \($x\)k \1K g ; s \($x\)x \1X g ; s \($x\)ì \1Ì g ; s \($x\)ç \1Ç g ;
		s \($x\)l \1L g ; s \($x\)y \1Y g ; s \($x\)í \1Í g ; s \($x\)ñ \1Ñ g ;
		s \($x\)m \1M g ; s \($x\)z \1Z g ; s \($x\)î \1Î g ;
	"

	# Aplicando a opção -1, caso informada
	test $soh_primeira -eq 1 && todas=''

	filtros="$primeira $todas"

	# Texto via STDIN ou argumentos
	# Primeiro converte tudo pra minúsculas, depois capitaliza as iniciais
	zztool multi_stdin "$@" | zzminusculas | sed "$filtros"
}
