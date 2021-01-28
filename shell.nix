{pkgs ? import <nixpkgs> {}}:
let
  clitest = pkgs.stdenv.mkDerivation rec {
    name = "clitest";
    version = "0.4.0";
    src = builtins.fetchTarball {
      url = "https://github.com/aureliojargas/clitest/archive/0.4.0.tar.gz";
      sha256 = "sha256:1p745mxiq3hgi3ywfljs5sa1psi06awwjxzw0j9c2xx1b09yqv4a";
    };
    buildPhase = "";
    installPhase = ''
      mkdir -p $out/bin
      cp $src/clitest $out/bin/clitest
      chmod +x $out/bin/clitest
    '';
  };
  funcoeszz = pkgs.callPackage ./default.nix {};
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # dependencia de execução
    bc
    curl
    gawk
    gnused
    ncurses
    # dependencia de teste
    perl
    w3m
    clitest
  ];
  shellHook = ''
    zzroot=$(pwd)
    function testador {
      $zzroot/testador/run "$@"
    }
  '';
}
