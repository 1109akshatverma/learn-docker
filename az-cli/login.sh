#!/bin/bash

# Load environment variables from .env file
ENV_FILE="$(dirname "$0")/../.env"

# Extract SPN credentials from environment variables
AZURE_CLIENT_ID="${AZURE_CLIENT_ID}"
AZURE_CLIENT_SECRET="${AZURE_CLIENT_SECRET}"
AZURE_TENANT_ID="${AZURE_TENANT_ID}"
AZURE_SUBSCRIPTION_ID="${AZURE_SUBSCRIPTION_ID}"

# Login using Azure CLI with Service Principal
echo "Logging in with Service Principal..."
az login --service-principal \
    -u "$AZURE_CLIENT_ID" \
    -p "$AZURE_CLIENT_SECRET" \
    --tenant "$AZURE_TENANT_ID"

echo "Successfully logged in with Service Principal"

# Set subscription
az account set --subscription "$AZURE_SUBSCRIPTION_ID"

# Define resource group and VM variables
RESOURCE_GROUP_NAME="${RESOURCE_GROUP_NAME:-rg-learn-docker}"
AZURE_LOCATION="${AZURE_LOCATION:-eastus}"
VM_NAME="${VM_NAME:-vm-windows-01}"
VM_SIZE="${VM_SIZE:-Standard_B2s}"
IMAGE_PUBLISHER="MicrosoftWindowsServer"
IMAGE_OFFER="WindowsServer"
IMAGE_SKU="${IMAGE_SKU:-2022-Datacenter}"
ADMIN_USERNAME="${ADMIN_USERNAME:-azureuser}"

echo "========================================"
echo "Creating Resources....................."
echo "========================================"

# Create Resource Group
echo "Creating resource group: $RESOURCE_GROUP_NAME in $AZURE_LOCATION..."
az group create \
    --name "$RESOURCE_GROUP_NAME" \
    --location "$AZURE_LOCATION"

echo "========================================"
echo "Resource group created successfully"
echo "========================================"

# Create Windows VM
echo "Creating Windows VM: $VM_NAME..."
az vm create \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --name "$VM_NAME" \
    --image "${IMAGE_PUBLISHER}:${IMAGE_OFFER}:${IMAGE_SKU}:latest" \
    --size "$VM_SIZE" \
    --admin-username "$ADMIN_USERNAME" \
    --generate-ssh-keys

echo "==============================================="
echo "Windows VM created successfully!"
echo "==============================================="
