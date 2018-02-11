# ----------------------------------------------------------------------------
# Fala a pronúncia correta de uma palavra em inglês.
# Uso: zzpronuncia palavra
# Ex.: zzpronuncia apple
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2002-04-10
# Versão: 5
# Licença: GPL
# Requisitos: zzplay zzunescape
# Nota: opcional say
# ----------------------------------------------------------------------------
zzpronuncia ()
{
	zzzz -h pronuncia "$1" && return

	local audio_file
	local palavra=$1
	local cache=$(zztool cache pronuncia "$palavra.mp3")
	local url='http://www.merriam-webster.com/dictionary'
	local url2='http://media.merriam-webster.com/audio/prons'

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
			zztool source "$url/$palavra" |
			sed -n '/data-file=/{s/.*href="//;s/".*//;p;q;}' |
			zzunescape --html |
			awk -F '[=_&]' '{print $3 "/" $4 "/mp3/" $6 "/" $8 ".mp3"}'
		)

		# Ops, não extraiu nada
		if test -z "$audio_file"
		then
			zztool erro "$palavra: palavra não encontrada"
			return 1
		fi

		# Compõe a URL do arquivo e salva-o localmente (cache)
		zztool source "$url2/$audio_file" > "$cache"
	fi

	# Fala que eu te escuto
	zzplay "$cache"
}
