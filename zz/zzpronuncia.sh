# ----------------------------------------------------------------------------
# http://www.m-w.com
# Fala a pronúncia correta de uma palavra em inglês.
# Uso: zzpronuncia palavra
# Ex.: zzpronuncia apple
#
# Autor: Thobias Salazar Trevisan, www.thobias.org
# Desde: 2002-04-10
# Versão: 3
# Licença: GPL
# Requisitos: zzplay
# ----------------------------------------------------------------------------
zzpronuncia ()
{
	zzzz -h pronuncia "$1" && return

	local wav_file wav_dir wav_url
	local palavra=$1
	local cache="$ZZTMP.pronuncia.$palavra.wav"
	local url='http://www.m-w.com/dictionary'
	local url2='http://cougar.eb.com/soundc11'

	# Verificação dos parâmetros
	[ "$1" ] || { zztool uso pronuncia; return 1; }

	# O 'say' é um comando do Mac OS X, aí não precisa baixar nada
	if test -x /usr/bin/say
	then
		say $*
		return
	fi

	# Busca o arquivo WAV na Internet caso não esteja no cache
	if ! test -f "$cache"
	then
		# Extrai o nome do arquivo no site do dicionário
		wav_file=$(
			$ZZWWWHTML "$url/$palavra" |
			sed -n "/.*return au('\([a-z0-9]\{1,\}\)'.*/{s//\1/p;q;}")

		# Ops, não extraiu nada
		if test -z "$wav_file"
		then
			echo "$palavra: palavra não encontrada"
			return 1
		else
			wav_file="${wav_file}.wav"
		fi

		# O nome da pasta é a primeira letra do arquivo (/a/apple001.wav)
		# Ou "number" se iniciar com um número (/number/9while01.wav)
		wav_dir=$(echo $wav_file | cut -c1)
		echo $wav_dir | grep '[0-9]' >/dev/null && wav_dir='number'

		# Compõe a URL do arquivo e salva-o localmente (cache)
		wav_url="$url2/$wav_dir/$wav_file"
		echo "URL: $wav_url"
		$ZZWWWHTML "$wav_url" > "$cache"
		echo "Gravado o arquivo '$cache'"
	fi

	# Fala que eu te escuto
	zzplay "$cache"
}
