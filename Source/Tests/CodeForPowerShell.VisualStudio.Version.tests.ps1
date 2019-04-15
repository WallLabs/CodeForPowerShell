<#
	.Synopsis
	Code for PowerShell Visual Studio Unit Tests

	.Description
	PowerShell module unit tests.
#>

#region Globals

# Options
Set-StrictMode -Version Latest;    # Proactively avoid errors and inconsistency
$Error.Clear();                    # Clear any errors from previous script runs
$ErrorActionPreference = "Stop";   # All unhandled errors stop program
$WarningPreference = "Stop";       # All warnings stop program

# Initialize
& "$PSScriptRoot\Setup.ps1";
$dataDirectoryPath = "$PSScriptRoot\Temp\Data";

#endregion

#region Tests

Describe 'CodeForPowerShell' {
	Context 'VisualStudio.Version' {
		It 'Module' `
		{
			# Verify manifest
			Test-ModuleManifest "$PSScriptRoot\..\Modules\CodeForPowerShell.VisualStudio\CodeForPowerShell.VisualStudio.psd1";

			# Test import
			Import-Module CodeForPowerShell.VisualStudio;
		}

		It 'Get-VersionFile' `
		{
			# Constants
			[string]$filePath = "$dataDirectoryPath\Version.txt";
			[Version]$expectedVersion = New-Object -TypeName 'System.Version' -ArgumentList 1, 2, 3344, 55666;

			# Call test method to read version file
			[Version]$version = Get-VersionFile($filePath);

			# Check result
			$version | Should Be $expectedVersion;
		}

		It 'Set-VersionFile' `
		{
			# Constants
			[string]$filePath = "$dataDirectoryPath\Version Updated.txt";
			[Version]$expectedVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;

			# Call test method to write version file
			Set-VersionFile -File $filePath -Version $expectedVersion;

			# Read back and verify
			[Version]$version = Get-VersionFile $filePath;
			$version | Should Be $expectedVersion;
		}

		It 'Set-VersionInAppXManifest' `
		{
			# Constants
			[string]$filePath = "$dataDirectoryPath\Version in Windows Universal Package Manifest.xml";
			[Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;

			# Call test method to write version file
			Set-VersionInAppXManifest -File $filePath -Version $newVersion;
		}

		It 'Set-VersionInXmlProject' `
		{
			# Constants
			[string]$filePath = "$dataDirectoryPath\Version in Visual Studio XML Project.xml";
			[Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;

			# Call test method to write version file
			Set-VersionInXmlProject -File $filePath -Version $newVersion;
		}

		It 'Set-VersionInCppResourceFile' `
		{
			# Constants
			[string]$filePath = "$dataDirectoryPath\Version in Visual Studio C++ Resource.rc";
			[Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;

			# Call test method to write version file
			Set-VersionInCppResourceFile -File $filePath -Version $newVersion;
		}

		It 'Set-VersionInPowerShellScript' `
		{
			# Constants
			[string]$filePath = "$dataDirectoryPath\Version in PowerShell Script.ps1";
			[Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;

			# Call test method to write version file
			Set-VersionInPowerShellScript -File $filePath -Variable 'ScriptVersionText' -Version $newVersion;
		}

		It 'Set-VersionInPowerShellManifest' `
		{
			# Constants
			[string]$filePath = "$dataDirectoryPath\Version in PowerShell Manifest.psd1";
			[Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;

			# Call test method to write version file
			Set-VersionInPowerShellManifest -File $filePath -Version $newVersion;
		}
	}
}

#endregion
