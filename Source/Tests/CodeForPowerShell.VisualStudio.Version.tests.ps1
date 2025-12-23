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

#region Functions.

<#
	.Synopsis
    Verifies the content of an XML file.
#>
function Verify-XmlFileValue([string]$filePath, [string]$testXpath, [string]$testValue)
{
    # Load file, which also verifies the file has been properly written and closed.
    # Tests show files remain locked or truncated when XML or text writers are not explicitly closed.
	$xml = [xml]::new();
    $xml.PreserveWhitespace = $true;
    $xml.Load($filePath);

    # Read test value.
    $testNode = $xml.SelectSingleNode($testXpath);
    $actualValue = if ($testNode.NodeType -eq 'Attribute') { $testNode.Value } else { $testNode.InnerText.Trim() };

    # Assert equals expected value.
    $actualValue | Should BeExactly $testValue;
}

#endregion

#region Tests

Describe 'CodeForPowerShell' {
	Context 'VisualStudio.Version' {
		It 'Module' `
		{
			# Verify manifest.
			Test-ModuleManifest "$PSScriptRoot\..\Modules\CodeForPowerShell.VisualStudio\CodeForPowerShell.VisualStudio.psd1";

			# Test module import.
			Import-Module CodeForPowerShell.VisualStudio;
		}

		It 'Get-VersionFile' `
		{
			# Constants.
			[string]$filePath = "$dataDirectoryPath\Version.txt";
			[Version]$expectedVersion = New-Object -TypeName 'System.Version' -ArgumentList 1, 2, 3344, 55666;

            # Initialize.
            Import-Module CodeForPowerShell.VisualStudio;

			# Test version file read method.
			[Version]$version = Get-VersionFile($filePath);

			# Check result.
			$version | Should Be $expectedVersion;
		}

		It 'Set-VersionFile' `
		{
			# Constants.
			[string]$filePath = "$dataDirectoryPath\Version Updated.txt";
			[Version]$expectedVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;

            # Initialize.
            Import-Module CodeForPowerShell.VisualStudio;

			# Test version file write method.
			Set-VersionFile -File $filePath -Version $expectedVersion;

			# Read back and verify.
			[Version]$version = Get-VersionFile $filePath;
			$version | Should Be $expectedVersion;
		}

		It 'Set-VersionInAppXManifest' `
		{
			# Constants.
			[string]$filePath = "$dataDirectoryPath\Version in Windows Universal Package Manifest.xml";
			[Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;
            
            # Initialize.
            Import-Module CodeForPowerShell.VisualStudio;

			# Test setting version in AppX manifest.
			Set-VersionInAppXManifest -File $filePath -Version $newVersion;

            # Read back and verify.
            Verify-XmlFileValue $filePath "/node()[name() = 'Package']/node()[name() = 'Identity']/@Version" "7.8.9900.11222";
		}

		It 'Set-VersionInXmlProject' `
		{
			# Constants.
			[string]$filePath = "$dataDirectoryPath\Version in Visual Studio XML Project.xml";
			[Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;
            
            # Initialize.
            Import-Module CodeForPowerShell.VisualStudio;

			# Test setting version in Visual Studio XML project.
			Set-VersionInXmlProject -File $filePath -Version $newVersion;

            # Read back and verify.
            Verify-XmlFileValue $filePath "/Project/PropertyGroup/Version" "7.8.9900.11222";
		}

		It 'Set-VersionInCppResourceFile' `
		{
			# Constants.
			[string]$filePath = "$dataDirectoryPath\Version in Visual Studio C++ Resource.rc";
			[Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;
            
            # Initialize.
            Import-Module CodeForPowerShell.VisualStudio;

			# Test setting version in C++ resource file.
			Set-VersionInCppResourceFile -File $filePath -Version $newVersion;
		}

		It 'Set-VersionInPowerShellScript' `
		{
			# Constants.
			[string]$filePath = "$dataDirectoryPath\Version in PowerShell Script.ps1";
			[Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;

            # Initialize.
            Import-Module CodeForPowerShell.VisualStudio;

			# Test setting method in PowerShell script variable.
			Set-VersionInPowerShellScript -File $filePath -Variable 'ScriptVersionText' -Version $newVersion;
		}

		It 'Set-VersionInPowerShellManifest' `
		{
			# Constants.
			[string]$filePath = "$dataDirectoryPath\Version in PowerShell Manifest.psd1";
			[Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;
            
            # Initialize.
            Import-Module CodeForPowerShell.VisualStudio;

			# Test setting version in PowerShell manifest.
			Set-VersionInPowerShellManifest -File $filePath -Version $newVersion;
		}
	}
}

#endregion
