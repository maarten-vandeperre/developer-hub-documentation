#!/bin/bash

# Check if the oc command is available
if ! command -v oc &> /dev/null
then
    echo "oc command could not be found. Please install and configure the OpenShift CLI."
    exit 1
fi

# Get the base domain of the OpenShift cluster
BASE_DOMAIN=$(oc get ingresses.config/cluster -o jsonpath='{.spec.domain}'; echo)

if [ -z "$BASE_DOMAIN" ]; then
    echo "Failed to retrieve the OpenShift cluster base domain."
    exit 1
fi

# Define the placeholder to be replaced
PLACEHOLDER="apps.cluster-b97l9.dynamic.redhatworkshops.io"

# Find all files and replace the placeholder
find / -type f -exec sed -i.bak "s|$PLACEHOLDER|$BASE_DOMAIN|g" {} +

if [ $? -eq 0 ]; then
    echo "Successfully replaced the placeholder with the OpenShift cluster base domain in all files."
else
    echo "Failed to replace the placeholder in some files."
    exit 1
fi
