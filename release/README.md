
## Preparativos para o release

- Testador deve estar 100%.
- Nanny deve estar 100%.
- util/requisitos.sh deve estar 100%.


## Número da versão

- Ano (dois dígitos), ponto, mês (sem zero inicial).
- 2013-03-15 → versão 13.3


## Procedimento de release

- Mude a versão no cabeçalho do core: `ZZVERSAO=13.2`
- ?
- Rode `release/make-release.sh` para gerar a versão oficial.
- Rode `release/2iso.sh` para gerar a versão iso.
- Mover ambos arquivos para a pasta `website/download/`.
- Faça um diff com a versão anterior e confira as mudanças.
- Rode a suíte de testes usando este arquivo recém gerado (é preciso editar o script de testes).
- Atualize o site e faça o upload (ver tópico adiante).
- Acesse o site e confira tudo.
- Baixe o arquivo, faça um diff com o original e confira se ele roda normal.
- Se chegou até aqui, aparentemente está tudo certo :)


## Anúncio

- Crie o texto de anúncio, destacando as novidades.
- Use os anteriores como base.
- Mandar este texto para sites de notícias (BR-Linux).


## Crie uma tag para o release

```
git tag -a 13.2 -m "TAG: Versão 13.2"   # cria tag local
git push origin 13.2                    # manda esta tag pro GitHub
```


## Gerando informações sobre o release

Supondo a versão nova fictícia 2.2 (a anterior sendo 1.1), seguem exemplos.

Crie uma pasta para guardar os TXT deste release.

```
cd release
mkdir 2.2
```

Gere o arquivo com a lista de todas as funções:

```
grep ^zz funcoeszz-2.2.sh | cut -d ' ' -f 1 | sort > 2.2/todas.txt
```

Gere os arquivos com as diferenças em relação à versão anterior:

```
diff 1.1/todas.txt 2.2/todas.txt | grep '^<' | cut -c 3- | sort > 2.2/removidas.txt
diff 1.1/todas.txt 2.2/todas.txt | grep '^>' | cut -c 3- | sort > 2.2/novas.txt
```


## Changelog

Para gerar a lista de funções novas + descrição para colocar no changelog, faça asssim:

```
ZZCOR=0 ./funcoeszz-2.2.sh zzajuda --lista > descricao.txt

cat 2.2/novas.txt | while read zz; do printf "%s: " $zz ; grep "^$zz " descricao.txt | cut -c 19-; done
```


## Pós-release

- Mudar de volta a versão no cabeçalho do core: `ZZVERSAO=dev`


## Atualização do site para o release

- Atualizar `website/changelog.t2t`
- Atualizar `website/v` — para que a `zzzz --atualiza` continue funcionando
- Atualizar `website/.htaccess` — links para os downloads atuais
- Há alguém novo para agradecer em `website/thanks.t2t`?
- Substituição global (porém analise caso a caso) da versão velha pra nova (ex.: `10.12 → 13.2`)
- Regerar a man page

```
$ manpage/genman
$ txt2tags website/man.t2t
```

