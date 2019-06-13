[CmdletBinding()]
param ()

# Support for local debugging
$localContextPath = Join-Path $PSScriptRoot '..\local-context.ps1'
if (Test-Path $localContextPath) {
    . $localContextPath
}

# Logging
Write-Information "Testing workspace data API for package 'getting-started'"

# Generate random data for testing
$testData = get-date -UFormat "%Y-%m-%d-%H:%M:%S"
$workspaceData = "workspace: " + $testData
$instanceData = "instance: " + $testData
$templateData = "template: " + $testData
$packageData = "package: " + $testData
$vendorData = "vendor: " + $testData
$path = "WorkspaceApiTest.txt"

# Save and restore data
$context.Outputs.ok = $false
try {
    # Use workspace data API to save data
    $context.SaveWorkspaceText($path, $workspaceData)
    $context.SaveInstanceText($path, $instanceData)
    $context.SaveTemplateText($path, $templateData)
    $context.SavePackageText($path, $packageData)
    $context.SaveVendorText($path, $vendorData)

    # Use workspace data API to retrieve data
    $restoredWorkspaceData = $context.GetWorkspaceText($path)
    $restoredInstanceData = $context.GetInstanceText($path)
    $restoredTemplateData = $context.GetTemplateText($path)
    $restoredPackageData = $context.GetPackageText($path)
    $restoredVendorData = $context.GetVendorText($path)
    Write-Verbose "Restored workspace value: $restoredWorkspaceData"
    Write-Verbose "Restored instance value: $restoredInstanceData"
    Write-Verbose "Restored template value: $restoredTemplateData"
    Write-Verbose "Restored package value: $restoredPackageData"
    Write-Verbose "Restored vendor value: $restoredVendorData"

    # Check that retrieved data matches original values
    $match = $workspaceData -eq $restoredWorkspaceData
    $match = $match -and ($instanceData -eq $restoredInstanceData)
    $match = $match -and ($templateData -eq $restoredTemplateData)
    $match = $match -and ($packageData -eq $restoredPackageData)
    $match = $match -and ($vendorData -eq $restoredVendorData)
    $context.Outputs.ok = $match
}
catch {
    Write-Warning "Unexpected error: $_"
}
