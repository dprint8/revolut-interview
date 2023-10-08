# Makefile
VERSION := $(shell cat VERSION)

DOCKER_IMAGE_NAME = hello

# Docker tags
DOCKER_IMAGE_TAG_VERSIONED = $(DOCKER_IMAGE_NAME):$(VERSION)
DOCKER_IMAGE_TAG_LATEST = $(DOCKER_IMAGE_NAME):latest

build:
	docker build -t $(DOCKER_IMAGE_TAG_VERSIONED) .

tag:
	docker tag $(DOCKER_IMAGE_TAG_VERSIONED) $(DOCKER_IMAGE_TAG_LATEST)

push:
	$(shell aws ecr get-login --no-include-email --region eu-west-1)
	docker push $(DOCKER_IMAGE_TAG_VERSIONED)
	docker push $(DOCKER_IMAGE
