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
# Versão: 3
# Licença: GPL
# Tags: arquivo, utilitário
# ----------------------------------------------------------------------------
zzlembrete ()
{
	zzzz -h lembrete "$1" && return

	local numero tmp
	local arquivo="${ZZTMPDIR:-$HOME}/.zzlembrete"

	# Assegura-se que o arquivo de lembretes existe
	test -f "$arquivo" || touch "$arquivo"

	# Sem argumentos, mostra todos os lembretes
	if test $# -eq 0
	then
		cat -n "$arquivo"

	# Tem argumentos, que podem ser para mostrar, apagar ou adicionar
	elif echo "$*" | tr -s '\t ' '  ' | grep '^ *[0-9]\{1,\} *d\{0,1\} *$' >/dev/null
	then
		# Extrai o número da linha
		numero=$(echo "$*" | tr -d -c 0123456789)

		# Se não for um número ou menor igual a zero sai com erro.
		zztool testa_numero "$numero" && test "$numero" -gt 0 || return 1

		if zztool grep_var d "$*"
		then
			# zzlembrete 5d: Apaga linha 5
			tmp=$(zztool mktemp lembrete)
			cp "$arquivo" "$tmp" &&
			sed "$numero d" "$tmp" > "$arquivo" || {
				zztool erro "Ops, deu algum erro no arquivo $arquivo"
				zztool erro "Uma cópia dele está em $tmp"
				return 1
			}
			rm -f "$tmp"
		else
			# zzlembrete 5: Mostra linha 5
			sed -n "$numero p" "$arquivo"
		fi
	else
		# zzlembrete texto: Adiciona o texto
		echo "$*" >> "$arquivo" || {
			zztool erro "Ops, não consegui adicionar esse lembrete"
			return 1
		}
	fi
}
