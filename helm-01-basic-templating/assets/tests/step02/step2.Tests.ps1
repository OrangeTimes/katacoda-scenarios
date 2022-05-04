
Describe 'Testing Helm Rendering' {
    BeforeAll {
        $isLocalExecution = Test-Path (Join-Path $PSScriptRoot -ChildPath "../../../assets" -Resolve -ErrorAction SilentlyContinue) 
        $chartPath = $isLocalExecution ? (Join-Path $PSScriptRoot -ChildPath "../../../assets/charts/chart02" -Resolve) : (Join-Path $PSScriptRoot -ChildPath "../../../charts/chart02" -Resolve)
        $actual = helm template $chartPath -f $chartPath/overrides/values.yaml 2>&1 | Out-String
        $overridesValuesYaml = Get-Content "$chartPath/overrides/values.yaml" -Raw
    }
        
    It 'Template rendering should not throw exception' { 
        $actual | Should -Not -Match "Error" -Because 'No rendering error should be in in helm template'
    }

    It 'Rendered template should contain name workshop from overrides/values.yaml' { 
        
        $actual | Should -Match "name: workshop" 
    }  
    
    It 'Rendered template minReplicas should be 1' { 
        $actual | Should -Match "minReplicas: 1"
    }
    
    It 'Rendered template maxReplicas should be 2' { 
        $actual | Should -Match "maxReplicas: 2" 
    } 

    It 'Override values.yaml should set name  to workshop' { 
        $overridesValuesYaml | Should -Match "name:\s+?workshop"
    }

    It 'Override values.yaml should set max replicas to 2' { 
        $overridesValuesYaml | Should -Match "max:\s+?2"
    }
}