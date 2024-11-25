targetScope = 'subscription'

param resourceGroupName string 
param location string
param tags object

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

output resourcegroupid string = resourceGroup.id
