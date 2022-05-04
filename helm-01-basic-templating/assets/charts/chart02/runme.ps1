$ErrorActionPreference = "Stop"
$speedInSeconds = 2
$waitBetweenExercisesSeconds = 2
$currentPath = Split-Path $MyInvocation.MyCommand.Path -Parent
$overrideValuesYamlLocation = Get-ChildItem "$currentPath/override/values.yaml" | ForEach-Object { $_.FullName }
$expectedResultLocation = Get-ChildItem "$currentPath/expected/generated-template.yaml" | ForEach-Object { $_.FullName }

$exercises = [ordered]@{ 
    Exercise1 = { Intro-Helm-Overriding };
    Exercise2 = { Override-Default-Value };
}

function Write-Host-With-Delay {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Text
    )
    Write-Host $Text
    Start-Sleep -Seconds $speedInSeconds
}

function Intro-Helm-Overriding {
  
    Write-Host-With-Delay "We often need to specify overides for some specific environment"
    Write-Host-With-Delay "Helm provides multiple level of specificity in order to give ability to user to override required values if needed using:"
    Write-Host-With-Delay "1) The values.yaml file in the chart"   
    Write-Host-With-Delay "2) If this is a subchart, the values.yaml file of a parent chart"   
    Write-Host-With-Delay "3) A values file if passed into helm install or helm upgrade , helm template with the -f flag"
    Write-Host-With-Delay "4) Individual parameters passed with --set (such as helm install --set foo=bar ./mychart)"
    Write-Host-With-Delay "The list above is in order of specificity: values.yaml is the default, which can be overridden by a parent chart's values.yaml, which can in turn be overridden by a user-supplied values file, which can in turn be overridden by --set parameters."
    Write-Host-With-Delay "Most often we will use -f flag during running some of the helm commands"
}

function Override-Default-Value {
    Write-Host-With-Delay "Ok so let's learn by doing"  
    Write-Host-With-Delay "You should override the application name and max number of replicas using helm override capability"
    Write-Host-With-Delay  "Objective:" 
    Write-Host-With-Delay  "1. Update the values.yaml located in ./override folder to change application name to workshop "
    Write-Host-With-Delay  "2. Update the values.yaml located in ./override folder so max replicas should be set 2 in the end result"
    Write-Host-With-Delay "You can render template on your own by running next command"
    Write-Host
    Write-Host "helm template `"$currentPath`" -f `"$overrideValuesYamlLocation`"" -ForegroundColor Green
    Write-Host    
    Write-Host-With-Delay "Fix all the issues and pass the test. Good luck"
    Write-Host-With-Delay  "Test will check your template against expected result."
    Start-Sleep -Seconds $speedInSeconds
    $reply = Read-Host -Prompt "Run test now?[To quit type stop]"
    while (-not($reply -match "stop")) {
        $testResult = Run-Test
        if ($testResult.Result -eq "Passed") {
            break;
        }
        $reply = Read-Host -Prompt "Rerun test now?[To quit type stop]"
    }

    if ($reply -eq "stop") {
        Write-Host "Sorry to hear that you need to exit." -ForegroundColor Red
    }
    else {
        Write-Host "Spot on!!! You nailed it" -ForegroundColor Magenta
    }
}

function Run-Test {

    Import-Module Pester -Force;

    $sb = {   
         Describe 'Testing Helm Rendering' {
            It 'Template rendering should not throw exception' { 
                { helm template $currentPath -f $overrideValuesYamlLocation 2>&1 } | Should -Not -Throw -Because 'No rendering error in helm template'
            }

            It 'Rendered template should match expected file' { 

                $actual = helm template $currentPath -f $overrideValuesYamlLocation 2>&1 | Out-String
                $expected = Get-Content -Path $expectedResultLocation  -Raw
                $actual.trim() | Should -BeLike $expected.trim() 
            }    
        }
    }
    $container = New-PesterContainer -ScriptBlock $sb
                
    $containers = New-Object System.Collections.Generic.List[System.Object];
    $containers.Add($container);
    $config = [PesterConfiguration]::Default;
    $config.Run.PassThru = $true;
    $config.Run.Container = $containers;
    $config.Output.Verbosity = "Detailed";

    return Invoke-Pester -Configuration $config ;
}


Write-Host "Welcome to Helm Lesson 2: Working with overrides and values.yaml" -ForegroundColor Magenta

$exercises.Keys | ForEach-Object {
    Write-Host
    Write-Host "$_" -ForegroundColor Blue
    Invoke-Command -ScriptBlock $exercises.Item($_)
    Start-Sleep -Seconds $waitBetweenExercisesSeconds
    
    $reply = Read-Host -Prompt "Say when we can continue?[y]"
  
    while (-not ($reply -match "[yY]")) {
        Write-Host "Seems that you need some more time.."
        $reply = Read-Host -Prompt "Say when we can continue?[y]"
    }
}

Write-Host "Congratulation you have completed all exercises" -ForegroundColor Magenta

