export GO111MODULE := on

GIT_SHA := $(shell git rev-parse --short=8 HEAD)
GIT_VERSION := $(shell git describe --long --all)
BUILD_DATE := $(shell date -Iseconds)
VERSION := $(shell cat VERSION)

TEST_OPTS := -cover -race -timeout 30s

# Build with:
#	-w 						do not include debug information to keep file size low
#	-extldflags "-static"	to run in a tiny Docker image "scratch"
GO_LDFLAGS := -w \
	-extldflags "-static" \
	-X github.com/metal-stack/v.Version=$(VERSION) \
	-X github.com/metal-stack/v.Revision=$(GIT_VERSION) \
	-X github.com/metal-stack/v.GitSHA1=$(GIT_SHA) \
	-X github.com/metal-stack/v.BuildDate=$(BUILD_DATE)

.ONESHELL:
.DEFAULT_GOAL: build

.PHONY: lint
lint:
	@golangci-lint run

.PHONY: tidy
tidy:
	@go mod tidy
	@go mod verify

.PHONY: test
test: tests

.PHONY: tests
tests: unit-tests integration-tests

.PHONE: clean-test
clean-test:
	go clean -testcache

.PHONY: integration-tests
integration-tests: clean-test
	go test -run integration $(TEST_OPTS) ./...

.PHONY: unit-tests
unit-tests: clean-test
	go test -v -short $(TEST_OPTS) ./...

.PHONY: binary
binary: tests
	go build \
		-a \
		-tags netgo \
		-ldflags "$(GO_LDFLAGS)" \
		-o bin/binary-linux-amd64 \
.

.PHONY: clean
clean:
	@rm -f bin/binary-linux-amd64

# Fails on available updates to indicate the need to apply dependency updates.
.PHONY: update-check
update-check: .get-go-mod-outdated
	go list -u -m -json all | go-mod-outdated -direct -ci

# Install or update "go-mod-outdated" to lookup outdated dependencies.
.PHONY: .get-go-mod-outdated
.get-go-mod-outdated:
	script/go-get.sh github.com/psampaz/go-mod-outdated
