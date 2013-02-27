# ----------------------------------------------------------------------------
# Sistema simples de lembretes: cria, apaga e mostra.
# Uso: zzlembrete [texto]|[número [d]]
# Ex.: zzlembrete                      # Mostra todos
#      zzlembrete 5                    # Mostra o 5º lembrete
#      zzlembrete 5d                   # Deleta o 5º lembrete
#      zzlembrete Almoço com a sogra   # Adiciona lembrete
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-10-22
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzlembrete ()
{
	zzzz -h lembrete "$1" && return

	local arquivo="$HOME/.zzlembrete"
	local tmp="$ZZTMP.lembrete.$$"
	local numero

	# Assegura-se que o arquivo de lembretes existe
	test -f "$arquivo" || touch "$arquivo"

	# Sem argumentos, mostra todos os lembretes
	if test $# -eq 0
	then
		cat -n "$arquivo"

	# Tem argumentos, que podem ser para mostrar, apagar ou adicionar
	elif echo "$*" | tr -s '\t ' ' ' | grep '^ *[0-9]\{1,\} *d\{0,1\} *$' >/dev/null
	then
		# Extrai o número da linha
		numero=$(echo "$*" | tr -d -c 0123456789)

		if zztool grep_var d "$*"
		then
			# zzlembrete 5d: Apaga linha 5
			cp "$arquivo" "$tmp" &&
			sed "${numero:-0} d" "$tmp" > "$arquivo" || {
				echo "Ops, deu algum erro no arquivo $arquivo"
				echo "Uma cópia dele está em $tmp"
				return 1
			}
		else
			# zzlembrete 5: Mostra linha 5
			sed -n "$numero p" "$arquivo"
		fi
	else
		# zzlembrete texto: Adiciona o texto
		echo "$*" >> "$arquivo" || {
			echo "Ops, não consegui adicionar esse lembrete"
			return 1
		}
	fi
}
