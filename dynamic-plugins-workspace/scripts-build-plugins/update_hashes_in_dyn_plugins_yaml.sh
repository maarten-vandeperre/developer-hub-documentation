#!/bin/bash

#executed from the plugin root directory

# Paths to your files
HASHES_FILE="./hashes.txt"
YAML_FILE="../../gitops/developer-hub/21_dynamic-plugins-rhdh.yaml"

# Read the hashes from the hashes.txt file
ANSIBLE_SELF_SERVICE_FE_HASH=$(grep "Ansible self service frontend plugin integrity Hash" "$HASHES_FILE" | awk '{print $NF}')

# Update the dynamic-plugins.yaml file with the new hash values
sed -i.bak "s|integrity: 'sha512-[^']*' #ansible-self-service-frontend-hash|integrity: '$ANSIBLE_SELF_SERVICE_FE_HASH' #ansible-self-service-frontend-hash|" "$YAML_FILE"
rm "../../gitops/developer-hub/21_dynamic-plugins-rhdh.yaml.bak"

# Feedback
echo "Updated hash values in $YAML_FILE."
