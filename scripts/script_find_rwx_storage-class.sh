#!/bin/bash

# Initialize the result variable
result="storage-class-not-found"

# Define the list of storage class names to check
storage_classes=(
    "openshift-storage.noobaa.io" # on AWS
)

# Loop over all storage classes
for sc in $(oc get storageclass -o jsonpath='{.items[*].metadata.name}'); do
  # Check if the storage class name is in the predefined list
  for predefined_sc in "${storage_classes[@]}"; do
    if [ "$sc" == "$predefined_sc" ]; then
      result=$sc
      break 2
    fi
  done
done

# Output the result
echo $result
