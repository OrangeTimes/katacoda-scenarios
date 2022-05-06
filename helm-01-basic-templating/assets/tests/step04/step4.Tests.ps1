
Describe 'Testing Helm Rendering' {
    BeforeAll {
        $isLocalExecution = $PSScriptRoot.Contains('assets')
        $chartPath = $isLocalExecution ? (Join-Path $PSScriptRoot -ChildPath "../../../assets/chart" -Resolve) : (Join-Path $PSScriptRoot -ChildPath "../../../chart" -Resolve)
        $actual = helm template $chartPath -f $chartPath/overrides/values.yaml 2>&1 | Out-String
        $valuesYaml = Get-Content "$chartPath/values.yaml" -Raw
        $hpaYaml = Get-Content "$chartPath/templates/hpa.yaml" -Raw
    }
        
    It 'Template rendering should not throw exception' { 
        $actual | Should -Not -Match "Error" -Because 'No rendering error should be in in helm template'
    }

    It 'Rendered template should contain url: workshop.justanswer.local' { 
        
        $actual | Should -Match "url:\s*workshop\.justanswer\.local"
    }  
    
    It 'values.yaml should have global section' {
        $valuesYaml | Should -Match "global" 
    } 
    
    It 'values.yaml should have composite property "{{ .Values.name }}.{{.Values.global.domain }}"'{
        $valuesYaml | Should -Match "{{\s*?\.Values\.name\s*}}\.{{\s*.Values\.global\.domain\s*}}" 
    }   

    It 'hpa.yaml should use tpl function' {
        $hpaYaml | Should -Match "tpl \.Values\.url" 
    }
}