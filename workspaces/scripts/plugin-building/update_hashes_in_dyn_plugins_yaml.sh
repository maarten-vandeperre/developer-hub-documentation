#!/bin/bash

#executed from the plugin root directory

# Paths to your files
HASHES_FILE="./hashes.txt"
YAML_FILE="../../../gitops/developer-hub/21_dynamic-plugins-rhdh.yaml"

# Read the hashes from the hashes.txt file
BACKEND_HASH=$(grep "Backend plugin integrity Hash" "$HASHES_FILE" | awk '{print $NF}')
FRONTEND_HASH=$(grep "Frontend plugin integrity Hash" "$HASHES_FILE" | awk '{print $NF}')

# Update the dynamic-plugins.yaml file with the new hash values
sed -i.bak "s|integrity: 'sha512-[^']*' #backend-hash|integrity: '$BACKEND_HASH' #backend-hash|" "$YAML_FILE"
sed -i.bak "s|integrity: 'sha512-[^']*' #frontend-hash|integrity: '$FRONTEND_HASH' #frontend-hash|" "$YAML_FILE"
rm "../../../gitops/developer-hub/21_dynamic-plugins-rhdh.yaml.bak"

# Feedback
echo "Updated hash values in $YAML_FILE."
