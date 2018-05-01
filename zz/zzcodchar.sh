# ----------------------------------------------------------------------------
# Codifica caracteres como entidades HTML e XML (&lt; &#62; ...).
# Entende entidades (&gt;), códigos decimais (&#62;) e hexadecimais (&#x3E;).
#
# Opções: --html/--xml  Codifica caracteres em códigos HTML/XML
#         --hex         Codifica caracteres em códigos hexadecimais
#         --dec         Codifica caracteres em códigos decimais
#         -s            Com essa opção também codifica os espaços
#         --listar      Mostra a listagem completa de codificação
#                       Ou só a listagem da codificação escolhida
#
# Uso: zzcodchar [-s] [--listar cod] [--html|--xml|--dec|--hex] [arquivo(s)]
# Ex.: zzcodchar --html arquivo.xml
#      zzcodchar --hex  arquivo.html
#      cat arquivo.html | zzcodchar --dec
#      zzcodchar --listar html     #  Listagem dos caracteres e códigos html
#
# Autor: Itamar <itamarnet (a) yahoo com br>
# Desde: 2015-12-07
# Versão: 3
# Licença: GPL
# Requisitos: zztrim zzpad
# Tags: texto, conversão
# ----------------------------------------------------------------------------
zzcodchar ()
{
	zzzz -h codchar "$1" && return

	local cods codspace codsed
	local char html hex dec

	codspace="s/ /\&	nbsp	#xA0	#160	;/g;"

	cods="s/&/\&	amp	#x26	#38	;/g;
s/\"/\&	quot	#x22	#34	;/g;
s/'/\&	apos	#x27	#39	;/g;
s/</\&	lt	#x3C	#60	;/g;
s/>/\&	gt	#x3E	#62	;/g;
s/¡/\&	iexcl	#xA1	#161	;/g;
s/¢/\&	cent	#xA2	#162	;/g;
s/£/\&	pound	#xA3	#163	;/g;
s/¤/\&	curren	#xA4	#164	;/g;
s/¥/\&	yen	#xA5	#165	;/g;
s/¦/\&	brvbar	#xA6	#166	;/g;
s/§/\&	sect	#xA7	#167	;/g;
s/¨/\&	uml	#xA8	#168	;/g;
s/©/\&	copy	#xA9	#169	;/g;
s/ª/\&	ordf	#xAA	#170	;/g;
s/«/\&	laquo	#xAB	#171	;/g;
s/¬/\&	not	#xAC	#172	;/g;
s/­/\&	shy	#xAD	#173	;/g;
s/®/\&	reg	#xAE	#174	;/g;
s/¯/\&	macr	#xAF	#175	;/g;
s/°/\&	deg	#xB0	#176	;/g;
s/±/\&	plusmn	#xB1	#177	;/g;
s/²/\&	sup2	#xB2	#178	;/g;
s/³/\&	sup3	#xB3	#179	;/g;
s/´/\&	acute	#xB4	#180	;/g;
s/µ/\&	micro	#xB5	#181	;/g;
s/¶/\&	para	#xB6	#182	;/g;
s/·/\&	middot	#xB7	#183	;/g;
s/¸/\&	cedil	#xB8	#184	;/g;
s/¹/\&	sup1	#xB9	#185	;/g;
s/º/\&	ordm	#xBA	#186	;/g;
s/»/\&	raquo	#xBB	#187	;/g;
s/¼/\&	frac14	#xBC	#188	;/g;
s/½/\&	frac12	#xBD	#189	;/g;
s/¾/\&	frac34	#xBE	#190	;/g;
s/¿/\&	iquest	#xBF	#191	;/g;
s/À/\&	Agrave	#xC0	#192	;/g;
s/Á/\&	Aacute	#xC1	#193	;/g;
s/Â/\&	Acirc	#xC2	#194	;/g;
s/Ã/\&	Atilde	#xC3	#195	;/g;
s/Ä/\&	Auml	#xC4	#196	;/g;
s/Å/\&	Aring	#xC5	#197	;/g;
s/Æ/\&	AElig	#xC6	#198	;/g;
s/Ç/\&	Ccedil	#xC7	#199	;/g;
s/È/\&	Egrave	#xC8	#200	;/g;
s/É/\&	Eacute	#xC9	#201	;/g;
s/Ê/\&	Ecirc	#xCA	#202	;/g;
s/Ë/\&	Euml	#xCB	#203	;/g;
s/Ì/\&	Igrave	#xCC	#204	;/g;
s/Í/\&	Iacute	#xCD	#205	;/g;
s/Î/\&	Icirc	#xCE	#206	;/g;
s/Ï/\&	Iuml	#xCF	#207	;/g;
s/Ð/\&	ETH	#xD0	#208	;/g;
s/Ñ/\&	Ntilde	#xD1	#209	;/g;
s/Ò/\&	Ograve	#xD2	#210	;/g;
s/Ó/\&	Oacute	#xD3	#211	;/g;
s/Ô/\&	Ocirc	#xD4	#212	;/g;
s/Õ/\&	Otilde	#xD5	#213	;/g;
s/Ö/\&	Ouml	#xD6	#214	;/g;
s/×/\&	times	#xD7	#215	;/g;
s/Ø/\&	Oslash	#xD8	#216	;/g;
s/Ù/\&	Ugrave	#xD9	#217	;/g;
s/Ú/\&	Uacute	#xDA	#218	;/g;
s/Û/\&	Ucirc	#xDB	#219	;/g;
s/Ü/\&	Uuml	#xDC	#220	;/g;
s/Ý/\&	Yacute	#xDD	#221	;/g;
s/Þ/\&	THORN	#xDE	#222	;/g;
s/ß/\&	szlig	#xDF	#223	;/g;
s/à/\&	agrave	#xE0	#224	;/g;
s/á/\&	aacute	#xE1	#225	;/g;
s/â/\&	acirc	#xE2	#226	;/g;
s/ã/\&	atilde	#xE3	#227	;/g;
s/ä/\&	auml	#xE4	#228	;/g;
s/å/\&	aring	#xE5	#229	;/g;
s/æ/\&	aelig	#xE6	#230	;/g;
s/ç/\&	ccedil	#xE7	#231	;/g;
s/è/\&	egrave	#xE8	#232	;/g;
s/é/\&	eacute	#xE9	#233	;/g;
s/ê/\&	ecirc	#xEA	#234	;/g;
s/ë/\&	euml	#xEB	#235	;/g;
s/ì/\&	igrave	#xEC	#236	;/g;
s/í/\&	iacute	#xED	#237	;/g;
s/î/\&	icirc	#xEE	#238	;/g;
s/ï/\&	iuml	#xEF	#239	;/g;
s/ð/\&	eth	#xF0	#240	;/g;
s/ñ/\&	ntilde	#xF1	#241	;/g;
s/ò/\&	ograve	#xF2	#242	;/g;
s/ó/\&	oacute	#xF3	#243	;/g;
s/ô/\&	ocirc	#xF4	#244	;/g;
s/õ/\&	otilde	#xF5	#245	;/g;
s/ö/\&	ouml	#xF6	#246	;/g;
s/÷/\&	divide	#xF7	#247	;/g;
s/ø/\&	oslash	#xF8	#248	;/g;
s/ù/\&	ugrave	#xF9	#249	;/g;
s/ú/\&	uacute	#xFA	#250	;/g;
s/û/\&	ucirc	#xFB	#251	;/g;
s/ü/\&	uuml	#xFC	#252	;/g;
s/ý/\&	yacute	#xFD	#253	;/g;
s/þ/\&	thorn	#xFE	#254	;/g;
s/ÿ/\&	yuml	#xFF	#255	;/g;
s/Œ/\&	OElig	#x152	#338	;/g;
s/œ/\&	oelig	#x153	#339	;/g;
s/Š/\&	Scaron	#x160	#352	;/g;
s/š/\&	scaron	#x161	#353	;/g;
s/Ÿ/\&	Yuml	#x178	#376	;/g;
s/ƒ/\&	fnof	#x192	#402	;/g;
s/ˆ/\&	circ	#x2C6	#710	;/g;
s/˜/\&	tilde	#x2DC	#732	;/g;
s/Α/\&	Alpha	#x391	#913	;/g;
s/Β/\&	Beta	#x392	#914	;/g;
s/Γ/\&	Gamma	#x393	#915	;/g;
s/Δ/\&	Delta	#x394	#916	;/g;
s/Ε/\&	Epsilon	#x395	#917	;/g;
s/Ζ/\&	Zeta	#x396	#918	;/g;
s/Η/\&	Eta	#x397	#919	;/g;
s/Θ/\&	Theta	#x398	#920	;/g;
s/Ι/\&	Iota	#x399	#921	;/g;
s/Κ/\&	Kappa	#x39A	#922	;/g;
s/Λ/\&	Lambda	#x39B	#923	;/g;
s/Μ/\&	Mu	#x39C	#924	;/g;
s/Ν/\&	Nu	#x39D	#925	;/g;
s/Ξ/\&	Xi	#x39E	#926	;/g;
s/Ο/\&	Omicron	#x39F	#927	;/g;
s/Π/\&	Pi	#x3A0	#928	;/g;
s/Ρ/\&	Rho	#x3A1	#929	;/g;
s/Σ/\&	Sigma	#x3A3	#931	;/g;
s/Τ/\&	Tau	#x3A4	#932	;/g;
s/Υ/\&	Upsilon	#x3A5	#933	;/g;
s/Φ/\&	Phi	#x3A6	#934	;/g;
s/Χ/\&	Chi	#x3A7	#935	;/g;
s/Ψ/\&	Psi	#x3A8	#936	;/g;
s/Ω/\&	Omega	#x3A9	#937	;/g;
s/α/\&	alpha	#x3B1	#945	;/g;
s/β/\&	beta	#x3B2	#946	;/g;
s/γ/\&	gamma	#x3B3	#947	;/g;
s/δ/\&	delta	#x3B4	#948	;/g;
s/ε/\&	epsilon	#x3B5	#949	;/g;
s/ζ/\&	zeta	#x3B6	#950	;/g;
s/η/\&	eta	#x3B7	#951	;/g;
s/θ/\&	theta	#x3B8	#952	;/g;
s/ι/\&	iota	#x3B9	#953	;/g;
s/κ/\&	kappa	#x3BA	#954	;/g;
s/λ/\&	lambda	#x3BB	#955	;/g;
s/μ/\&	mu	#x3BC	#956	;/g;
s/ν/\&	nu	#x3BD	#957	;/g;
s/ξ/\&	xi	#x3BE	#958	;/g;
s/ο/\&	omicron	#x3BF	#959	;/g;
s/π/\&	pi	#x3C0	#960	;/g;
s/ρ/\&	rho	#x3C1	#961	;/g;
s/ς/\&	sigmaf	#x3C2	#962	;/g;
s/σ/\&	sigma	#x3C3	#963	;/g;
s/τ/\&	tau	#x3C4	#964	;/g;
s/υ/\&	upsilon	#x3C5	#965	;/g;
s/φ/\&	phi	#x3C6	#966	;/g;
s/χ/\&	chi	#x3C7	#967	;/g;
s/ψ/\&	psi	#x3C8	#968	;/g;
s/ω/\&	omega	#x3C9	#969	;/g;
s/ϑ/\&	thetasym	#x3D1	#977	;/g;
s/ϒ/\&	upsih	#x3D2	#978	;/g;
s/ϖ/\&	piv	#x3D6	#982	;/g;
s/ /\&	ensp	#x2002	#8194	;/g;
s/ /\&	emsp	#x2003	#8195	;/g;
s/ /\&	thinsp	#x2009	#8201	;/g;
s/‌/\&	zwnj	#x200C	#8204	;/g;
s/‍/\&	zwj	#x200D	#8205	;/g;
s/‎/\&	lrm	#x200E	#8206	;/g;
s/‏/\&	rlm	#x200F	#8207	;/g;
s/–/\&	ndash	#x2013	#8211	;/g;
s/—/\&	mdash	#x2014	#8212	;/g;
s/‘/\&	lsquo	#x2018	#8216	;/g;
s/’/\&	rsquo	#x2019	#8217	;/g;
s/‚/\&	sbquo	#x201A	#8218	;/g;
s/“/\&	ldquo	#x201C	#8220	;/g;
s/”/\&	rdquo	#x201D	#8221	;/g;
s/„/\&	bdquo	#x201E	#8222	;/g;
s/†/\&	dagger	#x2020	#8224	;/g;
s/‡/\&	Dagger	#x2021	#8225	;/g;
s/•/\&	bull	#x2022	#8226	;/g;
s/…/\&	hellip	#x2026	#8230	;/g;
s/‰/\&	permil	#x2030	#8240	;/g;
s/′/\&	prime	#x2032	#8242	;/g;
s/″/\&	Prime	#x2033	#8243	;/g;
s/‹/\&	lsaquo	#x2039	#8249	;/g;
s/›/\&	rsaquo	#x203A	#8250	;/g;
s/‾/\&	oline	#x203E	#8254	;/g;
s/⁄/\&	frasl	#x2044	#8260	;/g;
s/€/\&	euro	#x20AC	#8364	;/g;
s/ℑ/\&	image	#x2111	#8465	;/g;
s/℘/\&	weierp	#x2118	#8472	;/g;
s/ℜ/\&	real	#x211C	#8476	;/g;
s/™/\&	trade	#x2122	#8482	;/g;
s/ℵ/\&	alefsym	#x2135	#8501	;/g;
s/←/\&	larr	#x2190	#8592	;/g;
s/↑/\&	uarr	#x2191	#8593	;/g;
s/→/\&	rarr	#x2192	#8594	;/g;
s/↓/\&	darr	#x2193	#8595	;/g;
s/↔/\&	harr	#x2194	#8596	;/g;
s/↵/\&	crarr	#x21B5	#8629	;/g;
s/⇐/\&	lArr	#x21D0	#8656	;/g;
s/⇑/\&	uArr	#x21D1	#8657	;/g;
s/⇒/\&	rArr	#x21D2	#8658	;/g;
s/⇓/\&	dArr	#x21D3	#8659	;/g;
s/⇔/\&	hArr	#x21D4	#8660	;/g;
s/∀/\&	forall	#x2200	#8704	;/g;
s/∂/\&	part	#x2202	#8706	;/g;
s/∃/\&	exist	#x2203	#8707	;/g;
s/∅/\&	empty	#x2205	#8709	;/g;
s/∇/\&	nabla	#x2207	#8711	;/g;
s/∈/\&	isin	#x2208	#8712	;/g;
s/∉/\&	notin	#x2209	#8713	;/g;
s/∋/\&	ni	#x220B	#8715	;/g;
s/∏/\&	prod	#x220F	#8719	;/g;
s/∑/\&	sum	#x2211	#8721	;/g;
s/−/\&	minus	#x2212	#8722	;/g;
s/∗/\&	lowast	#x2217	#8727	;/g;
s/√/\&	radic	#x221A	#8730	;/g;
s/∝/\&	prop	#x221D	#8733	;/g;
s/∞/\&	infin	#x221E	#8734	;/g;
s/∠/\&	ang	#x2220	#8736	;/g;
s/∧/\&	and	#x2227	#8743	;/g;
s/∨/\&	or	#x2228	#8744	;/g;
s/∩/\&	cap	#x2229	#8745	;/g;
s/∪/\&	cup	#x222A	#8746	;/g;
s/∫/\&	int	#x222B	#8747	;/g;
s/∴/\&	there4	#x2234	#8756	;/g;
s/∼/\&	sim	#x223C	#8764	;/g;
s/≅/\&	cong	#x2245	#8773	;/g;
s/≈/\&	asymp	#x2248	#8776	;/g;
s/≠/\&	ne	#x2260	#8800	;/g;
s/≡/\&	equiv	#x2261	#8801	;/g;
s/≤/\&	le	#x2264	#8804	;/g;
s/≥/\&	ge	#x2265	#8805	;/g;
s/⊂/\&	sub	#x2282	#8834	;/g;
s/⊃/\&	sup	#x2283	#8835	;/g;
s/⊄/\&	nsub	#x2284	#8836	;/g;
s/⊆/\&	sube	#x2286	#8838	;/g;
s/⊇/\&	supe	#x2287	#8839	;/g;
s/⊕/\&	oplus	#x2295	#8853	;/g;
s/⊗/\&	otimes	#x2297	#8855	;/g;
s/⊥/\&	perp	#x22A5	#8869	;/g;
s/⋅/\&	sdot	#x22C5	#8901	;/g;
s/⌈/\&	lceil	#x2308	#8968	;/g;
s/⌉/\&	rceil	#x2309	#8969	;/g;
s/⌊/\&	lfloor	#x230A	#8970	;/g;
s/⌋/\&	rfloor	#x230B	#8971	;/g;
s/〈/\&	lang	#x27E8	#10216	;/g;
s/〉/\&	rang	#x27E9	#10217	;/g;
s/◊/\&	loz	#x25CA	#9674	;/g;
s/♠/\&	spades	#x2660	#9824	;/g;
s/♣/\&	clubs	#x2663	#9827	;/g;
s/♥/\&	hearts	#x2665	#9829	;/g;
s/♦/\&	diams	#x2666	#9830	;/g;
"

	# Opções de linha de comando
	while test "${1#-}" != "$1"
	do
		case "$1" in
			-s) cods="$cods$codspace";shift;;
			--html|--xml)
				codsed=$(echo "$cods" | awk 'BEGIN {FS="\t"};{print $1 $2 $5}');
				shift
			;;
			--hex)
				codsed=$(echo "$cods" | awk 'BEGIN {FS="\t"};{print $1 $3 $5}');
				shift
			;;
			--dec)
				codsed=$(echo "$cods" | awk 'BEGIN {FS="\t"};{print $1 $4 $5}');
				shift
			;;
			--listar)
				printf '%s' 'char'
				case $2 in
				html|xml|hex|dec) printf '\t%b\n' "$2";;
				*) printf '%b' ' html        hex         dec\n';;
				esac
				echo "$cods" |
				zztrim |
				sed 's|s/||; s|	;/g;||; s|/\\&||; ${ s| |"&"|; }' |
				case $2 in
				html|xml) sed 's/	/	\&/;s/	#.*/;/;$s/" "/ /';;
				hex)      sed 's/	.*#x/	\&#x/;s/	[#0-9]*$/;/;$s/" "/ /';;
				dec)      sed 's/	.*	/	\&/;s/$/;/;$s/" "/ /';;
				*)
					sed 's/	/	\&/g;s/	/;	/2g;s/$/;/' |
					while read char html hex dec
					do
						echo "$(zzpad 4 $char) $(zzpad 11 $html) $(zzpad 11 $hex) $dec"
					done |
					sed '$s/"  *"  */     /;s/;	&/;      \&/'
				esac
				return
			;;
			*) break ;;
		esac
	done

	# Faz a conversão
	# Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" | sed "$codsed"
}
