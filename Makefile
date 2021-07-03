clitest = testador/clitest
clitest_url = https://raw.githubusercontent.com/aureliojargas/clitest/master/clitest

.PHONY: clean lint test test-core test-local test-internet

lint:
	./util/requisitos.sh
	./util/nanny.sh

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
	rm -f $(clitest)
