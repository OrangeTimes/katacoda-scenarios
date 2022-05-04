
Describe 'Testing Helm Rendering' {
    BeforeAll {
        $chartPath = (Test-Path "../../../assets") ? (Join-Path $PSScriptRoot "../../../assets/charts/chart01" -Resolve) : (Join-Path $PSScriptRoot "../../../charts/chart01" -Resolve)
    }
        
    It 'Template rendering should not throw exception' { 
        helm template $chartPath 2>&1 | Out-String | Should -Not -Match "Error" -Because 'No rendering error should be in in helm template'
    }

    It 'Rendered template should contain values from values.yaml' { 
        $actual =  helm template $chartPath 2>&1 | Out-String
        $actual | Should -Match "name: myhpa" -Because 'Template should contain name'
        $actual | Should -Match "minReplicas: 1" -Because 'minReplicas should be 1'
        $actual | Should -Match "maxReplicas: 10" -Because 'maxReplicas: should be 10' 
    }    
}