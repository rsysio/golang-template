.DEFAULT: build

BINARY=run
SHARED_BIN=shared.so

VERSION=0.0.1
BUILD=`date +%FT%T%z`
GIT_HASH=`git rev-parse HEAD`

LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.Build=${BUILD} -X main.GitHash=${GIT_HASH}"

build:
	go build ${LDFLAGS} -o ${BINARY} main.go

build-shared:
	go build ${LDFLAGS} -o ${BINARY} shared.go

clean:
	go clean

run:
	go run main.go
