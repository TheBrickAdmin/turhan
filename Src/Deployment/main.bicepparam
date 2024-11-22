using './main.bicep'

// General
param location = 'westeurope'
param tags = {
  Owner   : 'Turhan'
  Purpose : 'Testing'
}

// Resource Groups
param rgName = 'DEMO'
