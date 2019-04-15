<#
	.Synopsis
	Version in PowerShell Script

	.Description
	Script with a constant version variable, updated by the version module.
#>

#region Globals.

# Options.
Set-StrictMode -Version Latest;   # Proactively avoid errors and inconsistency.
$Error.Clear();                   # Clear any errors from previous script runs.
$ErrorActionPreference = 'Stop';  # All unhandled errors stop program.
$WarningPreference = 'Stop';      # All warnings stop program.

# Constants.
[String]$ScriptVersionText = '1.2.3344.55666';
[Version]$ScriptVersion = [System.Version]::Parse($ScriptVersionText);

#endregion

#region Main script.

Write-Host "Version text is $ScriptVersionText.";
Write-Host "Version object is $ScriptVersion";

#endregion
