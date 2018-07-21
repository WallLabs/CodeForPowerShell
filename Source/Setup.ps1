# ==============================================================================
# Solution Setup
# ------------------------------------------------------------------------------
# Configures the system with dependencies required build the solution.
# ==============================================================================


# ==============================================================================
# Globals
# ------------------------------------------------------------------------------

# Options.
Set-StrictMode -Version Latest    # Proactively avoid errors and inconsistency
$error.Clear()                    # Clear any errors from previous script runs
$ErrorActionPreference = "Stop"   # All unhandled errors stop program
$WarningPreference = "Stop"       # All warnings stop program


# ==============================================================================
# Main Program
# ------------------------------------------------------------------------------

# Display banner.
Write-Output 'Solution Setup';
Write-Output '==============';
Write-Output 'Configures the system with dependencies required build the solution.';
Write-Output '';

# Update NuGet.
Write-Output 'Updating NuGet provider (required by Pester)...';
Install-PackageProvider -Name NuGet -Force;

# Update Pester.
Write-Output 'Updating Pester...';
Install-Module -name Pester -Force -SkipPublisherCheck;

# Exit successful.
Exit 0;
