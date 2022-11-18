clitest = testador/clitest
clitest_url = https://raw.githubusercontent.com/aureliojargas/clitest/master/clitest

.PHONY: clean lint test test-core test-local test-internet

lint: shellcheck
	./util/alinhamento.sh
	./util/requisitos.sh
	./util/nanny.sh

# Na segunda chamada, estamos indo aos poucos nas zz/*.sh, ligando somente as
# verificações mais simples de arrumar. São elas:
# - egrep/fgrep -> grep -E/-F
# - read -r
# - * -> ./* pra evitar conflito de glob com -arquivos --estranhos
# - cd || exit
# - foo= -> foo=''
shellcheck:
	shellcheck funcoeszz testador/run \
		info/*.sh \
		manpage/*.sh \
		release/*.sh \
		util/*.sh
	shellcheck zz/*.sh --shell=bash \
		--include SC2196,SC2197 \
		--include SC2162 \
		--include SC2035 \
		--include SC2164 \
		--include SC1007

test: test-core test-local test-internet

test-core: $(clitest)
	./testador/run funcoeszz.md

test-local: $(clitest)
	./testador/run local

test-internet: $(clitest)
	./testador/run internet

# Download clitest, the tester program that runs our test-suite.
$(clitest):
	curl --location --silent --output $(clitest) $(clitest_url)
	chmod +x $(clitest)

clean:
	rm -f $(clitest) release/funcoeszz-dev.sh
