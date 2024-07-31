#!/bin/bash

# Prompt the user for Access Key ID and Secret Access Key
read -s -p "Enter Access Key ID: " access_key_id
echo
read -s -p "Enter Secret Access Key: " secret_access_key
echo

# Specify the input file and output directory
input_file="secrets/raw/secret_aws_s3_techdocs.yaml"
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
sed "s|<secretvalue:RHDH_AWS_S3_TECHDOCS_ACCESS_KEY_ID>|$access_key_id|g; s|<secretvalue:RHDH_AWS_S3_TECHDOCS_SECRET_ACCESS_KEY>|$secret_access_key|g" "$input_file" > "$output_file"

# Print a success message
echo "Placeholders have been replaced successfully. Output file is located at $output_file."
