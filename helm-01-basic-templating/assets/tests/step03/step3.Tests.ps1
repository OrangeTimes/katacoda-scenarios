
Describe 'Testing Helm Rendering' {
    BeforeAll {
        $isLocalExecution = $PSScriptRoot.Contains('assets')
        $chartPath = $isLocalExecution ? (Join-Path $PSScriptRoot -ChildPath "../../../assets/chart" -Resolve) : (Join-Path $PSScriptRoot -ChildPath "../../../chart" -Resolve)
        $actualWithEnabled = helm template $chartPath -f $chartPath/overrides/values.yaml --set enabled="true" 2>&1 | Out-String
        $actualWithDisabled = helm template $chartPath -f $chartPath/overrides/values.yaml --set enabled="false" 2>&1 | Out-String
        $valuesYaml = Get-Content "$chartPath/values.yaml" -Raw
        $hpaYaml = Get-Content "$chartPath/templates/hpa.yaml" -Raw
    }
        
    It 'Template rendering should not throw exception if enabled property is set to true' { 
        $actualWithEnabled | Should -Not -Match "Error" 
    }  

    It 'Template rendering should not throw exception if enabled property is set to false' { 
        $actualWithDisabled | Should -Not -Match "Error" 
    }  

    It 'Template rendering should render empty template if enabled property is set to false' { 
        $actualWithDisabled | Should -Not -Match "name: workshop" 
        $actualWithEnabled | Should -Not -Match "minReplicas: 1"
        $actualWithEnabled | Should -Not -Match "maxReplicas: 2"
    }  
    
    It 'Rendered template should contain name workshop from overrides/values.yaml if enabled property is set to true' { 
        
        $actualWithEnabled | Should -Match "name: workshop" 
    }  

    It 'Rendered template minReplicas should be 1 if enabled property is set to true' { 
        $actualWithEnabled | Should -Match "minReplicas: 1"
    }
    
    It 'Rendered template maxReplicas should be 2 if enabled property is set to true' { 
        $actualWithEnabled | Should -Match "maxReplicas: 2" 
    } 
    
    It 'values.yaml should have enabled property set to true by default' { 
        $valuesYaml | Should -Match "enabled:\s*\W*true\W*" 
    }      
    
    It 'hpa.yaml should reference enabled property' {
        $hpaYaml | Should -Match ".Values.enabled" 
    }      
    
   
}