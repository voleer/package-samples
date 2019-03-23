<#
.Description
Package initialization script.

Contains any initialization and configuration commands that
should be executed before any of the tasks are launched.
#>

# Install modules
Install-Module -Name AzureRM -RequiredVersion 6.13.1

# Download some extra stuff, install an msi, run something using one of the above modules, whatever
# ...