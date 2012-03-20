<!-- 
	2011-05-09
	Online interface for Funcoes ZZ (http://funcoeszz.net)
	
	by Aurelio Jargas
		http://aurelio.net
		@oreio

	License: MIT
	
	Note:
	 	Make sure magic_quotes_gpc is turned OFF.
		http://php.net/manual/en/security.magicquotes.disabling.php
 -->

<html>
<head>
<title>Funções ZZ online</title>
<link rel="icon" type="image/png" href="../img/favicon.png">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	body {
		margin: 0 1em;
		background: black;
		color: #ccc;
	}
	body, label, #stdin, #stdout, #arguments {
		font-family: monospace;
		font-weight: bold;
	}
	#stdin, #stdout, #arguments {
		font-size: 100%;
		background: white;
		color: black;
	}
	select, input, #history {
		font-size: 100%;
	}
	#inout {
		width: 100%;
		border-spacing: 1em;
		border-collapse: collapse;
		position: fixed;
		bottom: 0;
		right: 0;
		left: 0;
		background: #555;
	}
	#inout td {
		border-width: 2px 1em 1em 1em;
		border-style: solid;
		border-color: #555;
	}
	#inout label {
		color: white;
		cursor: help;
	}
	#stdin, #stdout {
		width: 100%;
	}
	#arguments {
		width: 40%;
	}
	#prompt {
		padding-bottom: 10em;
	}
	#history {
		margin-bottom: 0;
		line-height: 1.5em;
	}
	h1 {
		text-align: center;
		color: lime;
		line-height: 80px;
		margin: 0;
		font-family: Arial,sans-serif;
		border-bottom: 1px solid lime;
	}
	h1 a {
		color: lime;
		text-decoration: none;
	}
	h1 a:hover {
		text-decoration: underline;
	}
	.PS1 {
		color: lime;
	}
	.cmdline {
		color: white;
	}
	#help {
		color: lime;
		float: right;
		cursor: help;
		font-family: Arial;
		font-size: 85%;
	}
	#footer {
		position: fixed;
		right: 1.5em;
		bottom: 0.2em;
		font-family: Arial,sans-serif;
		font-size: 75%;
		font-weight: normal;
		color: silver;
		font-style: italic;
	}
	#footer a {
		color: silver;
	}
</style>
</head>
<body>

<h1><a href="..">Funções ZZ</a> online</h1>

<?
$method = $_SERVER['REQUEST_METHOD'];

// Using a customized all-in-one script for a faster response
// It contains just the needed functions for the online version
// See @scriptgen
$funcoeszz = './funcoeszz';

// Settings
$logfile = './log.txt';
$stdin_max_chars = 10000;
$arguments_max_chars = 250;

// POST
$stdin = $_POST['stdin'];
$stdout = $_POST['stdout'];
$arguments = escapeshellcmd($_POST['arguments']);
$zzfunc = $_POST['zzfunc'];
$history = $_POST['history'];

// UTF-8
setlocale(LC_CTYPE, "pt_BR.UTF-8");
putenv('LANG=pt_BR.UTF-8');

