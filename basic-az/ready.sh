#!/bin/bash

set -e

echo "Logging in to Azure using Service Principal..."
az login --service-principal \
  -u "$AZURE_CLIENT_ID" \
  -p "$AZURE_CLIENT_SECRET" \
  --tenant "$AZURE_TENANT_ID"

echo "Setting subscription..."
az account set --subscription "$AZURE_SUBSCRIPTION_ID"

echo "Creating resource group..."
az group create \
  --name "$RESOURCE_GROUP_NAME" \
  --location "$LOCATION"

echo "Azure setup completed successfully!"
