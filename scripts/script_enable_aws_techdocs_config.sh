#!/bin/bash

# Specify the input file and output file
input_file="gitops/developer-hub/11_app-config-rhdh.yaml"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "Input file not found!"
  exit 1
fi

# Create a temporary file
tmp_file=$(mktemp)

# Process the file to replace the specified pattern
awk '
{
  # Check if the line contains the pattern
  if ($0 ~ /#if-aws-techdocs-disabled/) {
    # Extract leading whitespace
    match($0, /^ */)
    leading_whitespace = substr($0, RSTART, RLENGTH)
    # Replace pattern and append new pattern
    sub(/ *#if-aws-techdocs-disabled */, "")
    $0 = leading_whitespace $0 " \t\t\t\t\t\t\t\t\t\t\t\t\t\t#aws-techdocs-enabled"
  }
  print
}
' "$input_file" > "$tmp_file"

# Move the temporary file to overwrite the original file
mv "$tmp_file" "$input_file"

# Print a success message
echo "File has been processed successfully. Output file is located at $output_file."






# Specify the input file and output file
input_file="gitops/developer-hub/21_dynamic-plugins-rhdh.yaml"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "Input file not found!"
  exit 1
fi

# Create a temporary file
tmp_file=$(mktemp)

# Process the file to replace the specified pattern
awk '
{
  # Check if the line contains the pattern
  if ($0 ~ /#if-aws-techdocs-disabled/) {
    # Extract leading whitespace
    match($0, /^ */)
    leading_whitespace = substr($0, RSTART, RLENGTH)
    # Replace pattern and append new pattern
    sub(/ *#if-aws-techdocs-disabled */, "")
    $0 = leading_whitespace $0 " \t\t\t\t\t\t\t\t\t\t\t\t\t\t#aws-techdocs-enabled"
  }
  print
}
' "$input_file" > "$tmp_file"

# Move the temporary file to overwrite the original file
mv "$tmp_file" "$input_file"

# Print a success message
echo "File has been processed successfully. Output file is located at $output_file."






# Specify the input file and output file
input_file="gitops/developer-hub/31_developer-hub-instance.yaml"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "Input file not found!"
  exit 1
fi

# Create a temporary file
tmp_file=$(mktemp)

# Process the file to replace the specified pattern
awk '
{
  # Check if the line contains the pattern
  if ($0 ~ /#if-aws-techdocs-disabled/) {
    # Extract leading whitespace
    match($0, /^ */)
    leading_whitespace = substr($0, RSTART, RLENGTH)
    # Replace pattern and append new pattern
    sub(/ *#if-aws-techdocs-disabled */, "")
    $0 = leading_whitespace $0 " \t\t\t\t\t\t\t\t\t\t\t\t\t\t#aws-techdocs-enabled"
  }
  print
}
' "$input_file" > "$tmp_file"

# Move the temporary file to overwrite the original file
mv "$tmp_file" "$input_file"

# Print a success message
echo "File has been processed successfully. Output file is located at $output_file."
