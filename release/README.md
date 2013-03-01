
## Preparativos para o release

- Testador deve estar 100%
- Nanny deve estar 100%
- util/requisitos.sh deve estar 100%


## Procedimento de release

- Mudar versão no cabeçalho do core: `ZZVERSAO=13.2`
- ?
- Rodar `release/make-release.sh` para gerar a versão oficial
- Rodar `release/2iso.sh` para gerar a versão iso
- Mover ambos arquivos para a pasta website/download/


## Crie uma tag para o release

    git tag -a 13.2 -m "TAG: Versão 13.2"   # cria tag local
    git push origin 13.2                    # manda esta tag pro GitHub


## Pós-release

- Mudar de volta a versão no cabeçalho do core: `ZZVERSAO=dev`


## Atualização do site para o release

- Atualizar `website/changelog.t2t`
- Atualizar `website/v` — para que a `zzzz --atualiza` continue funcionando
- Atualizar `website/.htaccess` — links para os downloads atuais
- Atualizar `website/download.t2t` — tem a versão corrente nas instruções
- Substituição global (porém analise caso a caso) da versão velha pra nova (ex.: `s/10\.12/13.2/g`), pra garantir
- Regerar a man page

    $ manpage/genman
    $ txt2tags website/man.t2t

