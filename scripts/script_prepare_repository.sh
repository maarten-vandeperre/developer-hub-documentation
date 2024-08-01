#!/bin/bash

# Function definitions
            # Function to trim whitespace
            trim_whitespace() {
                echo "$1" | sed 's/^[ \t]*//;s/[ \t]*$//'
            }

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
# !!! this one will change to the new domain as well (when running the script), so it will keep up to date
PLACEHOLDER=$(cat .namespace)
PLACEHOLDER=$(trim_whitespace "$PLACEHOLDER")
ESCAPED_PLACEHOLDER=$(echo "$PLACEHOLDER" | sed 's/\./\\./g')

# Find all files and replace the placeholder
  #Linux
  # find . -type f -exec sed -i.bak "s|$ESCAPED_PLACEHOLDER|$BASE_DOMAIN|g" {} +
  # Mac
  LC_CTYPE=C && LANG=C && find . -type f  ! -name .namespace -exec sed -i.bak "s|$ESCAPED_PLACEHOLDER|$BASE_DOMAIN|g" {} +

if [ $? -eq 0 ]; then
    echo "Successfully replaced the placeholder with the OpenShift cluster base domain in all files."
else
    echo "Failed to replace the placeholder in some files."
    exit 1
fi

echo $BASE_DOMAIN > .namespace

# Delete all .bak files in the current directory and its subdirectories
find . -type f -name "*.bak" -exec rm -f {} \;
echo "All .bak files have been deleted."
