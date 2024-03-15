#!/bin/bash

# Define variables
PROJECT_NAME="stateless-infra"
MODULES_DIR="modules"
ENVIRONMENTS_DIR="environments"
CONFIG_DIR="config"
MAIN_FILE="main.tf"
VARIABLES_FILE="variables.tf"
OUTPUTS_FILE="outputs.tf"

# Create main project directory
mkdir -p "$PROJECT_NAME/$MODULES_DIR"
mkdir -p "$PROJECT_NAME/$ENVIRONMENTS_DIR"
mkdir -p "$PROJECT_NAME/$CONFIG_DIR"

# Create files within the project directory
touch "$PROJECT_NAME/$MAIN_FILE"
touch "$PROJECT_NAME/$VARIABLES_FILE"
touch "$PROJECT_NAME/$OUTPUTS_FILE"

# Create README file
cat <<EOF > "$PROJECT_NAME/README.md"
# Terraform Project: $PROJECT_NAME

This directory contains Terraform configurations for the project "$PROJECT_NAME".

## Structure
- \`$MODULES_DIR\`: Contains reusable modules.
- \`$ENVIRONMENTS_DIR\`: Contains environment-specific configurations.
- \`$CONFIG_DIR\`: Contains additional configuration files.

## Files
- \`$MAIN_FILE\`: Main Terraform configuration file.
- \`$VARIABLES_FILE\`: Terraform variables file.
- \`$OUTPUTS_FILE\`: Terraform outputs file.
EOF

# Provide instructions
echo "Terraform project directory structure created for project: $PROJECT_NAME"
echo "You can find the structure and files in the directory: $PROJECT_NAME"
