# ----------------------------------------------------------------------------
# Aguarda N minutos e dispara uma sirene usando o 'speaker'.
# Útil para lembrar de eventos próximos no mesmo dia.
# Sem argumentos, restaura o 'beep' para o seu tom e duração originais.
# Obs.: A sirene tem 4 toques, sendo 2 tons no modo texto e apenas 1 no Xterm.
# Uso: zzbeep [números]
# Ex.: zzbeep 0
#      zzbeep 1 5 15    # espere 1 minuto, depois mais 5, e depois 15
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2000-04-24
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzbeep ()
{
	zzzz -h beep "$1" && return

	local minutos frequencia

	# Sem argumentos, apenas restaura a "configuração de fábrica" do beep
	[ "$1" ] || {
		printf '\033[10;750]\033[11;100]\a'
		return 0
	}

	# Para cada quantidade informada pelo usuário...
	for minutos in $*
	do
		# Aguarda o tempo necessário
		echo -n "Vou bipar em $minutos minutos... "
		sleep $((minutos*60))

		# Ajusta o beep para toque longo (Linux modo texto)
		printf '\033[11;900]'

		# Alterna entre duas freqüências, simulando uma sirene (Linux)
		for frequencia in 500 400 500 400
		do
			printf "\033[10;$frequencia]\a"
			sleep 1
		done

		# Restaura o beep para toque normal
		printf '\033[10;750]\033[11;100]'
		echo OK
	done
}
