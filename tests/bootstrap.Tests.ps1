Describe 'bootstrap.ps1 Validation Tests' {
    BeforeAll {
        $scriptPath = Join-Path $PSScriptRoot "..\bootstrap.ps1"
    }

    It 'Parses cleanly with zero syntax or AST errors' {
        $errors = @()
        $null = [System.Management.Automation.Language.Parser]::ParseFile(
            $scriptPath,
            [ref]$null,
            [ref]$errors
        )
        $errors.Count | Should Be 0
    }

    It 'Ensures network profiles are set to Private' {
        $content = Get-Content $scriptPath -Raw
        $content | Should Match 'Set-NetConnectionProfile\s+-NetworkCategory\s+Private'
    }

    It 'Installs OpenSSH Server capability' {
        $content = Get-Content $scriptPath -Raw
        $content | Should Match 'OpenSSH\.Server'
    }

    It 'Enforces SSH firewall rule restricted strictly to Private profile' {
        $content = Get-Content $scriptPath -Raw
        $content | Should Match 'Set-NetFirewallRule.*-Profile\s+Private'
    }

    It 'Sets default OpenSSH shell to PowerShell' {
        $content = Get-Content $scriptPath -Raw
        $content | Should Match 'New-ItemProperty.*DefaultShell.*powershell\.exe'
    }
}
