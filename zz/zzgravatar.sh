# ----------------------------------------------------------------------------
# http://www.gravatar.com
# Monta a URL completa para o Gravatar do email informado.
#
# Opções: -t, --tamanho N      Tamanho do avatar (padrão 80, máx 512)
#         -d, --default TIPO   Tipo do avatar substituto, se não encontrado
#
# Se não houver um avatar para o email, a opção --default informa que tipo
# de avatar substituto será usado em seu lugar:
#     mm          Mistery Man, a silhueta de uma pessoa (não muda)
#     identicon   Padrão geométrico, muda conforme o email
#     monsterid   Monstros, muda cores e rostos
#     wavatar     Rostos, muda características e cores
#     retro       Rostos pixelados, tipo videogame antigo 8-bits
# Veja exemplos em http://gravatar.com/site/implement/images/
#
# Uso: zzgravatar [--tamanho N] [--default tipo] email
# Ex.: zzgravatar fulano@dominio.com.br
#      zzgravatar -t 128 -d mm fulano@dominio.com.br
#      zzgravatar --tamanho 256 --default retro fulano@dominio.com.br
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-06
# Versão: 1
# Licença: GPL
# Requisitos: zzmd5 zzminusculas
# ----------------------------------------------------------------------------
zzgravatar ()
{
	zzzz -h gravatar "$1" && return

	# Instruções de implementação:
	# http://gravatar.com/site/implement/
	#
	# Exemplo de URL do Gravatar, com tamanho de 96 e MisteryMan:
	# http://www.gravatar.com/avatar/e583bca48acb877efd4a29229bf7927f?size=96&default=mm

	local email default extra codigo
	local tamanho=80  # padrão caso não informado é 80
	local tamanho_maximo=512
	local defaults="mm:identicon:monsterid:wavatar:retro"
	local url='http://www.gravatar.com/avatar/'

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-t | --tamanho)
				tamanho="$2"
				extra="$extra&size=$tamanho"
				shift
				shift
			;;
			-d | --default)
				default="$2"
				extra="$extra&default=$default"
				shift
				shift
			;;
			*)
				break
			;;
		esac
	done

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso gravatar; return 1; }

	# Guarda o email informado, sempre em minúsculas
	email=$(zztool trim "$1" | zzminusculas)

	# Foi passado um número mesmo?
	if ! zztool testa_numero "$tamanho" || test "$tamanho" = 0
	then
		echo "Número inválido para a opção -t: $tamanho"
		return 1
	fi

	# Temos uma limitação de tamanho
	if [ $tamanho -gt $tamanho_maximo ]
	then
		echo "O tamanho máximo para a imagem é $tamanho_maximo"
		return 1
	fi

	# O default informado é válido?
	if test -n "$default" && ! zztool grep_var ":$default:"  ":$defaults:"
	then
		echo "Valor inválido para a opção -d: '$default'"
		return 1
	fi

	# Calcula o hash do email
	codigo=$(printf "$email" | zzmd5)

	# Verifica o hash e o coloca na URL
	if test -n "$codigo"
	then
		url="$url$codigo"
	else
		echo "Houve um erro na geração do código MD5 do email"
		return 1
	fi

	# Adiciona as opções extras na URL
	if test -n "$extra"
	then
		url="$url?${extra#&}"
	fi

	# Tá feito, essa é a URL final
	echo "$url"
}
