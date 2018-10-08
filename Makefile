TAG ?= latest

# crd.Makefile provides targets to install Application CRD.
include ./marketplace-tools/crd.Makefile

# gcloud.Makefile provides default values for
# REGISTRY and NAMESPACE derived from local
# gcloud and kubectl environments.
include ./marketplace-tools/gcloud.Makefile

# marketplace.Makefile provides targets such as
# ".build/marketplace/deployer/envsubst" to build the base
# deployer images locally.
#include ./marketplace-tools/marketplace.Makefile

include ./marketplace-tools/var.Makefile

# app.Makefile provides the main targets for installing the
# application.
# It requires several APP_* variables defined as followed.
include ./marketplace-tools/app.Makefile

APP_DEPLOYER_IMAGE ?= $(REGISTRY)/cloudbees-core/deployer:$(TAG)
NAME ?= cloudbees-core-1
APP_PARAMETERS ?= { \
  "name": "$(NAME)", \
  "namespace": "$(NAMESPACE)" \
}

# Extend the target as defined in app.Makefile to
# include real dependencies.
#app/build:: .build/deployer \
#            .build/wordpress/init \
#            .build/wordpress/mysql \
#            .build/wordpress/tester \
#            .build/wordpress/wordpress


#.build/wordpress: | .build
#	mkdir -p "$@"

#.build/wordpress/deployer: apptest/deployer/* \
#                           apptest/deployer/manifest/* \
#                           deployer/* \
#                           manifest/* \
#                           schema.yaml \
#                           .build/marketplace/deployer/envsubst \
#                           .build/var/APP_DEPLOYER_IMAGE \
#                           .build/var/REGISTRY \
#                           .build/var/TAG \
#                           | .build/wordpress
#	$(call print_target, $@)
#	docker build \
#	    --build-arg REGISTRY="$(REGISTRY)/example/wordpress" \
#	    --build-arg TAG="$(TAG)" \
#	    --tag "$(APP_DEPLOYER_IMAGE)" \
#	    -f deployer/Dockerfile \
#	    .
#	docker push "$(APP_DEPLOYER_IMAGE)"
#	@touch "$@"


#.build/wordpress/tester:
#	$(call print_target, $@)
#	docker pull cosmintitei/bash-curl
#	docker tag cosmintitei/bash-curl "$(TESTER_IMAGE)"
#	docker push "$(TESTER_IMAGE)"
#	@touch "$@"

# Simulate building of primary app image. Actually just copying public image to
# local registry.
#.build/wordpress/wordpress: .build/var/REGISTRY \
#                            .build/var/TAG \
#                            | .build/wordpress
#	$(call print_target, $@)
#	docker pull launcher.gcr.io/google/wordpress4-php5-apache
#	docker tag launcher.gcr.io/google/wordpress4-php5-apache "$(REGISTRY)/example/wordpress:$(TAG)"
#	docker push "$(REGISTRY)/example/wordpress:$(TAG)"
#	@touch "$@"



