#!/bin/bash

defaultDockerSecret=$(oc get secrets -n demo-project | grep default-docker | awk '{print $1}')
dockerToken=$(oc get secret $defaultDockerSecret -n demo-project -o template --template='{{index .data ".dockercfg"}}' ; echo )
sed -i.bak -E "s|(.dockercfg: ).*|\1$dockerToken|g" "gitops/3scale/3scale-secret-registry-auth.yaml"
rm gitops/3scale/3scale-secret-registry-auth.yaml.bak