#
# See ./CONTRIBUTING.rst
#

OS := $(shell uname)
.PHONY: help build up requirements clean lint test help
.DEFAULT_GOAL := help

PROJECT := go-gin-sample
PROJECT_DEV := $(PROJECT)_dev
PROJECT_STAGE := $(PROJECT)_stage
PROJECT_TEST := $(PROJECT)_test
PROJECT_PORT := 8000

PYTHON_VERSION=3.6.4
PYENV_NAME="${PROJECT}"

# Configuration.
SHELL := /bin/bash
ROOT_DIR=$(shell pwd)
MESSAGE:=༼ つ ◕_◕ ༽つ
MESSAGE_HAPPY:="${MESSAGE} Happy Coding"
SOURCE_DIR=$(ROOT_DIR)/
REQUIREMENTS_DIR=$(ROOT_DIR)/requirements
PROVISION_DIR:=$(ROOT_DIR)/provision
FILE_README:=$(ROOT_DIR)/README.rst
KEYS_DIR:="${HOME}/.ssh"
PATH_DOCKER_COMPOSE:=provision/docker-compose

pip_install := pip install -r
docker-compose:=docker-compose -f docker-compose.yml

include *.mk

help:
	@echo '${MESSAGE} Makefile for ${PROJECT}'
	@echo ''
	@echo 'Usage:'
	@echo '    environment               create environment with pyenv'
	@echo '    install                   install dependences python by env'
	@echo '    clean                     remove files of build'
	@echo '    setup                     install requirements'
	@echo ''
	@make alias.help
	@make docker.help
	@make docs.help
	@make go.help
	@make test.help

clean:
	@echo "$(TAG)"Cleaning up"$(END)"
ifneq (Darwin,$(OS))
	@sudo rm -rf .tox *.eg-infog dist build .coverage docs/build
	@sudo find . -name '__pycache__' -delete -print -o -name '*.pyc' -delete -print -o -name '*.pyo' -delete -print -o -name '*~' -delete -print -o -name '*.tmp' -delete -print
else
	@rm -rf .tox *.eg-infog dist build .coverage docs/build
	@rm -rf docs/build
	@find . -name '__pycache__' -delete -print -o -name '*.pyc' -delete -print -o -name '*.pyo' -delete -print -o -name '*~' -delete -print -o -name '*.tmp' -delete -print
endif
	@echo

setup: clean
	$(pip_install) "${REQUIREMENTS_DIR}/setup.txt"
	pre-commit install
	cp -rf extras/git/hooks/prepare-commit-msg .git/hooks/
	@if [ ! -e ".env" ]; then \
		cp -rf .env-sample .env;\
	fi

environment: clean
	@if [ -e "$(HOME)/.pyenv" ]; then \
		eval "$(pyenv init -)"; \
		eval "$(pyenv virtualenv-init -)"; \
	fi
	pyenv virtualenv "${PYTHON_VERSION}" "${PYENV_NAME}" >> /dev/null 2>&1 || echo $(MESSAGE_HAPPY)
	pyenv activate "${PYENV_NAME}" >> /dev/null 2>&1 || echo $(MESSAGE_HAPPY)

