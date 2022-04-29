
param(
    [Parameter(Mandatory=$True)]
    [System.String]$testLocation
)
Import-Module Pester -PassThru

$config = [PesterConfiguration]::Default;
$config.Run.Path = $testLocation;
$config.Run.Exit = $True
$config.Run.PassThru =$True
$config.Output.Verbosity = "None";

return Invoke-Pester -Configuration $config;