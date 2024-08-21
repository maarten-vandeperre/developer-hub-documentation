#!/bin/bash

# Specify the input file
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
  # Check if the line ends with the pattern
  if ($0 ~ /#minio-techdocs-enabled$/) {
    # Extract leading whitespace
    match($0, /^ */)
    leading_whitespace = substr($0, RSTART, RLENGTH)
    # Remove leading whitespace from the line and append #if-minio-techdocs-disabled
    sub(/^ */, "")
    $0 = leading_whitespace "#if-minio-techdocs-disabled " $0
    # Remove the #minio-techdocs-enabled from the end of the line
    sub(/[\t ]+#minio-techdocs-enabled$/, "")
  }
  print
}
' "$input_file" > "$tmp_file"

# Move the temporary file to overwrite the original file
mv "$tmp_file" "$input_file"

# Print a success message
echo "File has been processed successfully. Modifications have been made in-place in $input_file."





# Specify the input file
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
  # Check if the line ends with the pattern
  if ($0 ~ /#minio-techdocs-enabled$/) {
    # Extract leading whitespace
    match($0, /^ */)
    leading_whitespace = substr($0, RSTART, RLENGTH)
    # Remove leading whitespace from the line and append #if-minio-techdocs-disabled
    sub(/^ */, "")
    $0 = leading_whitespace "#if-minio-techdocs-disabled " $0
    # Remove the #minio-techdocs-enabled from the end of the line
    sub(/[\t ]+#minio-techdocs-enabled$/, "")
  }
  print
}
' "$input_file" > "$tmp_file"

# Move the temporary file to overwrite the original file
mv "$tmp_file" "$input_file"

# Print a success message
echo "File has been processed successfully. Modifications have been made in-place in $input_file."





# Specify the input file
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
  # Check if the line ends with the pattern
  if ($0 ~ /#minio-techdocs-enabled$/) {
    # Extract leading whitespace
    match($0, /^ */)
    leading_whitespace = substr($0, RSTART, RLENGTH)
    # Remove leading whitespace from the line and append #if-minio-techdocs-disabled
    sub(/^ */, "")
    $0 = leading_whitespace "#if-minio-techdocs-disabled " $0
    # Remove the #minio-techdocs-enabled from the end of the line
    sub(/[\t ]+#minio-techdocs-enabled$/, "")
  }
  print
}
' "$input_file" > "$tmp_file"

# Move the temporary file to overwrite the original file
mv "$tmp_file" "$input_file"

# Print a success message
echo "File has been processed successfully. Modifications have been made in-place in $input_file."
