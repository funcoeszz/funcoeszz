
## Preparativos para o release

- Testador deve estar 100%.
- Nanny deve estar 100%.
- `util/requisitos.sh` deve estar 100%.


## Número da versão

- Ano (dois dígitos), ponto, mês (sem zero inicial).
- 2013-05-14 → versão 14.5


## Procedimento de release

> Usarei a versão fictícia 14.5 para ilustrar o procedimento.

Mude a versão no cabeçalho do core: `ZZVERSAO=14.5`.

Crie um commit especial para o release:

```bash
git add funcoeszz
git commit -m 'RELEASE versão 14.5'
```

Crie a tag do release, que apontará para este commit:

```bash
git tag -a 14.5 -m 'TAG: Versão 14.5'
```

Rode `release/make-release.sh` para gerar a versão oficial.

Mude de volta a versão no cabeçalho do core: `ZZVERSAO=dev` e faça o commit:

```bash
git add funcoeszz
git commit -m 'VERSION=dev, voltamos à labuta'
```

Faça um diff com a versão anterior e confira as mudanças.

Rode o testador usando este arquivo recém gerado (é preciso editar o script de testes).

Regere a man page:

```console
$ ./manpage/generate.sh 
Generating funcoeszz script...
zzajuda
zzaleatorio
zzalfabeto
...
zzvira
zzwikipedia
zzxml
zzzz

saved manpage.t2t
txt2tags wrote manpage.man
$
```

Gere os arquivos de dados sobre este release:

```bash
cd release
mkdir 14.5

# Lista de todas as funções
grep ^zz funcoeszz-14.5.sh | cut -d ' ' -f 1 | sort > 14.5/todas.txt

# Diferenças em relação à versão anterior
diff 13.2/todas.txt 14.5/todas.txt | grep '^<' | cut -c 3- | sort > 14.5/removidas.txt
diff 13.2/todas.txt 14.5/todas.txt | grep '^>' | cut -c 3- | sort > 14.5/novas.txt
```

Mova o arquivo oficial para o site:

```bash
mv release/funcoeszz-14.5.sh ../funcoeszz.github.io/download/
```

Atualize o site, em `../funcoeszz.github.io`:

- Atualizar `/_data/versions.yml`
- Atualizar `/_data/list.yml` (use o script na mesma pasta)
- Atualizar `/_data/help.yml` (use o script na mesma pasta)
- Há alguém novo para agradecer em `/thanks.html`?
- Criar o arquivo com o anúncio em `/anuncio-14.5.html`
- Atualizar `/changelog.html`
- Atualizar a página principal, no topo, com aviso sobre a versão nova


## Publique o release

- Suba para o GitHub o commit de release e sua tag: `git push --tags`.
- Suba para o GitHub o site atualizado.
- Acesse o site e confira tudo.
- Baixe o arquivo das funções pelo site, faça um diff com o original (local) e confira se ele roda normal.
- Se chegou até aqui, aparentemente está tudo certo :)


## Anúncio

- Mandar o conteúdo do anúncio para sites de notícias (BR-Linux).
- Avisar da versão nova na conta do twitter do projeto.
