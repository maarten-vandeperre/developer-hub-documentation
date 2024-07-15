#!/bin/bash
sh prepare_repository.sh
oc apply -f gitops/namespaces.yaml

# operators
oc apply -f gitops/keycloak/keycloak-operator.yaml

# keycloak
oc apply -f gitops/keycloak/keycloak-postgres.yaml
oc apply -f gitops/keycloak/keycloak-instance.yaml
oc apply -f gitops/keycloak/keycloak-realm.yaml