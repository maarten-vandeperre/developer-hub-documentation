#!/bin/bash

# Uses "npm pack" to to create .tgz files containing the plugin static assets
DYNAMIC_PLUGIN_ROOT_DIR=./deploy
echo ""
echo "Packaging up plugin static assets"
echo ""

#BACKEND_INTEGRITY_HASH=$(npm pack plugins/simple-chat-backend/dist-dynamic --pack-destination $DYNAMIC_PLUGIN_ROOT_DIR --json | jq -r '.[0].integrity') &&
#    echo "Backend plugin integrity Hash: $BACKEND_INTEGRITY_HASH"

ANSIBLE_SELF_SERVICE_FE_HASH=$(npm pack plugins/ansible-self-service/dist-dynamic --pack-destination $DYNAMIC_PLUGIN_ROOT_DIR --json | jq -r '.[0].integrity') &&
    echo "Frontend plugin integrity Hash: $ANSIBLE_SELF_SERVICE_FE_HASH"

#CUS_AC_ARGO_CREATERESOURCES_INTEGRITY_HASH=$(npm pack plugins/scaffolder-backend-module-custom-action-argocd-create-resources/dist-dynamic --pack-destination $DYNAMIC_PLUGIN_ROOT_DIR --json | jq -r '.[0].integrity') &&
#    echo "Custom Action ArgoCD Create Resources plugin integrity Hash: $CUS_AC_ARGO_CREATERESOURCES_INTEGRITY_HASH"
#
#KEYCLOAK_INTEGRITY_HASH=$(npm pack plugins/keycloak-backend/dist-dynamic --pack-destination $DYNAMIC_PLUGIN_ROOT_DIR --json | jq -r '.[0].integrity') &&
#    echo "Keycloak plugin integrity Hash: $KEYCLOAK_INTEGRITY_HASH"

echo ""
echo "Plugin .tgz files:"
ls -l $DYNAMIC_PLUGIN_ROOT_DIR

echo ""

#echo "Backend plugin integrity Hash: $BACKEND_INTEGRITY_HASH\nFrontend plugin integrity Hash: $ANSIBLE_SELF_SERVICE_FE_HASH\nKeycloak plugin integrity Hash: $KEYCLOAK_INTEGRITY_HASH\nCustom Action ArgoCD Create Resources plugin integrity Hash: $CUS_AC_ARGO_CREATERESOURCES_INTEGRITY_HASH" > hashes.txt
echo "Ansible self service frontend plugin integrity Hash: $ANSIBLE_SELF_SERVICE_FE_HASH" > hashes.txt