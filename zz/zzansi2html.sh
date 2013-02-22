# ----------------------------------------------------------------------------
# Converte para HTML o texto colorido do terminal (códigos ANSI).
# Útil para mostrar a saída do terminal em sites e blogs, sem perder as cores.
# Obs.: Exemplos de texto ANSI estão na saída das funções zzcores e zzecho.
# Obs.: Use o comando script para guardar a saída do terminal em um arquivo.
# Uso: zzansi2html [arquivo]
# Ex.: zzecho --letra verde -s -p -N testando | zzansi2html
#      ls --color /etc | zzansi2html > ls.html
#      zzcores | zzansi2html > cores.html
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2008-09-02
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzansi2html ()
{
	zzzz -h ansi2html "$1" && return

	local esc=$(printf '\033')

	# Um único sed toma conta de toda a tarefa de conversão.
	#
	# Esta função cria um SPAN dentro do outro, sem fechar, pois os códigos ANSI
	# são cumulativos: abrir um novo não desliga os anteriores.
	#    echo -e '\e[4mFOO\e[33mBAR'  # BAR é amarelo *e* sublinhado
	#
	# No CSS, o text-decoration é cumulativo para sub-elementos (FF, Safari), veja:
	# <span style=text-decoration:underline>FOO<span style=text-decoration:none>BAR
	# O BAR também vai aparecer sublinhado, o 'none' no SPAN filho não o desliga.
	# Por isso é preciso uma outra tática para desligar sublinhado e blink.
	#
	# Uma alternativa seria fechar todos os SPANs no ^[0m, mas é difícil no sed
	# saber quantos SPANs estão abertos (multilinha). A solução foi usar DIVs,
	# que ao serem fechados desligam todos os SPANs anteriores.
	#    ^[0m  -->  </div><div style="display:inline">
	#

	# Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" |
	sed "
		# Engloba o código na tag PRE para preservar espaços
		1 i\\
		<pre style=\"background:#000;color:#FFF\"><div style=\"display:inline\">
		$ a\\
		</pre>

		# Escapes do HTML
		s/&/&amp;/g
		s/</&lt;/g
		s/>/&gt;/g

		:ini
		/$esc\[[0-9;]*m/ {

			# Guarda a linha original
			h

			# Isola os números (ex: 33;41;1) da *primeira* ocorrência
			s/\($esc\[[0-9;]*\)m.*/\1/
			s/.*$esc\[\([0-9;]*\)$/\1/

			# Se vazio (^[m) vira zero
			s/^$/0/

			# Adiciona separadores no início e fim
			s/.*/;&;/

			# Zero limpa todos os atributos
			#
			# XXX
			# Note que 33;0;4 (amarelo, reset, sublinhado) vira reset,
			# mas deveria ser reset+sublinhado. É um caso difícil de
			# encontrar, então vamos conviver com essa limitação.
			#
			/;;*00*;;*/ {
				s,.*,</div><div style=\"display:inline\">,
				b end
			}

			# Define as cores
			s/;30;/;color:#000;/g; s/;40;/;background:#000;/g
			s/;31;/;color:#F00;/g; s/;41;/;background:#C00;/g
			s/;32;/;color:#0F0;/g; s/;42;/;background:#0C0;/g
			s/;33;/;color:#FF0;/g; s/;43;/;background:#CC0;/g
			s/;34;/;color:#00F;/g; s/;44;/;background:#00C;/g
			s/;35;/;color:#F0F;/g; s/;45;/;background:#C0C;/g
			s/;36;/;color:#0FF;/g; s/;46;/;background:#0CC;/g
			s/;37;/;color:#FFF;/g; s/;47;/;background:#CCC;/g

			# Define a formatação
			s/;1;/;font-weight:bold;/g
			s/;4;/;text-decoration:underline;/g
			s/;5;/;text-decoration:blink;/g

			# Força remoção da formatação, caso não especificado
			/font-weight/! s/$/;font-weight:normal/
			/text-decoration/! s/$/;text-decoration:none/

			# Remove códigos de texto reverso
			s/;7;/;/g

			# Normaliza os separadores
			s/;;;*/;/g
			s/^;//
			s/;$//

			# Engloba as propriedades na tag SPAN
			s,.*,<span style=\"&\">,

			:end

			# Recupera a linha original e anexa o SPAN no final
			# Ex.: ^[33m amarelo ^[m\n<span style=...>
			x
			G

			# Troca o código ANSI pela tag SPAN
			s/$esc\[[0-9;]*m\(.*\)\n\(.*\)/\2\1/

			# E começa tudo de novo, até acabar todos da linha
			b ini
		}
	"
}
