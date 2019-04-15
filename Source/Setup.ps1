<#
	.Synopsis
	Solution Setup Script

	.Description
	Configures the system with dependencies required build the solution.
#>

#region Globals.

# Options.
Set-StrictMode -Version Latest;   # Proactively avoid errors and inconsistency
$Error.Clear();                   # Clear any errors from previous script runs
$ErrorActionPreference = 'Stop';  # All unhandled errors stop program
$WarningPreference = 'Stop';      # All warnings stop program

#endregion

#region Main script.

# Display banner.
Write-Host 'Solution Setup';
Write-Host '==============';
Write-Host 'Configures the system with dependencies required build the solution.';
Write-Host;

# Set web proxy default credential (in case necessary).
$proxy = [System.Net.WebRequest]::GetSystemWebProxy();
$proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials;
[System.Net.WebRequest]::DefaultWebProxy = $proxy;

# Install/update NuGet provider.
Write-Host 'Installing or updating NuGet package provider...';
Install-PackageProvider -Name NuGet -Force -Confirm:$false;

# Install/update PowerShell Gallery module.
Write-Host "Installing or updating PowerShell Gallery module...";
Install-Module -Name PowerShellGet -Force -AllowClobber -Confirm:$false;

# Install/update Pester module.
Write-Host 'Installing or updating Pester module...';
Install-Module -Name Pester -Force -SkipPublisherCheck -Confirm:$false;

# Exit successful.
Exit 0;

#endregion
