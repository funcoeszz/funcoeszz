# ----------------------------------------------------------------------------
# Uma forma de ler o site Inovação Tecnológica.
# Sem opção mostra o resumo da página principal.
#
# Opções podem ser sub-temas e/ou número:
#
# Sub-temas podem ser:
#   eletronica, energia, espaco, informatica, materiais,
#   mecanica, meioambiente, nanotecnologia, robotica, plantao.
#
# Se a opção for um número mostra a matéria selecionada,
# seja da página principal ou de um sub-tema.
#
# Uso: zzit [sub-tema] [número]
# Ex.: zzit             # Um resumo da página principal
#      zzit espaco      # Um resumo do sub-tem espaço
#      zzit 3           # Exibe a terceira matéria da página principal
#      zzit mecanica 7  # Exibe a sétima matéria do sub-tema mecânica
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2016-02-28
# Versão: 1
# Licença: GPL
# Requisitos: zzsemacento zzutf8 zzxml zzsqueeze
# ----------------------------------------------------------------------------
zzit ()
{

	zzzz -h it "$1" && return

	local url='http://www.inovacaotecnologica.com.br'
	local url2 opcao num

	opcao=$(echo "$1" | zzsemacento)
	case "$opcao" in
		eletronica | energia | espaco | informatica | materiais | mecanica | meioambiente | nanotecnologia | robotica | plantao )
			url2="$url/noticias/assuntos.php?assunto=$opcao"
			shift ;;
		* )	url2="$url/index.php" ;;
	esac

	zztool testa_numero $1 && num=$1

	$ZZWWWHTML "$url2" |
	zzutf8 |
	awk '/<div id="manchete">/,/Leia mais/' |
	zzxml --tag a --untag=img |
	sed '/^<\/a>$/,/^<\/a>$/d;/^ *$/d;/assunto=/{N;d;}' |
	if test -z "$num"
	then
		awk 'NR % 2 == 0 { printf "%02d - %s\n", NR / 2 , $0 }'
	else
		url2=$(awk -v linha=$num 'NR == linha * 2 -1' | sed 's/">//;s/.*"//;s|\.\./||' | sed "s|^|${url}/|")
		zztool eco "$url2"
		$ZZWWWDUMP "$url2" |
		sed '1,/^ *Livros$/d; s/ *\( Bibliografia:\)/\
\1/' |
		sed '1,/^ *$/d; /INS: :INS/,$d' |
		zzsqueeze | fmt -w 120
	fi
}
