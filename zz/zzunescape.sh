# ----------------------------------------------------------------------------
# Restaura caracteres codificados como entidades HTML e XML (&lt; &#62; ...).
# Entende entidades (&gt;), códigos decimais (&#62;) e hexadecimais (&#x3E;).
#
# Opções: --html  Restaura caracteres HTML
#         --xml   Restaura caracteres XML
#
# Uso: zzunescape [--html] [--xml] [arquivo(s)]
# Ex.: zzunescape --xml arquivo.xml
#      zzunescape --html arquivo.html
#      cat arquivo.html | zzunescape --html
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-03
# Versão: 2
# Licença: GPL
# ----------------------------------------------------------------------------
zzunescape ()
{
	zzzz -h unescape "$1" && return

	local xml html
	local filtro=''

	# http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
	xml="
		s/&#0*34;/\"/g;     s/&#x0*22;/\"/g;    s/&quot;/\"/g;
		s/&#0*38;/\&/g;     s/&#x0*26;/\&/g;    s/&amp;/\&/g;
		s/&#0*39;/'/g;      s/&#x0*27;/'/g;     s/&apos;/'/g;
		s/&#0*60;/</g;      s/&#x0*3C;/</g;     s/&lt;/</g;
		s/&#0*62;/>/g;      s/&#x0*3E;/>/g;     s/&gt;/>/g;
	"

	# http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
	## pattern: ^(.*)\t(.*)\tU\+0*(\w+) \((\d+)\)\t.*$
	## replace: s/&#0*$4;/$2/g;\ts/&#x0*$3;/$2/g;\ts/&$1;/$2/g;
	## expand -t 20
	## Escapar na mão: \& e \"
	html="
		s/&#0*34;/\"/g;     s/&#x0*22;/\"/g;    s/&quot;/\"/g;
		s/&#0*38;/\&/g;     s/&#x0*26;/\&/g;    s/&amp;/\&/g;
		s/&#0*39;/'/g;      s/&#x0*27;/'/g;     s/&apos;/'/g;
		s/&#0*60;/</g;      s/&#x0*3C;/</g;     s/&lt;/</g;
		s/&#0*62;/>/g;      s/&#x0*3E;/>/g;     s/&gt;/>/g;
		s/&#0*160;/ /g;     s/&#x0*A0;/ /g;     s/&nbsp;/ /g;
		s/&#0*161;/¡/g;     s/&#x0*A1;/¡/g;     s/&iexcl;/¡/g;
		s/&#0*162;/¢/g;     s/&#x0*A2;/¢/g;     s/&cent;/¢/g;
		s/&#0*163;/£/g;     s/&#x0*A3;/£/g;     s/&pound;/£/g;
		s/&#0*164;/¤/g;     s/&#x0*A4;/¤/g;     s/&curren;/¤/g;
		s/&#0*165;/¥/g;     s/&#x0*A5;/¥/g;     s/&yen;/¥/g;
		s/&#0*166;/¦/g;     s/&#x0*A6;/¦/g;     s/&brvbar;/¦/g;
		s/&#0*167;/§/g;     s/&#x0*A7;/§/g;     s/&sect;/§/g;
		s/&#0*168;/¨/g;     s/&#x0*A8;/¨/g;     s/&uml;/¨/g;
		s/&#0*169;/©/g;     s/&#x0*A9;/©/g;     s/&copy;/©/g;
		s/&#0*170;/ª/g;     s/&#x0*AA;/ª/g;     s/&ordf;/ª/g;
		s/&#0*171;/«/g;     s/&#x0*AB;/«/g;     s/&laquo;/«/g;
		s/&#0*172;/¬/g;     s/&#x0*AC;/¬/g;     s/&not;/¬/g;
		s/&#0*173;/ /g;     s/&#x0*AD;/ /g;     s/&shy;/ /g;
		s/&#0*174;/®/g;     s/&#x0*AE;/®/g;     s/&reg;/®/g;
		s/&#0*175;/¯/g;     s/&#x0*AF;/¯/g;     s/&macr;/¯/g;
		s/&#0*176;/°/g;     s/&#x0*B0;/°/g;     s/&deg;/°/g;
		s/&#0*177;/±/g;     s/&#x0*B1;/±/g;     s/&plusmn;/±/g;
		s/&#0*178;/²/g;     s/&#x0*B2;/²/g;     s/&sup2;/²/g;
		s/&#0*179;/³/g;     s/&#x0*B3;/³/g;     s/&sup3;/³/g;
		s/&#0*180;/´/g;     s/&#x0*B4;/´/g;     s/&acute;/´/g;
		s/&#0*181;/µ/g;     s/&#x0*B5;/µ/g;     s/&micro;/µ/g;
		s/&#0*182;/¶/g;     s/&#x0*B6;/¶/g;     s/&para;/¶/g;
		s/&#0*183;/·/g;     s/&#x0*B7;/·/g;     s/&middot;/·/g;
		s/&#0*184;/¸/g;     s/&#x0*B8;/¸/g;     s/&cedil;/¸/g;
		s/&#0*185;/¹/g;     s/&#x0*B9;/¹/g;     s/&sup1;/¹/g;
		s/&#0*186;/º/g;     s/&#x0*BA;/º/g;     s/&ordm;/º/g;
		s/&#0*187;/»/g;     s/&#x0*BB;/»/g;     s/&raquo;/»/g;
		s/&#0*188;/¼/g;     s/&#x0*BC;/¼/g;     s/&frac14;/¼/g;
		s/&#0*189;/½/g;     s/&#x0*BD;/½/g;     s/&frac12;/½/g;
		s/&#0*190;/¾/g;     s/&#x0*BE;/¾/g;     s/&frac34;/¾/g;
		s/&#0*191;/¿/g;     s/&#x0*BF;/¿/g;     s/&iquest;/¿/g;
		s/&#0*192;/À/g;     s/&#x0*C0;/À/g;     s/&Agrave;/À/g;
		s/&#0*193;/Á/g;     s/&#x0*C1;/Á/g;     s/&Aacute;/Á/g;
		s/&#0*194;/Â/g;     s/&#x0*C2;/Â/g;     s/&Acirc;/Â/g;
		s/&#0*195;/Ã/g;     s/&#x0*C3;/Ã/g;     s/&Atilde;/Ã/g;
		s/&#0*196;/Ä/g;     s/&#x0*C4;/Ä/g;     s/&Auml;/Ä/g;
		s/&#0*197;/Å/g;     s/&#x0*C5;/Å/g;     s/&Aring;/Å/g;
		s/&#0*198;/Æ/g;     s/&#x0*C6;/Æ/g;     s/&AElig;/Æ/g;
		s/&#0*199;/Ç/g;     s/&#x0*C7;/Ç/g;     s/&Ccedil;/Ç/g;
		s/&#0*200;/È/g;     s/&#x0*C8;/È/g;     s/&Egrave;/È/g;
		s/&#0*201;/É/g;     s/&#x0*C9;/É/g;     s/&Eacute;/É/g;
		s/&#0*202;/Ê/g;     s/&#x0*CA;/Ê/g;     s/&Ecirc;/Ê/g;
		s/&#0*203;/Ë/g;     s/&#x0*CB;/Ë/g;     s/&Euml;/Ë/g;
		s/&#0*204;/Ì/g;     s/&#x0*CC;/Ì/g;     s/&Igrave;/Ì/g;
		s/&#0*205;/Í/g;     s/&#x0*CD;/Í/g;     s/&Iacute;/Í/g;
		s/&#0*206;/Î/g;     s/&#x0*CE;/Î/g;     s/&Icirc;/Î/g;
		s/&#0*207;/Ï/g;     s/&#x0*CF;/Ï/g;     s/&Iuml;/Ï/g;
		s/&#0*208;/Ð/g;     s/&#x0*D0;/Ð/g;     s/&ETH;/Ð/g;
		s/&#0*209;/Ñ/g;     s/&#x0*D1;/Ñ/g;     s/&Ntilde;/Ñ/g;
		s/&#0*210;/Ò/g;     s/&#x0*D2;/Ò/g;     s/&Ograve;/Ò/g;
		s/&#0*211;/Ó/g;     s/&#x0*D3;/Ó/g;     s/&Oacute;/Ó/g;
		s/&#0*212;/Ô/g;     s/&#x0*D4;/Ô/g;     s/&Ocirc;/Ô/g;
		s/&#0*213;/Õ/g;     s/&#x0*D5;/Õ/g;     s/&Otilde;/Õ/g;
		s/&#0*214;/Ö/g;     s/&#x0*D6;/Ö/g;     s/&Ouml;/Ö/g;
		s/&#0*215;/×/g;     s/&#x0*D7;/×/g;     s/&times;/×/g;
		s/&#0*216;/Ø/g;     s/&#x0*D8;/Ø/g;     s/&Oslash;/Ø/g;
		s/&#0*217;/Ù/g;     s/&#x0*D9;/Ù/g;     s/&Ugrave;/Ù/g;
		s/&#0*218;/Ú/g;     s/&#x0*DA;/Ú/g;     s/&Uacute;/Ú/g;
		s/&#0*219;/Û/g;     s/&#x0*DB;/Û/g;     s/&Ucirc;/Û/g;
		s/&#0*220;/Ü/g;     s/&#x0*DC;/Ü/g;     s/&Uuml;/Ü/g;
		s/&#0*221;/Ý/g;     s/&#x0*DD;/Ý/g;     s/&Yacute;/Ý/g;
		s/&#0*222;/Þ/g;     s/&#x0*DE;/Þ/g;     s/&THORN;/Þ/g;
		s/&#0*223;/ß/g;     s/&#x0*DF;/ß/g;     s/&szlig;/ß/g;
		s/&#0*224;/à/g;     s/&#x0*E0;/à/g;     s/&agrave;/à/g;
		s/&#0*225;/á/g;     s/&#x0*E1;/á/g;     s/&aacute;/á/g;
		s/&#0*226;/â/g;     s/&#x0*E2;/â/g;     s/&acirc;/â/g;
		s/&#0*227;/ã/g;     s/&#x0*E3;/ã/g;     s/&atilde;/ã/g;
		s/&#0*228;/ä/g;     s/&#x0*E4;/ä/g;     s/&auml;/ä/g;
		s/&#0*229;/å/g;     s/&#x0*E5;/å/g;     s/&aring;/å/g;
		s/&#0*230;/æ/g;     s/&#x0*E6;/æ/g;     s/&aelig;/æ/g;
		s/&#0*231;/ç/g;     s/&#x0*E7;/ç/g;     s/&ccedil;/ç/g;
		s/&#0*232;/è/g;     s/&#x0*E8;/è/g;     s/&egrave;/è/g;
		s/&#0*233;/é/g;     s/&#x0*E9;/é/g;     s/&eacute;/é/g;
		s/&#0*234;/ê/g;     s/&#x0*EA;/ê/g;     s/&ecirc;/ê/g;
		s/&#0*235;/ë/g;     s/&#x0*EB;/ë/g;     s/&euml;/ë/g;
		s/&#0*236;/ì/g;     s/&#x0*EC;/ì/g;     s/&igrave;/ì/g;
		s/&#0*237;/í/g;     s/&#x0*ED;/í/g;     s/&iacute;/í/g;
		s/&#0*238;/î/g;     s/&#x0*EE;/î/g;     s/&icirc;/î/g;
		s/&#0*239;/ï/g;     s/&#x0*EF;/ï/g;     s/&iuml;/ï/g;
		s/&#0*240;/ð/g;     s/&#x0*F0;/ð/g;     s/&eth;/ð/g;
		s/&#0*241;/ñ/g;     s/&#x0*F1;/ñ/g;     s/&ntilde;/ñ/g;
		s/&#0*242;/ò/g;     s/&#x0*F2;/ò/g;     s/&ograve;/ò/g;
		s/&#0*243;/ó/g;     s/&#x0*F3;/ó/g;     s/&oacute;/ó/g;
		s/&#0*244;/ô/g;     s/&#x0*F4;/ô/g;     s/&ocirc;/ô/g;
		s/&#0*245;/õ/g;     s/&#x0*F5;/õ/g;     s/&otilde;/õ/g;
		s/&#0*246;/ö/g;     s/&#x0*F6;/ö/g;     s/&ouml;/ö/g;
		s/&#0*247;/÷/g;     s/&#x0*F7;/÷/g;     s/&divide;/÷/g;
		s/&#0*248;/ø/g;     s/&#x0*F8;/ø/g;     s/&oslash;/ø/g;
		s/&#0*249;/ù/g;     s/&#x0*F9;/ù/g;     s/&ugrave;/ù/g;
		s/&#0*250;/ú/g;     s/&#x0*FA;/ú/g;     s/&uacute;/ú/g;
		s/&#0*251;/û/g;     s/&#x0*FB;/û/g;     s/&ucirc;/û/g;
		s/&#0*252;/ü/g;     s/&#x0*FC;/ü/g;     s/&uuml;/ü/g;
		s/&#0*253;/ý/g;     s/&#x0*FD;/ý/g;     s/&yacute;/ý/g;
		s/&#0*254;/þ/g;     s/&#x0*FE;/þ/g;     s/&thorn;/þ/g;
		s/&#0*255;/ÿ/g;     s/&#x0*FF;/ÿ/g;     s/&yuml;/ÿ/g;
		s/&#0*338;/Œ/g;     s/&#x0*152;/Œ/g;    s/&OElig;/Œ/g;
		s/&#0*339;/œ/g;     s/&#x0*153;/œ/g;    s/&oelig;/œ/g;
		s/&#0*352;/Š/g;     s/&#x0*160;/Š/g;    s/&Scaron;/Š/g;
		s/&#0*353;/š/g;     s/&#x0*161;/š/g;    s/&scaron;/š/g;
		s/&#0*376;/Ÿ/g;     s/&#x0*178;/Ÿ/g;    s/&Yuml;/Ÿ/g;
		s/&#0*402;/ƒ/g;     s/&#x0*192;/ƒ/g;    s/&fnof;/ƒ/g;
		s/&#0*710;/ˆ/g;     s/&#x0*2C6;/ˆ/g;    s/&circ;/ˆ/g;
		s/&#0*732;/˜/g;     s/&#x0*2DC;/˜/g;    s/&tilde;/˜/g;
		s/&#0*913;/Α/g;     s/&#x0*391;/Α/g;    s/&Alpha;/Α/g;
		s/&#0*914;/Β/g;     s/&#x0*392;/Β/g;    s/&Beta;/Β/g;
		s/&#0*915;/Γ/g;     s/&#x0*393;/Γ/g;    s/&Gamma;/Γ/g;
		s/&#0*916;/Δ/g;     s/&#x0*394;/Δ/g;    s/&Delta;/Δ/g;
		s/&#0*917;/Ε/g;     s/&#x0*395;/Ε/g;    s/&Epsilon;/Ε/g;
		s/&#0*918;/Ζ/g;     s/&#x0*396;/Ζ/g;    s/&Zeta;/Ζ/g;
		s/&#0*919;/Η/g;     s/&#x0*397;/Η/g;    s/&Eta;/Η/g;
		s/&#0*920;/Θ/g;     s/&#x0*398;/Θ/g;    s/&Theta;/Θ/g;
		s/&#0*921;/Ι/g;     s/&#x0*399;/Ι/g;    s/&Iota;/Ι/g;
		s/&#0*922;/Κ/g;     s/&#x0*39A;/Κ/g;    s/&Kappa;/Κ/g;
		s/&#0*923;/Λ/g;     s/&#x0*39B;/Λ/g;    s/&Lambda;/Λ/g;
		s/&#0*924;/Μ/g;     s/&#x0*39C;/Μ/g;    s/&Mu;/Μ/g;
		s/&#0*925;/Ν/g;     s/&#x0*39D;/Ν/g;    s/&Nu;/Ν/g;
		s/&#0*926;/Ξ/g;     s/&#x0*39E;/Ξ/g;    s/&Xi;/Ξ/g;
		s/&#0*927;/Ο/g;     s/&#x0*39F;/Ο/g;    s/&Omicron;/Ο/g;
		s/&#0*928;/Π/g;     s/&#x0*3A0;/Π/g;    s/&Pi;/Π/g;
		s/&#0*929;/Ρ/g;     s/&#x0*3A1;/Ρ/g;    s/&Rho;/Ρ/g;
		s/&#0*931;/Σ/g;     s/&#x0*3A3;/Σ/g;    s/&Sigma;/Σ/g;
		s/&#0*932;/Τ/g;     s/&#x0*3A4;/Τ/g;    s/&Tau;/Τ/g;
		s/&#0*933;/Υ/g;     s/&#x0*3A5;/Υ/g;    s/&Upsilon;/Υ/g;
		s/&#0*934;/Φ/g;     s/&#x0*3A6;/Φ/g;    s/&Phi;/Φ/g;
		s/&#0*935;/Χ/g;     s/&#x0*3A7;/Χ/g;    s/&Chi;/Χ/g;
		s/&#0*936;/Ψ/g;     s/&#x0*3A8;/Ψ/g;    s/&Psi;/Ψ/g;
		s/&#0*937;/Ω/g;     s/&#x0*3A9;/Ω/g;    s/&Omega;/Ω/g;
		s/&#0*945;/α/g;     s/&#x0*3B1;/α/g;    s/&alpha;/α/g;
		s/&#0*946;/β/g;     s/&#x0*3B2;/β/g;    s/&beta;/β/g;
		s/&#0*947;/γ/g;     s/&#x0*3B3;/γ/g;    s/&gamma;/γ/g;
		s/&#0*948;/δ/g;     s/&#x0*3B4;/δ/g;    s/&delta;/δ/g;
		s/&#0*949;/ε/g;     s/&#x0*3B5;/ε/g;    s/&epsilon;/ε/g;
		s/&#0*950;/ζ/g;     s/&#x0*3B6;/ζ/g;    s/&zeta;/ζ/g;
		s/&#0*951;/η/g;     s/&#x0*3B7;/η/g;    s/&eta;/η/g;
		s/&#0*952;/θ/g;     s/&#x0*3B8;/θ/g;    s/&theta;/θ/g;
		s/&#0*953;/ι/g;     s/&#x0*3B9;/ι/g;    s/&iota;/ι/g;
		s/&#0*954;/κ/g;     s/&#x0*3BA;/κ/g;    s/&kappa;/κ/g;
		s/&#0*955;/λ/g;     s/&#x0*3BB;/λ/g;    s/&lambda;/λ/g;
		s/&#0*956;/μ/g;     s/&#x0*3BC;/μ/g;    s/&mu;/μ/g;
		s/&#0*957;/ν/g;     s/&#x0*3BD;/ν/g;    s/&nu;/ν/g;
		s/&#0*958;/ξ/g;     s/&#x0*3BE;/ξ/g;    s/&xi;/ξ/g;
		s/&#0*959;/ο/g;     s/&#x0*3BF;/ο/g;    s/&omicron;/ο/g;
		s/&#0*960;/π/g;     s/&#x0*3C0;/π/g;    s/&pi;/π/g;
		s/&#0*961;/ρ/g;     s/&#x0*3C1;/ρ/g;    s/&rho;/ρ/g;
		s/&#0*962;/ς/g;     s/&#x0*3C2;/ς/g;    s/&sigmaf;/ς/g;
		s/&#0*963;/σ/g;     s/&#x0*3C3;/σ/g;    s/&sigma;/σ/g;
		s/&#0*964;/τ/g;     s/&#x0*3C4;/τ/g;    s/&tau;/τ/g;
		s/&#0*965;/υ/g;     s/&#x0*3C5;/υ/g;    s/&upsilon;/υ/g;
		s/&#0*966;/φ/g;     s/&#x0*3C6;/φ/g;    s/&phi;/φ/g;
		s/&#0*967;/χ/g;     s/&#x0*3C7;/χ/g;    s/&chi;/χ/g;
		s/&#0*968;/ψ/g;     s/&#x0*3C8;/ψ/g;    s/&psi;/ψ/g;
		s/&#0*969;/ω/g;     s/&#x0*3C9;/ω/g;    s/&omega;/ω/g;
		s/&#0*977;/ϑ/g;     s/&#x0*3D1;/ϑ/g;    s/&thetasym;/ϑ/g;
		s/&#0*978;/ϒ/g;     s/&#x0*3D2;/ϒ/g;    s/&upsih;/ϒ/g;
		s/&#0*982;/ϖ/g;     s/&#x0*3D6;/ϖ/g;    s/&piv;/ϖ/g;
		s/&#0*8194;/ /g;    s/&#x0*2002;/ /g;   s/&ensp;/ /g;
		s/&#0*8195;/ /g;    s/&#x0*2003;/ /g;   s/&emsp;/ /g;
		s/&#0*8201;/ /g;    s/&#x0*2009;/ /g;   s/&thinsp;/ /g;
		s/&#0*8204;/ /g;    s/&#x0*200C;/ /g;   s/&zwnj;/ /g;
		s/&#0*8205;/ /g;    s/&#x0*200D;/ /g;   s/&zwj;/ /g;
		s/&#0*8206;/ /g;    s/&#x0*200E;/ /g;   s/&lrm;/ /g;
		s/&#0*8207;/ /g;    s/&#x0*200F;/ /g;   s/&rlm;/ /g;
		s/&#0*8211;/–/g;    s/&#x0*2013;/–/g;   s/&ndash;/–/g;
		s/&#0*8212;/—/g;    s/&#x0*2014;/—/g;   s/&mdash;/—/g;
		s/&#0*8216;/‘/g;    s/&#x0*2018;/‘/g;   s/&lsquo;/‘/g;
		s/&#0*8217;/’/g;    s/&#x0*2019;/’/g;   s/&rsquo;/’/g;
		s/&#0*8218;/‚/g;    s/&#x0*201A;/‚/g;   s/&sbquo;/‚/g;
		s/&#0*8220;/“/g;    s/&#x0*201C;/“/g;   s/&ldquo;/“/g;
		s/&#0*8221;/”/g;    s/&#x0*201D;/”/g;   s/&rdquo;/”/g;
		s/&#0*8222;/„/g;    s/&#x0*201E;/„/g;   s/&bdquo;/„/g;
		s/&#0*8224;/†/g;    s/&#x0*2020;/†/g;   s/&dagger;/†/g;
		s/&#0*8225;/‡/g;    s/&#x0*2021;/‡/g;   s/&Dagger;/‡/g;
		s/&#0*8226;/•/g;    s/&#x0*2022;/•/g;   s/&bull;/•/g;
		s/&#0*8230;/…/g;    s/&#x0*2026;/…/g;   s/&hellip;/…/g;
		s/&#0*8240;/‰/g;    s/&#x0*2030;/‰/g;   s/&permil;/‰/g;
		s/&#0*8242;/′/g;    s/&#x0*2032;/′/g;   s/&prime;/′/g;
		s/&#0*8243;/″/g;    s/&#x0*2033;/″/g;   s/&Prime;/″/g;
		s/&#0*8249;/‹/g;    s/&#x0*2039;/‹/g;   s/&lsaquo;/‹/g;
		s/&#0*8250;/›/g;    s/&#x0*203A;/›/g;   s/&rsaquo;/›/g;
		s/&#0*8254;/‾/g;    s/&#x0*203E;/‾/g;   s/&oline;/‾/g;
		s/&#0*8260;/⁄/g;    s/&#x0*2044;/⁄/g;   s/&frasl;/⁄/g;
		s/&#0*8364;/€/g;    s/&#x0*20AC;/€/g;   s/&euro;/€/g;
		s/&#0*8465;/ℑ/g;    s/&#x0*2111;/ℑ/g;   s/&image;/ℑ/g;
		s/&#0*8472;/℘/g;    s/&#x0*2118;/℘/g;   s/&weierp;/℘/g;
		s/&#0*8476;/ℜ/g;    s/&#x0*211C;/ℜ/g;   s/&real;/ℜ/g;
		s/&#0*8482;/™/g;    s/&#x0*2122;/™/g;   s/&trade;/™/g;
		s/&#0*8501;/ℵ/g;    s/&#x0*2135;/ℵ/g;   s/&alefsym;/ℵ/g;
		s/&#0*8592;/←/g;    s/&#x0*2190;/←/g;   s/&larr;/←/g;
		s/&#0*8593;/↑/g;    s/&#x0*2191;/↑/g;   s/&uarr;/↑/g;
		s/&#0*8594;/→/g;    s/&#x0*2192;/→/g;   s/&rarr;/→/g;
		s/&#0*8595;/↓/g;    s/&#x0*2193;/↓/g;   s/&darr;/↓/g;
		s/&#0*8596;/↔/g;    s/&#x0*2194;/↔/g;   s/&harr;/↔/g;
		s/&#0*8629;/↵/g;    s/&#x0*21B5;/↵/g;   s/&crarr;/↵/g;
		s/&#0*8656;/⇐/g;    s/&#x0*21D0;/⇐/g;   s/&lArr;/⇐/g;
		s/&#0*8657;/⇑/g;    s/&#x0*21D1;/⇑/g;   s/&uArr;/⇑/g;
		s/&#0*8658;/⇒/g;    s/&#x0*21D2;/⇒/g;   s/&rArr;/⇒/g;
		s/&#0*8659;/⇓/g;    s/&#x0*21D3;/⇓/g;   s/&dArr;/⇓/g;
		s/&#0*8660;/⇔/g;    s/&#x0*21D4;/⇔/g;   s/&hArr;/⇔/g;
		s/&#0*8704;/∀/g;    s/&#x0*2200;/∀/g;   s/&forall;/∀/g;
		s/&#0*8706;/∂/g;    s/&#x0*2202;/∂/g;   s/&part;/∂/g;
		s/&#0*8707;/∃/g;    s/&#x0*2203;/∃/g;   s/&exist;/∃/g;
		s/&#0*8709;/∅/g;    s/&#x0*2205;/∅/g;   s/&empty;/∅/g;
		s/&#0*8711;/∇/g;    s/&#x0*2207;/∇/g;   s/&nabla;/∇/g;
		s/&#0*8712;/∈/g;    s/&#x0*2208;/∈/g;   s/&isin;/∈/g;
		s/&#0*8713;/∉/g;    s/&#x0*2209;/∉/g;   s/&notin;/∉/g;
		s/&#0*8715;/∋/g;    s/&#x0*220B;/∋/g;   s/&ni;/∋/g;
		s/&#0*8719;/∏/g;    s/&#x0*220F;/∏/g;   s/&prod;/∏/g;
		s/&#0*8721;/∑/g;    s/&#x0*2211;/∑/g;   s/&sum;/∑/g;
		s/&#0*8722;/−/g;    s/&#x0*2212;/−/g;   s/&minus;/−/g;
		s/&#0*8727;/∗/g;    s/&#x0*2217;/∗/g;   s/&lowast;/∗/g;
		s/&#0*8730;/√/g;    s/&#x0*221A;/√/g;   s/&radic;/√/g;
		s/&#0*8733;/∝/g;    s/&#x0*221D;/∝/g;   s/&prop;/∝/g;
		s/&#0*8734;/∞/g;    s/&#x0*221E;/∞/g;   s/&infin;/∞/g;
		s/&#0*8736;/∠/g;    s/&#x0*2220;/∠/g;   s/&ang;/∠/g;
		s/&#0*8743;/∧/g;    s/&#x0*2227;/∧/g;   s/&and;/∧/g;
		s/&#0*8744;/∨/g;    s/&#x0*2228;/∨/g;   s/&or;/∨/g;
		s/&#0*8745;/∩/g;    s/&#x0*2229;/∩/g;   s/&cap;/∩/g;
		s/&#0*8746;/∪/g;    s/&#x0*222A;/∪/g;   s/&cup;/∪/g;
		s/&#0*8747;/∫/g;    s/&#x0*222B;/∫/g;   s/&int;/∫/g;
		s/&#0*8756;/∴/g;    s/&#x0*2234;/∴/g;   s/&there4;/∴/g;
		s/&#0*8764;/∼/g;    s/&#x0*223C;/∼/g;   s/&sim;/∼/g;
		s/&#0*8773;/≅/g;    s/&#x0*2245;/≅/g;   s/&cong;/≅/g;
		s/&#0*8776;/≈/g;    s/&#x0*2248;/≈/g;   s/&asymp;/≈/g;
		s/&#0*8800;/≠/g;    s/&#x0*2260;/≠/g;   s/&ne;/≠/g;
		s/&#0*8801;/≡/g;    s/&#x0*2261;/≡/g;   s/&equiv;/≡/g;
		s/&#0*8804;/≤/g;    s/&#x0*2264;/≤/g;   s/&le;/≤/g;
		s/&#0*8805;/≥/g;    s/&#x0*2265;/≥/g;   s/&ge;/≥/g;
		s/&#0*8834;/⊂/g;    s/&#x0*2282;/⊂/g;   s/&sub;/⊂/g;
		s/&#0*8835;/⊃/g;    s/&#x0*2283;/⊃/g;   s/&sup;/⊃/g;
		s/&#0*8836;/⊄/g;    s/&#x0*2284;/⊄/g;   s/&nsub;/⊄/g;
		s/&#0*8838;/⊆/g;    s/&#x0*2286;/⊆/g;   s/&sube;/⊆/g;
		s/&#0*8839;/⊇/g;    s/&#x0*2287;/⊇/g;   s/&supe;/⊇/g;
		s/&#0*8853;/⊕/g;    s/&#x0*2295;/⊕/g;   s/&oplus;/⊕/g;
		s/&#0*8855;/⊗/g;    s/&#x0*2297;/⊗/g;   s/&otimes;/⊗/g;
		s/&#0*8869;/⊥/g;    s/&#x0*22A5;/⊥/g;   s/&perp;/⊥/g;
		s/&#0*8901;/⋅/g;    s/&#x0*22C5;/⋅/g;   s/&sdot;/⋅/g;
		s/&#0*8968;/⌈/g;    s/&#x0*2308;/⌈/g;   s/&lceil;/⌈/g;
		s/&#0*8969;/⌉/g;    s/&#x0*2309;/⌉/g;   s/&rceil;/⌉/g;
		s/&#0*8970;/⌊/g;    s/&#x0*230A;/⌊/g;   s/&lfloor;/⌊/g;
		s/&#0*8971;/⌋/g;    s/&#x0*230B;/⌋/g;   s/&rfloor;/⌋/g;
		s/&#0*10216;/〈/g;   s/&#x0*27E8;/〈/g;   s/&lang;/〈/g;
		s/&#0*10217;/〉/g;   s/&#x0*27E9;/〉/g;   s/&rang;/〉/g;
		s/&#0*9674;/◊/g;    s/&#x0*25CA;/◊/g;   s/&loz;/◊/g;
		s/&#0*9824;/♠/g;    s/&#x0*2660;/♠/g;   s/&spades;/♠/g;
		s/&#0*9827;/♣/g;    s/&#x0*2663;/♣/g;   s/&clubs;/♣/g;
		s/&#0*9829;/♥/g;    s/&#x0*2665;/♥/g;   s/&hearts;/♥/g;
		s/&#0*9830;/♦/g;    s/&#x0*2666;/♦/g;   s/&diams;/♦/g;
	"

	# Opções de linha de comando
	while [ "${1#-}" != "$1" ]
	do
		case "$1" in
			--html)
				filtro="$filtro$html";
				shift
			;;
			--xml)
				filtro="$filtro$xml";
				shift
			;;
			*) break ;;
		esac
	done

	# Faz a conversão
	# Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" | sed "$filtro"
}
