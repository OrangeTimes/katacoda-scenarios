
param(
    [Parameter(Mandatory=$True)]
    [System.String]$testLocation
)

$config.Run.PassThru = $true;
$config.RunExit = $true
$config.Output.Verbosity = "None";

return Invoke-Pester $testLocation -Configuration $config ;