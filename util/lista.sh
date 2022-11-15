#!/bin/bash
# 2021-07-12
# Aurelio Jargas
#
# Lista as funções disponíveis, mostrando uma por linha.
# Conforme o argumento recebido, filtra a lista.
#
# Exemplos:
#    lista.sh            # lista todas as funções
#    lista.sh internet   # lista somente as que usam internet
#    lista.sh local      # lista somente as que não usam internet
#    lista.sh testadas   # lista somente as que possuem testes

cd "$(dirname "$0")/.." || exit 1  # go to repo root

function zzname_from_path() {
    while read -r path
    do
        basename "$path" .sh
    done
}

case "$1" in
    all | todas | "")
        ls -1 zz/zz*.sh |
            zzname_from_path |
            sort
    ;;

    testadas)
        ls -1 testador/zz*.sh |
            zzname_from_path |
            sort
    ;;

    internet)
        ./util/metadata.sh tags |
            grep '^zz/[^ ]* .*internet' |
            cut -d ' ' -f 1 |
            zzname_from_path |
            sort
    ;;

    no-internet | local | sem-internet)
        ./util/lista.sh all |
            grep -F -v -x -f <(./util/lista.sh internet)
    ;;

    ci | github-actions)
        # Somente as funções sem acesso à internet são testadas no CI
        # https://github.com/funcoeszz/funcoeszz/issues/756
        ./util/lista.sh testadas |
            grep -F -v -x -f <(./util/lista.sh internet) |
            grep -F -v -x zzbraille
            # ^ https://github.com/funcoeszz/funcoeszz/issues/760
    ;;

    # Just to make sure we're doing it right
    self-test)
        all=$(./util/lista.sh all | wc -l)
        internet=$(./util/lista.sh internet | wc -l)
        no_internet=$(./util/lista.sh no-internet | wc -l)

        echo "$internet + $no_internet = $all"
        test "$((internet + no_internet))" -eq "$all" || {
            echo FAIL >&2
            exit 1
        }
    ;;

    *)
        echo "Invalid argument: $1" >&2
        exit 1
    ;;
esac