$available = array(
	// Disabling functions that needs Internet access
	// Disabling functions that needs a system
	// Disabling functions that needs a file
	// Disabling functions that plays sound
	// Last checked: 2011-05-09
	
	'zzalfabeto',
	// 'zzanatel', //i
	'zzansi2html',
	// 'zzarrumanome', //file
	'zzascii',
	// 'zzbeep', //sound
	'zzbissexto',
	// 'zzblist', //i
	// 'zzbolsas', //i
	// 'zzbrasileirao', //i
	'zzbyte',
	'zzcalcula',
	'zzcalculaip',
	'zzcarnaval',
	// 'zzcbn', //sound
	// 'zzchavepgp', //i
	// 'zzchecamd5', //file
	// 'zzcinclude', //sys
	// 'zzcinemais', //i
	// 'zzcinemark15h', //i
	// 'zzcineuci', //i
	// 'zzcorrida', //i
	'zzcnpj',
	'zzcontapalavra',
	'zzcontapalavras',
	'zzconverte',
	// 'zzcores',  //ansi
	'zzcorpuschristi',
	'zzcpf',
	'zzdata',
	// 'zzdata2',  //off
	// 'zzdatabarras', //off
	'zzdatafmt',
	// 'zzdefine', //i
	// 'zzdefinr', //i
	// 'zzdelicious', //i
	// 'zzdetransp', //i
	'zzdiadasemana',
	'zzdiasuteis',
	// 'zzdicasl', //i
	// 'zzdicbabelfish', //i
	// 'zzdicbabylon', //i
	// 'zzdicesperanto', //i
	// 'zzdicjargon', //i
	// 'zzdicportugues', //i
	// 'zzdicportugues2', //i
	// 'zzdictodos', //i
	// 'zzdiffpalavra', //file
	// 'zzdolar', //i
	// 'zzdominiopais', //i
	// 'zzdos2unix', //file
	// 'zzecho', //ansi
	// 'zzenglish', //i
	// 'zzenviaemail', //sys
	// 'zzeuro', //i
	// 'zzextensao', //!
	// 'zzfeed', //i
	// 'zzferiado', //sys
	'zzfoneletra',
	// 'zzfrenteverso2pdf', //file
	// 'zzfreshmeat', //i
	// 'zzglobo', //i
	// 'zzgoogle', //i
	'zzgravatar',
	'zzhexa2str',
	'zzhora',
	// 'zzhoracerta', //i
	'zzhoramin',
	'zzhorariodeverao',
	// 'zzhowto', //i
	// 'zzipinternet', //i
	// 'zzjquery', //i
	'zzjuntalinhas',
	// 'zzkill', //sys
	// 'zzlembrete', //sys
	// 'zzletrademusica', //i
	'zzlimpalixo',
	'zzlinha',
	// 'zzlinux', //i
	// 'zzlinuxnews', //i
	// 'zzlocale', //sys
	// 'zzloteria', //i
	// 'zzloteria2', //i
	// 'zzmaiores', //sys
	'zzmaiusculas',
	'zzmat',
	'zzmd5',
	// 'zzminiurl', //i
	'zzminusculas',
	// 'zzmoeda', //i
	// 'zzmoneylog', //file
	// 'zzmudaprefixo', //file
	// 'zznarrativa', //i
	// 'zznatal', //i
	// 'zznome', //i
	// 'zznomefoto', //file
	// 'zznoticiaslinux', //i
	// 'zznoticiassec', //i
	// 'zzora', //i
	'zzpascoa',
	// 'zzpiada', //i
	'zzporcento',
	// 'zzpronuncia', //som
	// 'zzquebramd5', //i
	// 'zzramones', //i
	// 'zzrandbackground', //sys
	// 'zzrastreamento', //i
	// 'zzrelansi', //sys
	'zzromanos',
	'zzrot13',
	'zzrot47',
	// 'zzrpmfind', //i
	// 'zzsecurity', //i
	'zzsemacento',
	'zzsenha',
	'zzseq',
	'zzsextapaixao',
	'zzshuffle',
	// 'zzsigla', //i
	// 'zzss', //sys
	'zzsubway',
	'zztabuada',
	// 'zztempo', //i
	// 'zztradutor', //i
	// 'zztrocaarquivos', //file
	// 'zztrocaextensao', //file
	// 'zztrocapalavra', //file
	// 'zztv', //i
	// 'zztweets', //i
	'zzunescape',
	'zzunicode2ascii',
	'zzuniq',
	// 'zzunix2dos', //file
	'zzvira',
	// 'zzwhoisbr', //i
	// 'zzwikipedia', //i
	'zzxml',
);

// Not available, but required by some
$required = array(
	'zzdos2unix', // zzjuntalinhas
);

// Functions that suffer from "zzname /etc/passwd" exploit
$file_exploit = array(
	'zzansi2html',
	'zzcontapalavra',
	'zzcontapalavras',
	'zzdos2unix', //required
	'zzjuntalinhas',
	'zzlimpalixo',
	'zzlinha',
	'zzmaiusculas',
	'zzmd5',
	'zzminusculas',
	'zzshuffle',
	'zzunescape',
	'zzunicode2ascii',
	'zzuniq',
	'zzxml',
);

// Defaults
if ($method == 'GET') {
	$zzfunc = 'zzcalcula';
	$arguments = '2+2';
}

/////////////////////////////////////////////////////////////////////

// // @scriptgen Update funcoeszz script
// $svn_root = '../..';
// $active = array_merge($available, $required);
// $all = array_map("basename", glob($svn_root.'/zz/zz*'));
// $off = implode(' ', array_diff($all, $active));
// print "ZZDIR=$svn_root/zz ZZOFF='$off' $svn_root/funcoeszz --tudo-em-um > funcoeszz";
// exit();

// // Test file/dir access exploit
// foreach($available as $zz) {
// 	if (in_array($zz, $file_exploit)) continue;
// 	foreach(array('/etc/passwd', '/etc') as $arg) {
// 		$cmd = "ZZCOR=0 $funcoeszz $zz $arg";
// 		print "<h2 style='color:yellow;'>$cmd</h2>";
// 		passthru("$cmd");
// 	}
// }
// exit();

