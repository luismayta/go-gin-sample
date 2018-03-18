#
# See ./CONTRIBUTING.rst
#
.PHONY: go.help

go.help:
	@echo '    go:'
	@echo ''
	@echo '        go                  help go'
	@echo '        go.make             make go binary'
	@echo ''

go: go.help

go.make: clean
	$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/dev.yml \
		run --rm app sh -c "GOOS=linux GOARCH=amd64 go build -o main main.go"
		zip main.zip main
