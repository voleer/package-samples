<#
.Description
Defines a version of Voleer context suitable for local debugging.
#>

# Helper method to join multiple paths.
function JoinPaths([string]$root, $parts) {
    $parts | ForEach-Object { $root = Join-Path $root $_ }
    return $root
}

# Determine name of the package that is calling this
if (Test-Path $MyInvocation.PSScriptRoot) {
    $packageManifestPath = Resolve-Path (JoinPaths $MyInvocation.PSScriptRoot "..","..","voleer.json")
    Write-Debug "Package root: $packageManifestPath"
    if (Test-Path $packageManifestPath) {
        $packageManifest = Get-Content $packageManifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
        $script:VoleerPackageName = $packageManifest.name
        $script:VoleerPackageVersion = $packageManifest.version
        Write-Verbose "Local context initializing for package '$script:VoleerPackageName' version '$script:VoleerPackageVersion'"
    }
}

# Declare context implementation class
class VoleerLocalContext {
    # Hashtable that contains task outputs
    [hashtable] $Outputs

    # Constructor
    VoleerLocalContext() {
        # Initialize Outputs to empty hashtable
        $this.Outputs = @{}
    }

    # Saves specified text value under "Package" scope.
    [void] SavePackageText([string]$path, [string]$value) {
        $this.InternalSaveText("package", $this.GetPackagePath(), $path, $value)
    }

    # Retrieves text value for a given path under "Package" scope.
    [string] GetPackageText([string]$path) {
        return $this.InternalGetText("package", $this.GetPackagePath(), $path)
    }

    # Internal implementation method.
    # Returns 'scope path' for the current package.
    hidden [string] GetPackagePath() {
        return JoinPaths "package" $script:VoleerPackageName
    }

    # Internal implementation method.
    # Determines full path where data is located based on 'scope path' and logical path specified by the caller.
    hidden [string] GetStoragePath([string]$scopePath, [string]$path) {
        $storageRoot = JoinPaths $env:USERPROFILE ".voleer","storage"
        $scopeRoot = Join-Path $storageRoot $scopePath
        $fullPath = Join-Path $scopeRoot $path
        return $fullPath
    }

    # Internal implementation method.
    # Saves text value to a local storage.
    hidden [void] InternalSaveText([string]$scopeType, [string]$scopePath, [string]$path, [string]$value) {
        Write-Verbose "Saving value of type '$scopeType' to path '$path'"
        $fullPath = $this.GetStoragePath($scopePath, $path)
        Write-Debug "Local path: $fullPath"

        # Create folder if necessary
        $folderPath = Split-Path $fullPath -Parent
        if (!(Test-Path $folderPath)) {
            New-Item -Path $folderPath -ItemType Directory -Force
        }

        # Write value
        Out-File -FilePath $fullPath -Encoding utf8 -InputObject $value
    }

    # Internal implementation method.
    # Retrieves value from a local storage.
    hidden [string] InternalGetText([string]$scopeType, [string]$scopePath, [string]$path) {
        Write-Verbose "Retrieving value of type '$scopeType' from path '$path'"
        $fullPath = $this.GetStoragePath($scopePath, $path)
        Write-Debug "Local path: $fullPath"

        # Return $null is data file is missing
        if (!(Test-Path $fullPath)) {
            return $null
        }

        # Read value
        $content = Get-Content -LiteralPath $fullPath -Encoding utf8 -Raw
        Write-Verbose "Retrieved value of length $($content.Length)"
        return $content
    }
}

# Make sure there is an instance of Voleer context in a global scope
# Create new instance if context is left from prior execution of this script
if (!$global:context -or
    $global:context.GetType().Name -eq 'VoleerLocalContext') {
    # Create new instance of local context
    $global:context = [VoleerLocalContext]::new()
    Write-Debug "Initialized new instance of local Voleer context."
} else {
    # Use existing context
    Write-Debug "Using context of type $($global:context.GetType().Name)"
}
