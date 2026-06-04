<#
.SYNOPSIS
    Prints a purple-team checklist for validating detection use cases in the lab.

.DESCRIPTION
    Does not execute attacks. Guides operator through attack -> verify event -> SIEM steps.
    Run attack playbooks manually from docs/attacks/ per authorization.

.PARAMETER UseCaseId
    Optional use case ID (e.g., AD-DC-001). If omitted, lists all.

.EXAMPLE
    .\Invoke-DetectionTest.ps1 -UseCaseId AD-DC-001
#>
[CmdletBinding()]
param(
    [string] $UseCaseId
)

$useCases = @(
    @{
        Id       = 'AD-DC-001'
        Name     = 'Kerberoasting'
        Attack   = 'docs/attacks/kerberoasting.md'
        Detect   = 'docs/detection/kerberoast-detection.md'
        Event    = '4769 — verify IpAddress = attacking host; Account Name = service account'
        Sigma    = 'docs/detection/sigma/kerberoast-rc4-volume.yml'
    },
    @{
        Id       = 'AD-DC-002'
        Name     = 'AS-REP Roasting'
        Attack   = 'docs/attacks/asrep-roasting.md'
        Detect   = 'docs/detection/asrep-detection.md'
        Event    = '4768 PreAuthType 0'
        Sigma    = 'docs/detection/sigma/asrep-no-preauth.yml'
    },
    @{
        Id       = 'AD-DC-008'
        Name     = 'Password Spraying'
        Attack   = 'docs/attacks/password-spraying.md'
        Detect   = 'docs/detection/password-spray-detection.md'
        Event    = '4625 distinct TargetUserName from one IpAddress'
        Sigma    = 'docs/detection/sigma/password-spray-4625.yml'
    },
    @{
        Id       = 'AD-DC-003'
        Name     = 'BloodHound collection'
        Attack   = 'docs/attacks/bloodhound-recon.md'
        Detect   = 'docs/detection/bloodhound-indicators.md'
        Event    = '4688 SharpHound or MDI recon alert'
        Sigma    = 'N/A — process/LDAP correlation'
    }
)

function Show-UseCase {
    param($uc)
    Write-Host "`n=== $($uc.Id): $($uc.Name) ===" -ForegroundColor Cyan
    Write-Host "1. Attack:  $($uc.Attack)"
    Write-Host "2. Run playbook (authorized lab only)"
    Write-Host "3. DC event: $($uc.Event)"
    Write-Host "4. Detection: $($uc.Detect)"
    Write-Host "5. Rule: $($uc.Sigma)"
    Write-Host "6. Screenshot -> screenshots/ and update detection-use-cases.md status"
}

if ($UseCaseId) {
    $match = $useCases | Where-Object { $_.Id -eq $UseCaseId }
    if (-not $match) { Write-Error "Unknown use case: $UseCaseId"; exit 1 }
    Show-UseCase $match
}
else {
    Write-Host "AD Security Lab — Detection validation checklist" -ForegroundColor Yellow
    foreach ($uc in $useCases) { Show-UseCase $uc }
}

Write-Host "`nReminder: Lab-only. See SECURITY.md and root README ethics section." -ForegroundColor DarkGray
