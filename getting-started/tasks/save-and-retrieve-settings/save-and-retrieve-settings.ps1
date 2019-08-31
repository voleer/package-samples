# Support for local debugging
$localContextPath = Join-Path $PSScriptRoot '..\local-context.ps1'
if (Test-Path $localContextPath) {
    . $localContextPath
}

# Call data exchange API
Write-Information "Saving instance settings"
$context.SaveText("voleer://workspace.instance/sample-settings.json", "Sample instance settings")

# Retrieve matching files
Write-Information "Retrieving matching files"
$uris = $context.GetFileUris("voleer://workspace.instance/sample-settings");
Write-Information "Retrieved file name:"
Write-Information $uris[0]

# Read back saved settings
$restoredValue = $context.GetText(uris[0])
Write-Verbose "Restored value:"
Write-Verbose $restoredValue

# Call data exchange API
Write-Information "Saving template settings"
$context.SaveText("voleer://workspace.template/sample-settings.json", "Sample template settings")

# Retrieve matching files
Write-Information "Retrieving matching files"
$uris = $context.GetFileUris("voleer://workspace.template/sample-settings");
Write-Information "Retrieved file name:"
Write-Information $uris[0]

# Read back saved settings
$restoredValue = $context.GetText(uris[0])
Write-Verbose "Restored value:"
Write-Verbose $restoredValue

# Call data exchange API
Write-Information "Saving package settings"
$context.SaveText("voleer://workspace.package/sample-settings.json", "Sample package settings")

# Retrieve matching files
Write-Information "Retrieving matching files"
$uris = $context.GetFileUris("voleer://workspace.package/sample-settings");
Write-Information "Retrieved file name:"
Write-Information $uris[0]

# Read back saved settings
$restoredValue = $context.GetText($uris[0])
Write-Verbose "Restored value:"
Write-Verbose $restoredValue

# Call data exchange API
Write-Information "Saving vendor settings"
$context.SaveText("voleer://workspace.vendor/sample-settings.json", "Sample vendor settings")

# Retrieve matching files
Write-Information "Retrieving matching files"
$uris = $context.GetFileUris("voleer://workspace.vendor/sample-settings");
Write-Information "Retrieved file name:"
Write-Information $uris[0]

# Read back saved settings
$restoredValue = $context.GetText($uris[0])
Write-Verbose "Restored value:"
Write-Verbose $restoredValue