targetScope = 'subscription'

// Parameters
// General
param location string
param tags object

// Resource Groups
param rgName string

// Deploy required Resource Groups
module odcRgInfra '../Templates/Bicep/ResourceGroup/ResourceGroup.bicep' = {
  name: 'Resource_Group_deployment'
  params: {
    resourceGroupName: rgName
    tags: tags
    location: location
  }
}
