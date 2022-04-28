

$currentPath = Split-Path $MyInvocation.MyCommand.Path -Parent
$chartPath = Join-Path $currentPath "../chart01" -Resolve
Write-Host "Chart path: $chartPath"
Describe 'Testing Helm Rendering' {
    It 'Template rendering should not throw exception' { 
        helm template $chartPath 2>&1 | Out-String | Should -Not -Match "Error" -Because 'No rendering error should be in in helm template'
    }

    It 'Rendered template should match expected file' { 
        $actual =  helm template $chartPath 2>&1 | Out-String
        $actual | Should -Match "name: myhpa" -Because 'Template should contain name'
        $actual | Should -Match "minReplicas: 1" -Because 'minReplicas should be 1'
        $actual | Should -Match "maxReplicas: 10" -Because 'maxReplicas: should be 10' 
    }    
}