
param(
    [Parameter(Mandatory=$True)]
    [System.String]$testLocation
)
Import-Module Pester -PassThru
$config = [PesterConfiguration]::Default;
$config.Run.PassThru = $true;
$config.RunExit = $true
$config.Output.Verbosity = "None";

return Invoke-Pester $testLocation -Configuration $config ;