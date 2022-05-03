
param(
    [Parameter(Mandatory=$True)]
    [System.String]$testLocation
)
Import-Module Pester -PassThru

$config = [PesterConfiguration]::Default;
$config.Run.Path = $testLocation;
$config.Run.PassThru = $True
$config.Output.Verbosity = "None";

$tempFolder = [System.IO.Path]::GetTempPath();
$result = Invoke-Pester -Configuration $config;
$tempFile = [System.IO.Path]::Combine($tempFolder, "TestResult.txt");
Write-Host "Result will be written to: $tempFile "
$result.Tests | ForEach-Object { "$_" } | Join-String -Separator "$([Environment]::NewLine)" | Out-File -FilePath $tempFile;
if ($result.Result -ne "Passed")
{
    exit 1
}
exit 0