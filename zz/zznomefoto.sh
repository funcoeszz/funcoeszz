# ----------------------------------------------------------------------------
# Renomeia arquivos do diretório atual, arrumando a seqüência numérica.
# Obs.: Útil para passar em arquivos de fotos baixadas de uma câmera.
# Opções: -n  apenas mostra o que será feito, não executa
#         -i  define a contagem inicial
#         -d  número de dígitos para o número
#         -p  prefixo padrão para os arquivos
#         --dropbox  renomeia para data+hora da foto, padrão Dropbox
# Uso: zznomefoto [-n] [-i N] [-d N] [-p TXT] arquivo(s)
# Ex.: zznomefoto -n *                        # tire o -n para renomear!
#      zznomefoto -n -p churrasco- *.JPG      # tire o -n para renomear!
#      zznomefoto -n -d 4 -i 500 *.JPG        # tire o -n para renomear!
#      zznomefoto -n --dropbox *.JPG          # tire o -n para renomear!
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2004-11-10
# Versão: 3
# Licença: GPL
# Requisitos: zzminusculas
# ----------------------------------------------------------------------------
zznomefoto ()
{
	zzzz -h nomefoto "$1" && return

	local arquivo prefixo contagem extensao nome novo nao previa
	local dropbox exif_info exif_cmd
	local i=1
	local digitos=3

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-p)
				prefixo="$2"
				shift; shift
			;;
			-i)
				i=$2
				shift; shift
			;;
			-d)
				digitos=$2
				shift; shift
			;;
			-n)
				nao='[-n] '
				shift
			;;
			--dropbox)
				dropbox=1
				shift
			;;
			*)
				break
			;;
		esac
	done

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso nomefoto; return 1; }

	if ! zztool testa_numero "$digitos"
	then
		echo "Número inválido para a opção -d: $digitos"
		return 1
	fi
	if ! zztool testa_numero "$i"
	then
		echo "Número inválido para a opção -i: $i"
		return 1
	fi
	if test "$dropbox" = 1
	then
		if type "exiftool" >/dev/null 2>&1
		then
			exif_cmd=1
		elif type "exiftime" >/dev/null 2>&1
		then
			exif_cmd=2
		elif type "identify" >/dev/null 2>&1
		then
			exif_cmd=3
		else
			echo "A opção --dropbox requer o comando 'exiftool', 'exiftime' ou 'identify', instale um deles."
			echo "O comando 'exiftime' pode fazer parte do pacote 'exiftags'."
			echo "O comando 'identify' faz parte do pacote ImageMagick."
			return 1
		fi
	fi

	# Para cada arquivo que o usuário informou...
	for arquivo
	do
		# O arquivo existe?
		zztool arquivo_legivel "$arquivo" || continue

		# Componentes do nome novo
		contagem=$(printf "%0${digitos}d" $i)

		# Se tiver extensão, guarda para restaurar depois
		if zztool grep_var . "$arquivo"
		then
			extensao=".${arquivo##*.}"
		else
			extensao=
		fi

		# Nome do arquivo no formato do Camera Uploads do Dropbox,
		# que usa a data e hora em que a foto foi tirada. Exemplo:
		#
		#     2010-04-05 09.02.11.jpg
		#
		# A data é extraída do campo EXIF chamado DateTimeOriginal.
		# Outra opção seria o campo CreateDate. Veja mais informações em:
		# http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/EXIF.html
		#
		if test "$dropbox" = 1
		then
			# Extrai a data+hora em que a foto foi tirada conforme o comamdo disponível no sistema
			case $exif_cmd in
				1) exif_info=$(exiftool -s -S -DateTimeOriginal -d '%Y-%m-%d %H.%M.%S' "$arquivo") ;;
				2)
					exif_info=$(exiftime -tg "$arquivo" 2>/dev/null |
					awk -F':' '{print $2 "-" $3 "-" $4 "." $5 "." $6}' |
					sed 's/^ *//') ;;
				3)
					exif_info=$(identify -verbose "$arquivo" |
					awk -F':' '/DateTimeOriginal/ {print $3 "-" $4 "-" $5 "." $6 "." $7}' |
					sed 's/^ *//') ;;
			esac

			# A extensão do arquivo é em minúsculas
			extensao=$(echo "$extensao" | zzminusculas)

			novo="$exif_info$extensao"

			# Será que deu problema na execução do comando?
			if test -z "$exif_info"
			then
				echo "Ignorando $arquivo (não possui dados EXIF)"
				continue
			fi

			# Se o arquivo já está com o nome OK, ignore-o
			if test "$novo" = "$arquivo"
			then
				echo "Arquivo $arquivo já está com o nome correto (nada a fazer)"
				continue
			fi

		# Renomeação normal
		else
			# O nome começa com o prefixo, se informado pelo usuário
			if [ "$prefixo" ]
			then
				nome=$prefixo

			# Se não tiver prefixo, usa o nome base do arquivo original,
			# sem extensão nem números no final (se houver).
			# Exemplo: DSC123.JPG -> DSC
			else
				nome=$(echo "${arquivo%.*}" | sed 's/[0-9][0-9]*$//')
			fi

			# Compõe o nome novo
			novo="$nome$contagem$extensao"
		fi

		# Mostra na tela a mudança
		previa="$nao$arquivo -> $novo"

		if [ "$novo" = "$arquivo" ]
		then
			# Ops, o arquivo novo tem o mesmo nome do antigo
			echo "$previa" | sed "s/^\[-n\]/[-ERRO-]/"
		else
			echo "$previa"
		fi

		# Atualiza a contagem (Ah, sério?)
		i=$((i+1))

		# Se não tiver -n, vamos renomear o arquivo
		if ! [ "$nao" ]
		then
			# Não sobrescreve arquivos já existentes
			zztool arquivo_vago "$novo" || return

			# E finalmente, renomeia
			mv -- "$arquivo" "$novo"
		fi
	done
}
