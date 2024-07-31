#!/bin/bash

read -s -p "Enter Personal Access Token: " personal_access_token
echo
read -s -p "Enter Application ID: " application_id
echo
read -s -p "Enter Client ID: " client_id
echo
read -s -p "Enter Client Secret: " client_secret
echo
echo "Enter Application Private Key (Press Enter twice to finish):"
private_key=""
while IFS= read -r line; do
  [ -z "$line" ] && break
  private_key="${private_key}\n${line}"
done

# Remove the leading newline from the private key
private_key="${private_key#\\n}"

# Specify the input file and output directory
input_file="secrets/raw/secret_github_integration.yaml"
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
sed -e "s|<secretvalue:RHDH_GITHUB_INTEGRATION_PERSONAL_ACCESS_TOKEN>|$personal_access_token|g" \
    -e "s|<secretvalue:RHDH_GITHUB_INTEGRATION_APP_ID>|$application_id|g" \
    -e "s|<secretvalue:RHDH_GITHUB_INTEGRATION_APP_CLIENT_ID>|$client_id|g" \
    -e "s|<secretvalue:RHDH_GITHUB_INTEGRATION_APP_CLIENT_SECRET>|$client_secret|g" \
    -e "s|<secretvalue:RHDH_GITHUB_INTEGRATION_APP_PRIVATE_KEY>|$private_key|g" "$input_file" > "$output_file"

# Print a success message
echo "Placeholders have been replaced successfully. Output file is located at $output_file."
