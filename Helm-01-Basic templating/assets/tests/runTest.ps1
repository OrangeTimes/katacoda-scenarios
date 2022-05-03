
param(
    [Parameter(Mandatory=$True)]
    [System.String]$testLocation
)
Import-Module Pester -PassThru

$config = [PesterConfiguration]::Default;
$config.Run.Path = $testLocation;
$config.Run.PassThru = $True
$config.Output.Verbosity = "None";

$result = Invoke-Pester -Configuration $config;
if ($result.Result -ne "Passed") {
    $result.Failed | ForEach-Object { $_.Name } | Join-String -Separator "$([Environment]::NewLine)" | Out-File -FilePath $testLocation/TestResult.txt;
    exit 1;
}
exit 0