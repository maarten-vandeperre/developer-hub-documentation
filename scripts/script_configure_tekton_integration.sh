#!/bin/bash

service_account_name="pipeline"

oc adm policy add-role-to-user view -z $service_account_name -n demo-project
oc create token pipeline -n demo-project
tekton_service_account_token=$(oc get secret argocd-instance-cluster -n demo-project -o template --template='{{index .data "admin.password"}}' | base64 -d ; echo )

# Specify the input file and output directory
input_file="secrets/raw/secret_tekton.yaml"
output_dir="secrets/generated"
output_file="${output_dir}/$(basename $input_file)"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "Input file not found!"
  exit 1
fi

# Create the output directory if it doesn't exist
if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
fi

# Replace placeholders and direct output to the specified directory
sed -e "s|<secretvalue:RHDH_TEKTON_SERVICE_ACCOUNT_TOKEN>|$tekton_service_account_token|g" "$input_file" > "$output_file"

# Print a success message
echo "Placeholders have been replaced successfully. Output file is located at $output_file."
