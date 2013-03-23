## Funções ZZ - Cópia local

Cópia local dos sites que as funções utilizam como fontes de dados.

Como os sites mudam ou acabam saindo do ar, é bom termos uma cópia local para saber como eram os dados quando a função funcionava corretamente.

Se o site mudou o formato da página ou dos fontes, é útil para fazer um diff com a versão anterior. Isso pode facilitar na hora de atualizar o filtro.

Se o site saiu do ar definitivamente, podemos alterar a função para consultar o arquivo de dados direto de nossa cópia no GitHub.


## Como adicionar um arquivo novo aqui

**O nome do arquivo** será o nome da função e a extensão `.txt` ou `.html`, conforme o conteúdo.

**Guarde o arquivo original**, sem alterações. Ou seja, antes de aplicar quaisquer dos filtros.

**Use o código da função para baixar o arquivo**. Não baixe na mão. Copie os trechos de código relevantes da função direto na linha de comando. Por exemplo, a zznatal:

```bash
zznatal ()
{
	zzzz -h natal "$1" && return

	local url='http://www.vidanet.org.br/mensagens/feliz-natal-em-varios-idiomas'
	local cache="$ZZTMP.natal"
	local padrao=$1

	# Se o cache está vazio, baixa listagem da Internet
	if ! test -s "$cache"
	then
		$ZZWWWDUMP "$url" | sed '
			1,10d
			77,179d
			s/^  *//
			s/^(/Chinês  &/
			s/  */: /' > "$cache"
	fi

	# Mostra uma linha qualquer (com o padrão, se informado)
	echo -n '"Feliz Natal" em '
	zzlinha -t "${padrao:-.}" "$cache"
}
```

Para fazer uma cópia do arquivo original, basta colar na linha de comando as linhas importantes:

```
prompt$ url='http://www.vidanet.org.br/mensagens/feliz-natal-em-varios-idiomas'
prompt$ $ZZWWWDUMP "$url" > zznatal.txt
```

E pronto. Perceba como não usei os filtros sed, guardei o arquivo puro. E usei a extensão TXT já que não é o código HTML, mas sim o arquivo já parseado pelo `lynx -dump`.


