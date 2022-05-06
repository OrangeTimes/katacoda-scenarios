
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
$logFile = [System.IO.Path]::Combine($tempFolder, "Log.txt");
Write-Host "Result will be written to: $tempFile "
$result | Out-String |  Out-File -FilePath $logFile ;
$result.Tests | ForEach-Object { "$_" } | Join-String -Separator "$([Environment]::NewLine)" | Out-File -FilePath $tempFile;
