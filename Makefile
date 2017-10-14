SHELL		:= /bin/bash
GO_VERSION  ?= 1.9
BINARY		?= run
SHARED_BIN	?= shared.so

VERSION		?= 0.0.1
BUILD		:= `date +%FT%T%z`
GIT_HASH	:= `git rev-parse HEAD`
PROJECT_PATH := github.com/rsysio/golang-template

LDFLAGS		:= -ldflags "-X main.Version=${VERSION} -X main.Build=${BUILD} -X main.GitHash=${GIT_HASH}"

dep-init:
	@docker run \
		--rm \
		-v ${PWD}:/go/src/$(PROJECT_PATH) \
		--workdir /go/src/$(PROJECT_PATH) \
		golang:$(GO_VERSION) \
		make cont-dep-init

dep:
	@docker run \
		--rm \
		-v ${PWD}:/go/src/$(PROJECT_PATH) \
		--workdir /go/src/$(PROJECT_PATH) \
		golang:$(GO_VERSION) \
		make cont-dep-ensure

build:
	@docker run \
		--rm \
		-v ${PWD}:/go/src/$(PROJECT_PATH) \
		--workdir /go/src/$(PROJECT_PATH) \
		golang:$(GO_VERSION) \
		make cont-build

build-shared:
	@docker run \
		--rm \
		-v ${PWD}:/go/src/$(PROJECT_PATH) \
		--workdir /go/src/$(PROJECT_PATH) \
		golang:$(GO_VERSION) \
		make cont-build-shared

clean:
	@docker run \
		--rm \
		-v ${PWD}:/go/src/$(PROJECT_PATH) \
		--workdir /go/src/$(PROJECT_PATH) \
		golang:$(GO_VERSION) \
		go clean

run:
	@docker run \
		--rm \
		-v ${PWD}:/go/src/$(PROJECT_PATH) \
		--workdir /go/src/$(PROJECT_PATH) \
		golang:$(GO_VERSION) \
		go run main.go

###############################################
#
# these will be run inside the docker container
#
###############################################
cont-dep-init:
	go get github.com/golang/dep/cmd/dep
	dep init

cont-dep-ensure:
	go get github.com/golang/dep/cmd/dep
	dep ensure

cont-build:
	go build ${LDFLAGS} -o ${BINARY} main.go

cont-build-shared:
	go build ${LDFLAGS} -buildmode=c-shared -o ${SHARED_BIN} shared.go
