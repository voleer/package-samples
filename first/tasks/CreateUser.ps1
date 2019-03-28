param (
    $UserName,
    $Email
)

Write-Host "CreateUser: name='$UserName' email='$Email'."

# Values in the hashtable will be mapped to the corresponding output values
return @{
    Status = 0;
    Alias = $UserName;
    Display = "User $UserName";
    Emails = @('email1@example.com', $Email)
}
