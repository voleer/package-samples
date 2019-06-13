[CmdletBinding()]
param ([string]$Username, [string]$Password)

# Support for local debugging
$localContextPath = Join-Path $PSScriptRoot '..\local-context.ps1'
if (Test-Path $localContextPath) {
    . $localContextPath
}

# Logging
Write-Information "Saving settings for package 'getting-started'"
Write-Verbose "Username: '$Username'"

# Call data exchange API
$settings = @{
    username = $Username;
    password = $Password
}
$context.SavePackageText("configuration.json", ($settings | ConvertTo-Json -Compress))

# Test reading configuration back
$restoredValue = $context.GetPackageText("configuration.json")
Write-Verbose "Restored value:"
Write-Verbose $restoredValue
