export GOPATH= $(PWD)/vendor

all: build

dev:
	go build -v -o ./bin/truami

deps:
	@mkdir -p vendor
	go get github.com/aws/aws-sdk-go/aws/client
	go get github.com/aws/aws-sdk-go/aws/session
	go get github.com/aws/aws-sdk-go/aws/ec2metadata

build: clean deps test
	@mkdir -p bin
	go build -v -o ./bin/truami 

clean:
	rm -dRf ./vendor/*
	rm -dRf ./bin/*

test:
	go test -cover

fmt:
	go fmt 

run: build
	./bin/truami

vendor_clean:
	rm -dRf ./_vendor/src

vet:
	go vet 

tag:
	@echo "Using tag: $(TAG)"

changelog:
	git log --oneline --decorate |awk 'NR==1,/$(RELTAG)/'

.PHONY: clean vet vendor_clean lint fmt test build build_linux build_static deps tag changelog
