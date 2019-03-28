# Alternative implementation of CreateUser2.ps1
# that uses special variable $ark to set task's outputs individually

param (
    $UserName,
    $Email
)

Write-Host "CreateUser: name='$UserName' email='$Email'."

# Set each task output individually
$ark.Outputs.Status = 0 # using direct property assignment on hashtable
$ark.Outputs.Alias = $UserName
$ark.Outputs['Display'] = "User $UserName" # using indexer on hashtable
$ark.Outputs.Emails = @('email1@example.com', $Email) # store array in a hashtable
