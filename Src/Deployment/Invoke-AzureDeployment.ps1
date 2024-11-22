[CmdletBinding()]
param ()

# The following 'Requires' statements may slow down the initial start of this script.
# After validating all requirements are present, this section can be commented out to prevent performance impact.
# The dependencies in this script require PowerShell 7.3 or greater
#Requires -Version 7.3.0

# This script requires the following modules
#Requires -Modules @{ ModuleName="Az.Accounts"; ModuleVersion="3.0.0"}
#Requires -Modules @{ ModuleName="Az.Resources"; ModuleVersion="7.2.0"}
#Requires -Modules @{ ModuleName="Bicep"; ModuleVersion="2.5.0"}
#Requires -Modules @{ ModuleName="Microsoft.Graph"; ModuleVersion="2.20.0"}

# Variables
$scriptDirectory     = Split-Path -Path ($MyInvocation.MyCommand.Path)
$rootDirectory       = (Get-Item -Path $scriptDirectory).Parent.FullName
$bicepParametersPath = Join-Path -Path $scriptDirectory -ChildPath "main.bicepparam"
$bicepMainPath       = Join-Path -Path $scriptDirectory -ChildPath "main.bicep"
$functionsPath       = Join-Path -Path $rootDirectory -ChildPath "PowerShell\Modules\Functions.ps1"

# Retrieve required parameters from main.bicepparam
$bicepParameters = [System.IO.File]::ReadAllLines($bicepParametersPath)
foreach ($line in $bicepParameters)
{
    if ($line -match "param location\s+= '(.+)'")
    {
        $location = $Matches[1]
    }
}

# Load helper functions
. $functionsPath

# Setup connections
Connect-AzAccount
Connect-MgGraph -Scopes "" -NoWelcome # Add required scopes

# Create the Resource Groups and any specified resources
New-AzDeployment -TemplateFile $bicepMainPath -TemplateParameterFile $bicepParametersPath -Location $location
