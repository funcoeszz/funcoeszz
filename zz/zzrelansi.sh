# ----------------------------------------------------------------------------
# Coloca um relógio digital (hh:mm:ss) no canto superior direito do terminal.
# Uso: zzrelansi [-s|--stop]
# Ex.: zzrelansi
#
# Autor: Arkanon <arkanon (a) lsd org br>
# Desde: 2009-09-17
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzrelansi ()
{

	zzzz -h relansi "$1" && return

	case $1 in
	-s | --stop)
		shopt -q
		if [ "$relansi_pid" ]
		then
			kill $relansi_pid
			relansi_write
			unset relansi_cols relansi_pid relansi_write
		else
			echo "RelANSI não está sendo executado"
		fi
	;;
	*)
		if [ "$relansi_pid" ]
		then
			echo "RelANSI já está sendo executado pelo processo $relansi_pid"
		else
			relansi_cols=$(tput cols)
			relansi_write()
				{
				tput sc
				tput cup 0 $[$relansi_cols-8]
				[ "$1" ] && date +'%H:%M:%S' || echo '        '
				tput rc
				}
			exec 3>&2 2> /dev/null
			while true
			do
				relansi_write start
				sleep 1
			done &
			relansi_pid=$!
			disown $relansi_pid # RESTRICAO: builtin no bash e zsh, mas nao no csh e ksh
			exec 2>&3
		fi
	;;
	esac

}
