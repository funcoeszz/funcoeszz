# ----------------------------------------------------------------------------
# http://debgen.simplylinux.ch/index.php
# Gera uma saida para o arquivo sources.list para o debian.
#
# Paises: at,au,ba,be,bg,br,by,ca,ch,cl,cn,cz,de,dk,ee,es,fi,fr,gr,hk,hr,hu,
#         ie,is,it,jp,kr,mx,nl,no,nz,pl,pt,ro,ru,se,si,sk,tr,tw,ua,uk,us
#
# Release: Lenny, Squeeze, wheezy, Sid, Experimental
#
# Opções:
# main,main-src,main-all:
#	Add repositório main, main source ou ambos.
#
# contrib,contrib-src,contrib-all:
#	Add repositório contrib, contrib source ou ambos.
#
# non-free,non-free-src,non-free-all:
#	Add repositório non-free, non-free source ou ambos.
#
# security,security-src,security-all:
#	Add repositório Security updates
#
# updates,updates-src,updates-all:
#	Add repositório updates
#
# Uso: zzdebgen -p país -r release -b [branches]
# Ex.: zzdebgen -p br -r Lenny -b main-all
#      zzdebgen --pais br --release Squeeze --branch main-all contrib-all
#      zzdebgen -p us -r wheezy --branch security-src contrib non-free-all
#
# Autor: Marcell S. Martini <marcellmartini (a) gmail com>
# Desde: 2012-04-08
# Versão: 1
# Licença: GPL
# Requisitos: zzecho
# ----------------------------------------------------------------------------
# DESATIVADA: 2013-02-28 Parou de funcionar (issue #50)
zzdebgen ()
{
	zzzz -h debgen "$1" && return

	[ "$#" == 0 ] && { zztool uso debgen; return 1; }

	# Variáveis locais
	local country="br"
	local release="3"
	local url="http://debgen.simplylinux.ch/generate.php"
	local post=""
	local branches=""

	# Parse dos parametros passados para a zzdebgen
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			-p|--pais)
				case "$2" in
					at|au|ba|be|bg|br|by|ca|ch|cl|cn|cz)
						country="$2"
					;;

					de|dk|ee|es|fi|fr|gr|hk|hr|hu)
						country="$2"
					;;

					ie|is|it|jp|kr|mx|nl|no|nz|pl|pt|ro)
						country="$2"
					;;

					ru|se|si|sk|tr|tw|ua|uk|us)
						country="$2"
					;;
					*)
						zzecho -N -l vermelho "Paiz desconhecido."
						zzzz -h debgen -h;return 1
					;;
				esac
				shift
			;;

			-r|--release)
				case "$2" in
					Lenny) release="2" ;;
					Squeeze) release="3" ;;
					wheezy) release="4" ;;
					Sid) release="98" ;;
					Experimental) release="99" ;;
				esac
				shift
			;;

			-b|--branch)
				while [ "${2}x" != "x" ]
				do
					case "$2" in
						main) branches="${branches}&ub[]=1" ;;
						main-src) branches="${branches}&ub_src[]=1" ;;
						main-all) branches="${branches}&ub[]=1&ub_src[]=1" ;;

						contrib) branches="${branches}&ub[]=2" ;;
						contrib-src) branches="${branches}&ub_src[]=2" ;;
						contrib-all) branches="${branches}&ub[]=2&ub_src[]=2" ;;

						non-free) branches="${branches}&ub[]=3" ;;
						non-free-src) branches="${branches}&ub_src[]=3" ;;
						non-free-all) branches="${branches}&ub[]=3&ub_src[]=3" ;;
						security) branches="${branches}&uu[]=1" ;;
						security-src) branches="${branches}&uu_src[]=1" ;;
						security-all) branches="${branches}&uu[]=1&uu_src[]=1" ;;

						updates) branches="${branches}&uu[]=2" ;;
						updates-src) branches="${branches}&uu_src[]=2" ;;
						updates-all) branches="${branches}&uu[]=2&uu_src[]=2" ;;
					esac
					shift

					# Se o proximo parametro for uma opção, sai do loop
					if [ "${2#-}" != "$2"  ]
					then
						break
					fi
				done
			;;
		esac
		shift
	done

	# Todos os parametros foram utilizados corretamente?
	if [ "$#" != 0 ]
	then
		zzecho -N -l vermelho "Erro nos parametros."
		zztool uso debgen
		return 1
	fi

	# Montando o as variáveis que serão passadas pelo metodo POST
	post="country=${country}&release=${release}&${branches}"

	# Enviando as variáveis...
	echo "$post" |

	# ... para o site criar o source.list...
	$ZZWWWPOST $url |

	# ... e liimpando o retorno do site.
	sed '	s/^ *//g
		s/_//g
		/maintained/d
		/analytics/d
		/^$/d
		/#DebGen/d
		/Debian Sources/d
		/Home |/d
		s/Getting/\nGetting/ 
		s/Alternate/\nAlternate/
		s/:$/:\n/
		s/here/here\n/'
}
