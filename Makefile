ALPINE_VERSION := latest
CONTAINER_ORGANIZATION := connectical
CONTAINER_IMAGE := tor
CONTAINER_ARCHITECTURES := linux/amd64,linux/arm64,linux/arm/v7
TAGS := -t quay.io/$(CONTAINER_ORGANIZATION)/$(CONTAINER_IMAGE):latest
TAGS += -t registry.gitlab.com/$(CONTAINER_ORGANIZATION)/container/$(CONTAINER_IMAGE):latest

all: build

build:
	docker build -t $(CONTAINER_ORGANIZATION)/$(CONTAINER_IMAGE) --build-arg ALPINE_VERSION=$(ALPINE_VERSION) .

build-multiarch:
	docker buildx build -t $(CONTAINER_ORGANIZATION)/$(CONTAINER_IMAGE) --platform $(CONTAINER_ARCHITECTURES) --build-arg ALPINE_VERSION=$(ALPINE_VERSION) .

.PHONY: all build build-multiarch
# vim:ft=make
