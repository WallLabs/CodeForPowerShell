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
$Error.Clear();                   # Clear any errors from previous script runs
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

# Clean test data directory.
$dataDirectoryPath = "$PSScriptRoot\Temp";
if (Test-Path -Path $dataDirectoryPath -PathType Container)
{
    Remove-Item -Path $dataDirectoryPath -Recurse -Force;
}
New-Item -Path $dataDirectoryPath -ItemType Directory | Out-Null;

# Copy data to test working path
Copy-Item -Path "$PSScriptRoot\Data" -Destination "$dataDirectoryPath" -Recurse -Force;

# Set working directory for tests
Set-Location $dataDirectoryPath;

# Exit successful.
Exit 0;
