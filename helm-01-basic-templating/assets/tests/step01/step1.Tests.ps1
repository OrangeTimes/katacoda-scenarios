
Describe 'Testing Helm Rendering' {
    BeforeAll {
        $isLocalExecution = $PSScriptRoot.Contains('assets')
        $chartPath = $isLocalExecution ? (Join-Path $PSScriptRoot -ChildPath "../../../assets/chart" -Resolve) : (Join-Path $PSScriptRoot -ChildPath "../../../chart" -Resolve)
        $actual = helm template $chartPath 2>&1 | Out-String
    }
        
    It 'Template rendering should not throw exception' {
        $actual | Should -Not -Match "Error" -Because 'No rendering error should be in in helm template'
    }

    It 'Template should contain name from values.yaml' {
        $actual | Should -Match "name: myhpa" -Because 'Template should contain name'
       
    }

    It 'Template should contain minReplicas from values.yaml' {
        $actual | Should -Match "minReplicas: 1" -Because 'minReplicas should be 1'
       
    }

    It 'Template should contain maxReplicas from values.yaml' {
        $actual | Should -Match "maxReplicas: 10" -Because 'maxReplicas: should be 10' 
    }
}