/////////////////////////////////////////////////////////////////////
// Button pressed
if ($method == 'POST') {

	// Sanity: Max size
	if (strlen($arguments) > $arguments_max_chars) {
		die("Ops, texto muito extenso nos argumentos da função. O máximo é $arguments_max_chars caracteres.");
	}
	if (strlen($stdin) > $stdin_max_chars) {
		die("Ops, texto muito extenso na STDIN. O máximo é $stdin_max_chars caracteres.");
	}

	// Security: Log execution (function name only, not data)
	date_default_timezone_set('America/Sao_Paulo');
	$timestamp = date('Y-m-d H:i:s');
	$fd = fopen($logfile, 'a');
	fwrite($fd, "$timestamp $zzfunc\n");
	fclose($fd);

	// Security checking: only execute allowed zz functions
	if (!in_array($zzfunc, $available)) {
		exit(':(');
	}

	// Security checking: disallow system files access (thanks @jbvsmo)
	if (in_array($zzfunc, $file_exploit)) {
		$arguments = str_replace('/', '', $arguments);
		// Brute force.
		// This will just impact two valid use cases, inside options:
		// Uso: zzjuntalinhas [-d separador] [-i texto] [-f texto] arquivo(s)
		// Uso: zzlinha [número | -t texto] [arquivo(s)]
	}

	// Make sure we have a line break at the end of history
	// Seems like Safari rstrip() the <PRE> contents
	if (substr($history, -1) != "\n") {
		$history .= "\n";
	}

	// Add command to history
	$history .= '<span class="PS1">prompt$</span> ';
	$history .= '<span class="cmdline">'.htmlspecialchars("$zzfunc $arguments", ENT_NOQUOTES).'</span>'."\n";

	// Compose full command
	$command = "ZZCOR=0 $funcoeszz $zzfunc $arguments";

	// print $command; //debug

	if ($stdin) {
		// Normalize line break between platforms
		$stdin = preg_replace('/[\n\r]+/', "\n", $stdin);

		// Make sure we have a line break at the end of STDIN
		if (substr($stdin, -1) != "\n") {
			$stdin .= "\n";
		}
	}

	// proc_open() Voodoo
	// See http://php.net/manual/en/function.proc-open.php

	$descriptorspec = array(
	   0 => array("pipe", "r"),  // stdin is a pipe that the child will read from
	   1 => array("pipe", "w"),  // stdout is a pipe that the child will write to
	   2 => array("pipe", "w")   // stderr
	);
	$process = proc_open($command, $descriptorspec, $pipes);

	if (is_resource($process)) {
	    // $pipes now looks like this:
	    // 0 => writeable handle connected to child stdin
	    // 1 => readable handle connected to child stdout

	    // fwrite($pipes[0], stream_get_contents(STDIN)); // file_get_contents('php://stdin')
	    fwrite($pipes[0], $stdin);
	    fclose($pipes[0]);

	    $stdout = stream_get_contents($pipes[1]);
	    fclose($pipes[1]);

	    $stderr = stream_get_contents($pipes[2]);
	    fclose($pipes[2]);

	    // It is important that you close any pipes before calling
	    // proc_close in order to avoid a deadlock
	    $return_value = proc_close($process);
	}

	// Add stdout to history
	$history .= htmlspecialchars($stdout, ENT_NOQUOTES);
}


/////////////////////////////////////////////////////////////////////
?>

<span id="help" title="Use -h na caixa de texto para obter a ajuda da função. Recarregue a página para limpar o histórico de comandos.">?</span>

<form method="post" action="#prompt">

	<pre id="history"><?=$history?></pre> <!-- Leave as one line, do not indent. -->

	<div id="prompt">
		<span class="PS1">prompt$</span>
		<select name="zzfunc" id="zzfunc" size="1">
<?
		foreach ($available as $zz) {
?>
			<option value="<?=$zz?>"<? if ($zz == $zzfunc) echo ' selected="selected"'; ?>><?=$zz?></option>
<?
		}
?>
		</select>
		<input type="text" id="arguments" name="arguments" value="<?=htmlspecialchars($arguments)?>">
		<input type="submit" id="submit" value="Enter">
	</div><!-- prompt -->

	<table id="inout">
	<tr>
		<td>
			<label for="stdin" title="Cole aqui o texto a ser manipulado pela função.">STDIN:</label>
			<textarea id="stdin" name="stdin" rows="5"><?=htmlspecialchars($stdin)?></textarea>
		</td>
		<td>
			<label for="stdout" title="Aqui aparece o resultado do último comando.">STDOUT:</label>
			<textarea id="stdout" name="stdout" rows="5"><?=htmlspecialchars($stdout)?></textarea>
		</td>
	</tr>
	</table>

	<input type="hidden" name="history" id="history" value="<?=str_replace('"', '&quot;', htmlspecialchars($history))?>">
</form>

<div id="footer">
	<a
		title="Veja o código-fonte deste webapp e me ajude a melhorá-lo!"
		href="http://code.google.com/p/funcoeszz/source/browse/trunk/web/online/index.php">PHP-HTML-CSS</a>
	por
	<a
		title="Quer ajuda? Tem uma sugestão? Achou uma brecha na segurança? Fale comigo no twitter."
		href="http://twitter.com/oreio">@oreio</a>

<? if ($method == 'GET'): ?>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-280222-4";
urchinTracker();
</script>
<? endif ?>

</body>
</html>

<!--
TODO:
funcoeszz script auto update (crontab)
iphone: #inout not really fixed
copy stdout to stdin?
chain commands?
history	clicable? (reload command)
timestamp pra cada cmd (tooltip)
JS: mostrar Uso: no onchange do select
-->
