# Alternative implementation of CreateUser.ps1
# that uses special variable $ark to return task's outputs

param (
    $UserName,
    $Email
)

Write-Host "CreateUser: name='$UserName' email='$Email'."

# Set task outputs based on hashtable
$result = @{
    Status = 0;
    Alias = $UserName;
    Display = "User $UserName";
    Emails = @('email1@example.com', $Email)
}
$ark.SetOutputs($result)

# Alternative: set output individually
$ark.SetOutput('Status', 1)
$ark.SetOutput('Alias', $UserName)
$ark.SetOutput('Display', "User $UserName")
$ark.SetOutput('Emails', @('email1@example.com', $Email))
