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
	}
	#stdin, #stdout, #arguments {
		font-size: 100%;
		background: white;
		color: black;
	}
	.stderr {
		color: red;
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
		display: none;  /* disabled */
		color: lime;
		float: right;
		cursor: help;
		font-family: Arial;
		font-size: 85%;
	}
	#help-zz {
		float: right;
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

<?php
$method = $_SERVER['REQUEST_METHOD'];

// Settings
$api_root = 'http://api.funcoeszz.net/0';
// $api_root = 'http://zzapi.dev/0';  // local
$stdin_max_chars = 10000;
$arguments_max_chars = 250;
$stderr = null;

// POST data
$zzfunc    = (empty($_POST['zzfunc']   )) ? null : $_POST['zzfunc'];
$stdin     = (empty($_POST['stdin']    )) ? null : $_POST['stdin'];
$stdout    = (empty($_POST['stdout']   )) ? null : $_POST['stdout'];
$arguments = (empty($_POST['arguments'])) ? null : $_POST['arguments'];
$history   = (empty($_POST['history']  )) ? null : $_POST['history'];
$showhelp  = (empty($_POST['showhelp'] )) ? null : $_POST['showhelp'];

// Get from API the list of available functions
// $available = json_decode(file_get_contents("$api_root/list.json"));
$available = json_decode(file_get_contents("list.json"));  // cached

// Defaults
if ($method == 'GET') {
	// $zzfunc = 'zzcalcula';
	// $arguments = '2+2';
	$zzfunc = 'zzsenha';
	$arguments = '25';
}

/////////////////////////////////////////////////////////////////////

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

	// Make sure we have a line break at the end of history
	// Seems like Safari rstrip() the <PRE> contents
	if (substr($history, -1) != "\n") {
		$history .= "\n";
	}

	// Call API to show help
	if ($showhelp) {
		$help = file_get_contents("$api_root/help/${zzfunc}.txt?apikey=e0a7a294");
		$stdout = "\n" . trim($help) . "\n\n";

	// Call API to run the command
	} else {
		$results_json = json_decode(
			file_get_contents(
				"$api_root/run/${zzfunc}.json?" .
					"apikey=e0a7a294" .
					"&stdin=" . urlencode($stdin) .
					"&arg=" . urlencode($arguments)
			)
		);

		// Got results?
		if (isset($results_json)) {

			// Save STDOUT/STDERR
			if (property_exists($results_json, 'stdout')) {
				$stdout = $results_json->stdout;
				$stderr = trim($results_json->stderr);
			} else {
				$stdout = $stderr = '';
			}

			// API errors raised?
			if (property_exists($results_json, 'error')) {
				$stderr .= $results_json->error;
			}
		}
	}

	// Add command to history
	$hist_arg = ($showhelp) ? '-h' : $arguments;
	$history .= '<span class="PS1">prompt$</span> ';
	$history .= '<span class="cmdline">'.htmlspecialchars("$zzfunc $hist_arg", ENT_NOQUOTES).'</span>'."\n";

	// Add stdout to history
	$history .= htmlspecialchars($stdout, ENT_NOQUOTES);

	// Maybe some errors to show?
	if (!empty($stderr)) {
		$history .=
			'<span class="stderr">' .
			htmlspecialchars($stderr, ENT_NOQUOTES) .
			'</span>' . "\n";
	}
}


/////////////////////////////////////////////////////////////////////
?>

<span id="help" title="Use -h na caixa de texto para obter a ajuda da função. Recarregue a página para limpar o histórico de comandos.">?</span>

<form method="post" action="#prompt">

	<pre id="history"><?php echo $history; ?></pre> <!-- Leave as one line, do not indent. -->

	<div id="prompt">
		<span class="PS1">prompt$</span>
		<select name="zzfunc" id="zzfunc" size="1">
<?php
		foreach ($available as $zz) {
?>
			<option value="<?php echo $zz; ?>"<?php if ($zz == $zzfunc) echo ' selected="selected"'; ?>><?php echo $zz; ?></option>
<?php
		}
?>
		</select>
		<input type="text" id="arguments" name="arguments" value="<?php echo htmlspecialchars($arguments); ?>">
		<input type="submit" id="submit" value="Enter">
		<input type="submit" id="help-zz" value="Ajuda" name="showhelp">
	</div><!-- prompt -->

	<table id="inout">
	<tr>
		<td>
			<label for="stdin" title="Cole aqui o texto a ser manipulado pela função.">STDIN:</label>
			<textarea id="stdin" name="stdin" rows="5"><?php echo htmlspecialchars($stdin); ?></textarea>
		</td>
		<td>
			<label for="stdout" title="Aqui aparece o resultado do último comando.">STDOUT:</label>
			<textarea id="stdout" name="stdout" rows="5"><?php echo htmlspecialchars($stdout); ?></textarea>
		</td>
	</tr>
	</table>

	<input type="hidden" name="history" id="history" value="<?php echo str_replace('"', '&quot;', htmlspecialchars($history)); ?>">
</form>

<div id="footer">
	<a
		title="Veja o código-fonte deste webapp e me ajude a melhorá-lo!"
		href="http://code.google.com/p/funcoeszz/source/browse/trunk/web/online/index.php">PHP-HTML-CSS</a>
	por
	<a
		title="Quer ajuda? Tem uma sugestão? Achou uma brecha na segurança? Fale comigo no twitter."
		href="http://twitter.com/oreio">@oreio</a>

<?php if ($method == 'GET'): ?>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-280222-4";
urchinTracker();
</script>
<?php endif ?>

</body>
</html>

<!--
TODO:
iphone: #inout not really fixed
copy stdout to stdin?
chain commands?
history	clicable? (reload command)
timestamp pra cada cmd (tooltip)
JS: mostrar Uso: no onchange do select
-->
