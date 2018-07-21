# ==============================================================================
# PowerShell Unit Test Setup
# ------------------------------------------------------------------------------
# Runs before any tests are executed to initialize the environment and ensure
# all modules are updated with any code changes since the last run.
# ==============================================================================


# ==============================================================================
# Globals
# ------------------------------------------------------------------------------

# Options.
Set-StrictMode -Version Latest;   # Proactively avoid errors and inconsistency
$error.Clear();                   # Clear any errors from previous script runs
$ErrorActionPreference = 'Stop';  # All unhandled errors stop program
$WarningPreference = 'Stop';      # All warnings stop program


# ==============================================================================
# Modules
# ------------------------------------------------------------------------------

# Initialize module paths.
$env:PSModulePath = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine");
$env:PSModulePath = "$env:PSModulePath;$PSScriptRoot\..\Modules";

# Force reload of all modules in solution (so source updates are included).
Get-Module -ListAvailable -Name 'CodeForPowerShell*' -Refresh;
Get-Module -Name 'CodeForPowerShell*' | Remove-Module -Force;


# ==============================================================================
# Main Program
# ------------------------------------------------------------------------------

# Create/clean output directory.
$outputDirectoryPath = "$PSScriptRoot\Data\Output";
if (Test-Path -LiteralPath $outputDirectoryPath -PathType Container)
{
    Remove-Item -LiteralPath $outputDirectoryPath -Recurse -Force;
}
New-Item -Path $outputDirectoryPath -ItemType Directory | Out-Null;

# Exit successful.
Exit 0;