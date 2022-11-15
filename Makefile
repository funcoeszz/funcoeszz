clitest = testador/clitest
clitest_url = https://raw.githubusercontent.com/aureliojargas/clitest/master/clitest

.PHONY: clean lint test test-core test-local test-internet

lint: shellcheck
	./util/alinhamento.sh
	./util/requisitos.sh
	./util/nanny.sh

shellcheck:
	shellcheck info/*.sh manpage/*.sh release/*.sh util/*.sh

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
