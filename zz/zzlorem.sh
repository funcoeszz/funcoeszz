# ----------------------------------------------------------------------------
# Gerador de texto de teste, em latim (Lorem ipsum...).
# Texto obtido em http://br.lipsum.com/
#
# Uso: zzlorem [número-de-palavras]
# Ex.: zzlorem 10
#
# Autor: Angelito M. Goulart, www.angelitomg.com
# Desde: 2012-12-11
# Versão: 3
# Licença: GPL
# ----------------------------------------------------------------------------
zzlorem ()
{

	# Comando especial das funcoes ZZ
	zzzz -h lorem "$1" && return

	# Contador para repetição do texto quando maior que mil
	local contador

	# Conteudo do texto que sera usado pelo script
	local TEXTO="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin euismod blandit pharetra. Vestibulum eu neque eget lorem gravida commodo a cursus massa. Fusce sit amet lorem sem. Donec eu quam leo. Suspendisse consequat risus in ante fringilla sit amet facilisis felis hendrerit. Suspendisse potenti. Pellentesque enim quam, cursus vestibulum porta ac, pharetra vitae ipsum. Sed ullamcorper odio eget diam egestas lacinia. Aenean aliquam tortor quis dolor sollicitudin suscipit. Etiam nec libero vitae magna dignissim molestie. Pellentesque volutpat euismod justo id congue. Proin nibh magna, blandit quis posuere at, sollicitudin nec lectus. Vivamus ut erat erat, in egestas lacus. Vivamus vel nunc elit, ut aliquam nisi.

Vivamus convallis, mi eu consequat scelerisque, lacus lorem elementum quam, vel varius augue lectus sit amet nulla. Integer porta ligula eu risus rhoncus sit amet blandit nulla tincidunt. Nullam fringilla lectus scelerisque elit suscipit venenatis. Donec in ante nec tortor mollis adipiscing. Aliquam id tellus bibendum orci ultricies scelerisque sit amet ut elit. Sed quis turpis molestie tortor consectetur dapibus. Donec hendrerit diam sit amet nibh porta a pellentesque tortor dictum. Curabitur justo libero, rhoncus vitae facilisis nec, vulputate at ipsum. Quisque iaculis diam eget mi tincidunt id sollicitudin diam fermentum.

Vivamus sed orci non nisl elementum adipiscing in et tortor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In hac habitasse platea dictumst. Phasellus a dictum magna. Duis vel erat in lacus tempor fermentum sit amet sed felis. Vestibulum arcu libero, convallis sed euismod sit amet, condimentum in orci. Nulla tempus venenatis justo, et porttitor metus pellentesque ut. Nunc vel turpis a risus mollis tempor. Suspendisse purus risus, pharetra eu tincidunt non, adipiscing vitae libero. Nam ut quam sed metus laoreet sagittis vel non risus. Pellentesque vestibulum vehicula porttitor. Donec aliquet lorem nec ipsum auctor laoreet. Nunc pellentesque ligula sed felis venenatis dictum. Donec ut mauris eget purus ornare rhoncus. Integer pellentesque elementum nisi, at consectetur orci placerat eu.

Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec rutrum fermentum mi, id faucibus libero volutpat id. Suspendisse tristique lobortis ligula quis suscipit. Pellentesque velit tellus, aliquet eu cursus a, blandit ac leo. Proin diam ante, iaculis quis commodo vitae, placerat at lacus. In ipsum nisi, aliquam in aliquet ac, congue a nunc. Fusce ut semper erat. Sed fermentum nulla nec tellus convallis ac vestibulum tortor feugiat. Quisque sed est sem, quis adipiscing ipsum. In non velit nibh. Fusce in libero vitae sem dignissim ultrices ac sed mi. Quisque laoreet ipsum eget metus consequat vestibulum. Quisque ornare accumsan nisl sed eleifend.

Donec lacinia lacus sapien. Nunc condimentum volutpat justo, nec euismod justo varius a. Aliquam mattis faucibus interdum. Suspendisse et lorem at odio fringilla lobortis. Nunc ut purus et tortor dignissim lobortis sit amet quis nisl. Aliquam a nulla in est eleifend imperdiet non eu ipsum. Sed diam neque, vehicula id consequat sit amet, lobortis at orci. Etiam et purus ipsum. Sed aliquam eros nec quam faucibus non faucibus velit sollicitudin. Nam tincidunt ullamcorper mattis.

Fusce odio velit, sodales id gravida vel, laoreet at lorem. Fusce malesuada mauris sed enim convallis non pulvinar dui egestas. Nullam sodales cursus quam sed lacinia. Praesent ac lorem ut erat feugiat molestie. Integer quis nisl et libero luctus ornare at vel ante. Integer magna nisi, vestibulum ac aliquam quis, iaculis eget massa. Integer ut venenatis ante. Duis fermentum neque elit, iaculis sagittis dui. Nam faucibus elementum nisl sit amet pulvinar. Duis fringilla, nulla ut porttitor rutrum, diam dolor sagittis neque, a placerat arcu diam nec libero. Nulla dolor tellus, consectetur eget consectetur ac, dapibus quis est. Aenean adipiscing volutpat lectus vitae consequat.

Cras ultrices lacus vitae metus dictum quis iaculis nulla bibendum. Duis aliquam, tellus id pharetra bibendum, dui est condimentum mauris, semper condimentum odio massa vitae nisl. Suspendisse non ipsum mauris. Vestibulum tempor consequat lacus quis commodo. Pellentesque eros urna, adipiscing ut faucibus id, sagittis non purus. Curabitur dignissim, urna id iaculis viverra, tortor libero congue sapien, eget tincidunt diam dolor at odio. Ut vitae lacus velit.

Pellentesque non tellus eget ipsum molestie placerat. Quisque sagittis, mauris facilisis tincidunt aliquet, erat nulla commodo turpis, nec porttitor dolor magna sit amet neque. Etiam ornare lobortis sagittis. Curabitur sit amet nunc at arcu consequat pellentesque at et tortor. Fusce vehicula, ante ut euismod dignissim, eros tellus tincidunt turpis, sit amet placerat nunc tortor ut dui. Cras lacus tortor, congue eget gravida sed, dapibus sed tortor. In hac habitasse platea dictumst. Vivamus ante felis, cursus quis interdum porta, accumsan non nulla. Maecenas lacus lacus, malesuada et lobortis a, ullamcorper ac odio. Sed ac neque massa, eget pharetra justo. Vivamus cursus eleifend nisl vel adipiscing. Sed eget lectus nisi. Donec sed lacus justo, sed semper dolor. Vestibulum mollis fermentum metus, quis hendrerit odio cursus nec.

Sed ac tempor nulla. Nunc eget nunc sit amet magna porta malesuada. Vivamus pharetra lorem vel enim pretium lacinia. Etiam vitae turpis turpis, quis ullamcorper libero. Aenean quis dui id nibh pellentesque eleifend. Cras commodo lectus a sapien laoreet venenatis. Donec facilisis hendrerit diam nec blandit. Duis lectus quam, aliquet quis fringilla non, posuere sit amet massa. Duis pharetra lacinia facilisis.

In gravida, neque a mattis tincidunt, velit arcu cursus nisi, eu blandit risus ligula eget ligula. Aenean faucibus tincidunt bibendum. Nulla nec urna lorem. Suspendisse non lorem in sapien cursus dignissim interdum non ligula. Suspendisse potenti. Sed rutrum libero ut odio varius a condimentum nulla commodo. Etiam in eros diam, vel lobortis nibh. Aliquam quam felis, blandit sit amet placerat non, tristique sit amet nisi. Pellentesque sit amet magna rutrum odio varius volutpat. Quisque consequat, elit ac blandit varius, turpis odio pellentesque urna, eu ultricies elit quam eget elit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nam vel sem sem, vitae vehicula tortor. Etiam ut dui diam. Duis id libero nunc, pharetra bibendum tellus. Praesent accumsan tempus euismod. Vestibulum ante ipsum primis in faucibus orci luctus et."

	if [ "$#" -ne 1 ]
	then

		# Se nao for passado um numero de palavras, exibe o texto todo
		echo $TEXTO

	elif zztool testa_numero "$1"
	then

		# Se o parametro for maior e igual a 1000, repete os múltiplos de 1000.
		contador=$(($1 / 1000))
		while [ $contador -gt 0 ]
		do
			echo $TEXTO
			contador=$(($contador -1))
		done

		# Se o resto do parâmetro for maior que zero, corta o texto no local certo, até esse limite ou ponto.
		contador=$(($1 % 1000))
		[ $contador -gt 0 ] && echo $TEXTO | cut -d " " -f 1-"$contador" | sed '$s/\.[^.]*$/\./'

	else

		# Caso o parametro nao seja um numero, exibe o modo de utilizacao
		zztool uso lorem

	fi

}
