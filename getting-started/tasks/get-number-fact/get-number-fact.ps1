[CmdletBinding()]
param ([string]$Number, [string]$Type)

# Support for local debugging
$localContextPath = Join-Path $PSScriptRoot '..\local-context.ps1'
if (Test-Path $localContextPath) {
    . $localContextPath
}

# Handle default values for task inputs
if ($Number -eq '') {
    # Select random number if no input has been specified
    $Number = 'random'
} elseif ($Number -ieq 'today') {
    # Format value as 'month/day' format for today
    $Number = get-date -UFormat '%m/%d'
}
if ($Type -eq '') {
    # Select trivia type by default
    $Type = 'trivia'
}

# Logging
Write-Information "Getting facts about number '$Number', type '$Type'."

# Call 'numbers' API
$uri = "http://numbersapi.com/$($Number)/$($Type)?json"
Write-Verbose "URI: '$uri'"
try {
    $response = Invoke-RestMethod -Uri $uri -Method Get
    $fact = $response.text
    Write-Host $fact -ForegroundColor Green
}
catch {
    $fact = "Could not find facts of type '$Type' about '$Number'."
    Write-Warning $fact
}

# Set outputs
if ($context) {
    $context.Outputs.Result = $fact
}
