# learn-docker

Learn Docker and Azure CLI automation scripts

## Azure CLI Login & VM Creation Script

### Prerequisites
- Azure CLI installed on your system
- Azure Service Principal credentials
- **For PowerShell**: PowerShell 7+ (or Windows PowerShell)
- **For Bash**: Bash shell on Linux/macOS/WSL

### Setup Instructions

1. **Create a .env file** in the root directory with your Azure credentials:
   ```
   AZURE_CLIENT_ID=your-client-id
   AZURE_CLIENT_SECRET=your-client-secret
   AZURE_TENANT_ID=your-tenant-id
   AZURE_SUBSCRIPTION_ID=your-subscription-id
   
   AZURE_LOCATION=eastus
   RESOURCE_GROUP_NAME=rg-learn-docker
   VM_NAME=vm-windows-01
   VM_SIZE=Standard_B2s
   IMAGE_SKU=2022-Datacenter
   ADMIN_USERNAME=azureuser
   ```
   
   Or copy from `.env.example`:
   ```bash
   cp .env.example .env
   # Edit .env with your credentials
   ```

2. **Run the login script**:

   **For PowerShell (Windows)**:
   ```powershell
   pwsh ./az-cli/login.ps1
   ```
   
   **For Bash (Linux/macOS/WSL)**:
   ```bash
   bash ./az-cli/login.sh
   ```

### What the Script Does

1. **Loads Environment Variables**: Reads credentials and configuration from `.env` file
2. **Azure CLI Authentication**: Logs in using Service Principal (SPN) credentials
3. **Creates Resource Group**: Sets up a new Azure resource group
4. **Creates Windows VM**: Deploys a Windows Server 2022 virtual machine

### Environment Variables

- `AZURE_CLIENT_ID`: Service Principal Client ID
- `AZURE_CLIENT_SECRET`: Service Principal Client Secret
- `AZURE_TENANT_ID`: Azure Tenant ID
- `AZURE_SUBSCRIPTION_ID`: Target Azure Subscription ID
- `AZURE_LOCATION`: Azure region (default: eastus)
- `RESOURCE_GROUP_NAME`: Resource group name (default: rg-learn-docker)
- `VM_NAME`: Virtual machine name (default: vm-windows-01)
- `VM_SIZE`: VM size SKU (default: Standard_B2s)
- `IMAGE_SKU`: Windows Server SKU (default: 2022-Datacenter)
- `ADMIN_USERNAME`: VM admin username (default: azureuser)