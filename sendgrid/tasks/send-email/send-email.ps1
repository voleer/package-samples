[CmdletBinding()]
param (
    $ApiKey,
    $FromAddress,
    $ToAddress,
    $Subject,
    $Body
)

# Logging
Write-Information "Submitting email from='$FromAddress' to='$ToAddress' subject='$Subject'."

# If API key is not passed as input parameter, look for the key in the configuration
if (!$ApiKey) {
    # First, look for API key in workspace.package scope
    # If not present, also consider global.vendor scope
    $workspaceConfigFileUris = $context.GetFileUris("voleer://workspace.package/apiKey.txt")
    if ($workspaceConfigFileUris.Length -gt 0) {
        $ApiKey = $context.GetText("voleer://workspace.package/apiKey.txt")
        Write-Information "Using workspace.package SendGrid API key."
    }
    else {
        $ApiKey = $context.GetText("voleer://global.vendor/sendgrid.txt")
        Write-Information "Using global.vendor SendGrid API key."
    }
}
Write-Debug "apiKey='$ApiKey'."
if (!$ApiKey) {
    Write-Error "SendGrid API key is missing. It must be either provided to the task explicitly or stored in the configuration."
    exit
}

# Invoke SendGrid API
$headers = @{
    "authorization" = "Bearer $ApiKey";
    "content-type" = "application/json"
}

$request = @{
    "personalizations" = @(
        @{
            "to" = @(
                @{ "email" = $ToAddress; "name" = $ToAddress }
            );
            "subject" = $Subject
        }
    );
    "from" = @{
        "email" = $FromAddress;
        "name" = $FromAddress
    };
    "content" = @(
        @{
            "type" = "text/html";
            "value" = $Body
        }
    )
}
$requestText = $request | ConvertTo-Json -Depth 10

$ok = $false
try {
    Invoke-RestMethod -Uri "https://api.sendgrid.com/v3/mail/send" -Method Post -Headers $headers -Body $requestText
    $ok = $true
}
catch {
    Write-Warning "Exception: $_"
}

# Set task outputs
if ($context) {
    $context.Outputs.ok = $ok
}
