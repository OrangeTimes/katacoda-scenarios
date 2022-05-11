
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

    It 'values.yaml should have hosts property' {
        $valuesYaml | Should -Match "hosts:"
    }

    It 'Rendered template should have 5 hosts in it' {
        
        $actual | Should -Match "host1.example.com"
        $actual | Should -Match "host2.example.com"
        $actual | Should -Match "host3.example.com"
        $actual | Should -Match "host4.example.com"
        $actual | Should -Match "host5.example.com"
    }   
    It 'hpa.yaml should use have hosts property' {
        $hpaYaml | Should -Match "hosts" 
    }

    It 'hpa.yaml should use range function' {
        $hpaYaml | Should -Match "range" 
    }

    It 'hpa.yaml should use reference .Values.host' {
        $hpaYaml | Should -Match ".Values.hosts" 
    }
}