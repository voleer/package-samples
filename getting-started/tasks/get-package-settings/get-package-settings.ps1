[CmdletBinding()]
param ()

# Support for local debugging
$localContextPath = Join-Path $PSScriptRoot '..\local-context.ps1'
if (Test-Path $localContextPath) {
    . $localContextPath
}

# Logging
Write-Information "Retrieving settings for package 'getting-started'"

# Call data exchange API
$restoredValue = $context.GetPackageText("configuration.json")
Write-Verbose $restoredValue

# Set task outputs
$context.Outputs.ok = $false
try {
    if ($restoredValue) {
        $configObject = $restoredValue | ConvertFrom-Json
        $context.Outputs.ok = $true
        $context.Outputs.settings = $configObject
    }
}
catch {
    $errorMessage = "Error while parsing settings object: $_"
    Write-Warning $errorMessage
}
