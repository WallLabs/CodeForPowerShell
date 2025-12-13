<#
	.Synopsis
	Development Setup Script

	.Description
	Prepares a developer workstation to test, debug or edit this solution.
#>

#region Globals

# Options.
Set-StrictMode -Version Latest;   # Proactively avoid errors and inconsistency.
$error.Clear();                   # Clear any errors from previous script runs.
$ErrorActionPreference = "Stop";  # All unhandled errors stop program.
$WarningPreference = "Stop";      # All warnings stop program.

#endregion

#region Main script.

# Display banner.
Write-Host 'Development Setup';
Write-Host '=================';
Write-Host 'Installs and configures the system ready for development.';

# Set web proxy default credential (in case necessary).
$proxy = [System.Net.WebRequest]::GetSystemWebProxy();
$proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials;
[System.Net.WebRequest]::DefaultWebProxy = $proxy;

# TODO: Confirm if setup still required with current PowerShell versions. Upgade to PS Core/7.x.

## Install/update NuGet provider.
#Write-Host 'Installing or updating NuGet package provider...';
#Install-PackageProvider -Name NuGet -Force -Confirm:$false;

## Install/update PowerShell Gallery module.
#Write-Host "Installing or updating PowerShell Gallery module...";
#Install-Module -Name PowerShellGet -Force -AllowClobber -Confirm:$false;

## Install/update Pester module.
#Write-Host 'Installing or updating Pester module...';
#Install-Module -Name Pester -Force -SkipPublisherCheck -Confirm:$false;

# Exit successfully.
Write-Host "Development setup completed successfully.";
Exit 0;

#endregion
