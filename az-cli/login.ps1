# Load environment variables from .env file
$envFilePath = Join-Path (Split-Path $PSScriptRoot) ".env"

# Extract SPN credentials from environment variables
$servicePrincipalId = $env:AZURE_CLIENT_ID
$servicePrincipalPassword = $env:AZURE_CLIENT_SECRET
$tenantId = $env:AZURE_TENANT_ID
$subscriptionId = $env:AZURE_SUBSCRIPTION_ID

# Login using Azure CLI with Service Principal
Write-Host "Logging in with Service Principal..."
$credential = New-Object System.Management.Automation.PSCredential($servicePrincipalId, (ConvertTo-SecureString $servicePrincipalPassword -AsPlainText -Force))

az login --service-principal `
    -u $servicePrincipalId `
    -p $servicePrincipalPassword `
    --tenant $tenantId

Write-Host "Successfully logged in with Service Principal"

# Set subscription
az account set --subscription $subscriptionId

# Define resource group and VM variables
$resourceGroupName = $env:RESOURCE_GROUP_NAME -or "rg-learn-docker"
$location = $env:AZURE_LOCATION -or "eastus"
$vmName = $env:VM_NAME -or "vm-windows-01"
$vmSize = $env:VM_SIZE -or "Standard_B2s"
$imagePublisher = "MicrosoftWindowsServer"
$imageOffer = "WindowsServer"
$imageSku = $env:IMAGE_SKU -or "2022-Datacenter"
$adminUsername = $env:ADMIN_USERNAME -or "demouser"

Write-Host "========================================"
Write-Host "Creating Resources"
Write-Host "========================================"

# Create Resource Group
Write-Host "Creating resource group: $resourceGroupName in $location..."
az group create `
    --name $resourceGroupName `
    --location $location

Write-Host "Resource group created successfully"

# Create Windows VM
Write-Host "Creating Windows VM: $vmName..."
az vm create `
    --resource-group $resourceGroupName `
    --name $vmName `
    --image "${imagePublisher}:${imageOffer}:${imageSku}:latest" `
    --size $vmSize `
    --admin-username $adminUsername `
    --generate-ssh-keys

Write-Host "==============================================="
Write-Host "Windows VM created successfully!"
Write-Host "Resource Group: $resourceGroupName"
Write-Host "VM Name: $vmName"
Write-Host "Location: $location"
Write-Host "VM Size: $vmSize"
Write-Host "==============================================="
