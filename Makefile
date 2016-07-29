KUBECTL_VERSION ?= 1.2.2
VERSION ?= 0.9.0
REPOSITORY ?= mumoshu/kubectl
TAG ?= $(KUBECTL_VERSION)-$(VERSION)
IMAGE ?= $(REPOSITORY):$(TAG)
ALIAS ?= $(REPOSITORY):$(KUBECTL_VERSION)
BUILD_ROOT ?= build/$(TAG)
DOCKERFILE ?= $(BUILD_ROOT)/Dockerfile

cross-build:
	for v in 1.2.{5..6} 1.3.{0..3}; do\
	  KUBECTL_VERSION=$$v sh -c 'echo $$KUBECTL_VERSION';\
	  KUBECTL_VERSION=$$v make build ;\
	done
cross-push:
	for v in 1.2.{5..6} 1.3.{0..3}; do\
	  KUBECTL_VERSION=$$v sh -c 'echo $$KUBECTL_VERSION';\
	  KUBECTL_VERSION=$$v make publish ;\
	done

.PHONY: build
build: $(DOCKERFILE)
	cd $(BUILD_ROOT) && docker build -t $(IMAGE) . && docker tag $(IMAGE) $(ALIAS)

publish:
	docker push $(IMAGE) && docker push $(ALIAS)

$(DOCKERFILE): $(BUILD_ROOT)
	sed 's/%%KUBECTL_VERSION%%/'"$(KUBECTL_VERSION)"'/g;' Dockerfile.template > $(DOCKERFILE)

$(BUILD_ROOT):
	mkdir -p $(BUILD_ROOT)

