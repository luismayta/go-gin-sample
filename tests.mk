#
# See ./CONTRIBUTING.rst
#

test.help:
	@echo '    Tests:'
	@echo ''
	@echo '        test                      Run all test'
	@echo '        test.lint                 Run all pre-commit'
	@echo '        test.syntax               Run all syntax in code'
	@echo ''

test: test.help

test.lint: clean
	$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/dev.yml \
		run --rm check sh -c "pre-commit run --all-files --verbose"

test.syntax:
	@echo $(MESSAGE) Running tests $(END)
