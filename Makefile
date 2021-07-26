
SHELL := $(shell which bash)

# Test in current env
run-test:
	@echo "Testing in current env..."
	nvim -c ':Vader!' test/test.vader \
		&& echo Success || echo Failure

run-test-interactive:
	@echo "Testing..."
	nvim -c ':Vader' test/test.vader

# Test in isolated env
test-newenv:
	${SHELL} test/run.sh
