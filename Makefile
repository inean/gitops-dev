# Common Vars
PROJECT_TAG     ?= canary
PROJECT         := gitops-dev
PROJECT_PATH    := github.com/inean/${PROJECT}

export GIT_PROJECT  = $(PROJECT)
export GIT_DIRTY    = $(shell test -n "$$(git status --porcelain)" && echo "+CHANGES" || true)
export GIT_COMMIT   = $(shell git rev-parse --short HEAD)
export GIT_DESCRIBE = $(shell git describe --tags --always)

# Required for globs to work correctly
SHELL         := /bin/bash
.SHELLFLAGS   := -o pipefail -euc
.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo 'Management commands for "$(PROJECT)"'
	@echo
	@echo 'Usage:'
	@echo '  ## User Commands'
	@echo '    make prepare         Boostrap Python 3 venv and configure ansible.'
	@echo
	@echo '  ## Develop / Test Commands'
	@echo '    make format          Run code formatter.'
	@echo '    make check           Run static code analysis (lint).'
	@echo '    make test            Run tests on project.'
	@echo '    make cover           Run tests and capture code coverage metrics on project.'
	@echo '    make clean           Clean the directory tree of produced artifacts.'
	@echo
	@echo '  ## Utility Commands'
	@echo '    make setup           Configures Minishfit/Docker directory mounts.'
	@echo

# Ensure we don't invoke makefile from development branch
.PHONY: sanitize
sanitize:
ifndef PROJECT_TARGET_OS
	$(error Checkout a valid branch for your computer)
endif

.PHONY: prepare
prepare: sanitize
	-@:

# Development commands
.PHONY: format
format:
	-@:

.PHONY: check
check:
	-@:

.PHONY: test
test:
	-@:

.PHONY: cover
cover:
	-@:

.PHONY: clean
clean:
	-@: