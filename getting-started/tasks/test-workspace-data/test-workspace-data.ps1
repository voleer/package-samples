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

# Save and restore data
$context.Outputs.ok = $false
try {
    # Use workspace data API to save data
    $context.SaveText("voleer://workspace.public/WorkspaceApiTest.txt", $workspaceData)
    $context.SaveText("voleer://workspace.instance/WorkspaceApiTest.txt", $instanceData)
    $context.SaveText("voleer://workspace.template/WorkspaceApiTest.txt", $templateData)
    $context.SaveText("voleer://workspace.package/WorkspaceApiTest.txt", $packageData)
    $context.SaveText("voleer://workspace.vendor/WorkspaceApiTest.txt", $vendorData)

    # Use workspace data API to retrieve uris by prefix
    $workspaceUris = $context.GetFileUris("voleer://workspace.public/WorkspaceApiTest")
    $instanceUris = $context.GetFileUris("voleer://workspace.instance/WorkspaceApiTest")
    $templateUris = $context.GetFileUris("voleer://workspace.template/WorkspaceApiTest")
    $packageUris = $context.GetFileUris("voleer://workspace.package/WorkspaceApiTest")
    $vendorUris = $context.GetFileUris("voleer://workspace.vendor/WorkspaceApiTest")

    # Use workspace data API to retrieve data
    $restoredWorkspaceData = $context.GetText($workspaceUris[0])
    $restoredInstanceData = $context.GetText($instanceUris[0])
    $restoredTemplateData = $context.GetText($templateUris[0])
    $restoredPackageData = $context.GetText($packageUris[0])
    $restoredVendorData = $context.GetText($vendorUris[0])
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
