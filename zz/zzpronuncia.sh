# ----------------------------------------------------------------------------
# Fala a pronúncia correta de uma palavra em inglês.
# Uso: zzpronuncia palavra
# Ex.: zzpronuncia apple
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2002-04-10
# Versão: 4
# Licença: GPL
# Requisitos: zzplay
# ----------------------------------------------------------------------------
zzpronuncia ()
{
	zzzz -h pronuncia "$1" && return

	local audio_file audio_dir
	local palavra=$1
	local cache=$(zztool cache pronuncia "$palavra.mp3")
	local url='http://www.merriam-webster.com/dictionary'
	local url2='http://media.merriam-webster.com/audio/prons/en/us/mp3'

	# Verificação dos parâmetros
	test -n "$1" || { zztool -e uso pronuncia; return 1; }

	# O 'say' é um comando do Mac OS X, aí não precisa baixar nada
	if test -x /usr/bin/say
	then
		say $*
		return
	fi

	# Busca o arquivo MP3 na Internet caso não esteja no cache
	if ! test -f "$cache"
	then
		# Extrai o nome do arquivo no site do dicionário
		audio_file=$(
			$ZZWWWHTML "$url/$palavra" |
			sed -n "/data-file=\"[^\"]*$palavra[^\"]*\"/{s/.*data-file=\"//;s/\".*//;p;}" |
			uniq)

		# Ops, não extraiu nada
		if test -z "$audio_file"
		then
			zztool erro "$palavra: palavra não encontrada"
			return 1
		else
			audio_file="${audio_file}.mp3"
		fi

		# O nome da pasta é a primeira letra do arquivo (/a/apple001.mp3)
		# Ou "number" se iniciar com um número (/number/9while01.mp3)
		audio_dir=$(echo $audio_file | cut -c1)
		echo $audio_dir | grep '[0-9]' >/dev/null && audio_dir='number'

		# Compõe a URL do arquivo e salva-o localmente (cache)
		$ZZWWWHTML "$url2/$audio_dir/$audio_file" > "$cache"
	fi

	# Fala que eu te escuto
	zzplay "$cache"
}
