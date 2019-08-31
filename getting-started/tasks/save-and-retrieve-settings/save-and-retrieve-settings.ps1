# Support for local debugging
$localContextPath = Join-Path $PSScriptRoot '..\local-context.ps1'
if (Test-Path $localContextPath) {
    . $localContextPath
}

# Log
Write-Information "Saving instance settings"

# Call data exchange API
$context.SaveText("voleer://workspace.instance/sample-settings.json", "Sample instance settings")

# Read back saved settings back
$restoredValue = $context.GetText("voleer://workspace.instance/sample-settings.json")
Write-Verbose "Restored value:"
Write-Verbose $restoredValue

# Log
Write-Information "Saving template settings"

# Call data exchange API
$context.SaveText("voleer://workspace.template/sample-settings.json", "Sample template settings")

# Read back saved settings back
$restoredValue = $context.GetText("voleer://workspace.template/sample-settings.json")
Write-Verbose "Restored value:"
Write-Verbose $restoredValue

# Log
Write-Information "Saving package settings"

# Call data exchange API
$context.SaveText("voleer://workspace.package/sample-settings.json", "Sample package settings")

# Read back saved settings back
$restoredValue = $context.GetText("voleer://workspace.package/sample-settings.json")
Write-Verbose "Restored value:"
Write-Verbose $restoredValue

# Log
Write-Information "Saving vendor settings"

# Call data exchange API
$context.SaveText("voleer://workspace.vendor/sample-settings.json", "Sample vendor settings")

# Read back saved settings back
$restoredValue = $context.GetText("voleer://workspace.vendor/sample-settings.json")
Write-Verbose "Restored value:"
Write-Verbose $restoredValue