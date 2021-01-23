with builtins; # funções como toString
{ pkgs ? import <nixpkgs> { }
, color ? true
, browserName ? "links2"
, browserPkg ? {
  "lynx" = pkgs.lynx;
  "links" = pkgs.links;
  "links2" = pkgs.links2;
  "elinks" = pkgs.elinks;
  "w3m" = pkgs.w3m;
}.${browserName} }:
let
  ZZCOR = if color then 1 else 0;
  drv = pkgs.stdenv.mkDerivation {
    name = "funcoeszz-source";
    src = ./.;
    installPhase = ''
      mkdir -p $out/opt
      cp -r $src $out/opt/funcoeszz
    '';
  };
  deps = with pkgs; [ browserPkg bc ];
  mainbin = pkgs.writeShellScript "zz" ''
    # Deixa os binários dependentes acessíveis
    PATH=$PATH:${pkgs.lib.makeBinPath deps}
    # Permite configurar suporte a cor pelo parâmetro do pacote
    export ZZCOR=${toString ZZCOR}
    # Onde estão as funções?
    export ZZDIR="${drv}/opt/funcoeszz/zz"
    # Chama o script com os parâmetros que vierem
    ${drv}/opt/funcoeszz/funcoeszz "$@"
  '';
in pkgs.stdenv.mkDerivation {
  name = "funcoeszz";
  phases = [ "installPhase" ]; # Ignora o fato de eu não ter passado um src
  installPhase = ''
    # Criar a pasta dos binários
    mkdir -p $out/bin
    # Cada um dos utilitários tem seu script de entrypoint que consequentemente vira um comando sem ter que mexer na bashrc, e pode ser instalado globalmente
    for fn in $(ls -1 ${drv}/opt/funcoeszz/zz | sed 's;.sh$;;g'); do
      echo Gerando script $fn
      bin=$out/bin/$fn
      echo '#!/usr/bin/env ${pkgs.bash}/bin/bash' >> $bin
      echo "${mainbin} $fn %" | sed 's;%;"$@";g' >> $bin
      chmod +x $bin
    done
    # Link do comando zz que engloba todos os outros
    ln -s ${mainbin} $out/bin/zz
    # Manpage
    mkdir -p $out/share/man/man1
    cp ${drv}/opt/funcoeszz/manpage/manpage.man $out/share/man/man1/funcoeszz.1
    ${pkgs.shellcheck}/bin/shellcheck -s bash $out/bin/*
    # Referencia ao repo na saída
    mkdir -p $out/opt
    ln -s ${drv}/opt/funcoeszz $out/opt/funcoeszz
  '';
}
