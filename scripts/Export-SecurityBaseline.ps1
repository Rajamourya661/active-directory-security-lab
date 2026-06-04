<#
.SYNOPSIS
    Exports security-relevant baseline settings from a domain-joined lab host or DC.

.DESCRIPTION
    Captures audit policy, password policy summary, and AS-REP-vulnerable account count.
    Output is saved locally under scripts/logs/ (gitignored). No secrets are exported.

.PARAMETER DomainFqdn
    Domain FQDN for AD queries (requires RSAT / AD module on runner).

.PARAMETER OutputDirectory
    Folder for JSON output (default: .\logs)

.EXAMPLE
    .\Export-SecurityBaseline.ps1 -DomainFqdn corp.lab.local
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string] $DomainFqdn,

    [string] $OutputDirectory = (Join-Path $PSScriptRoot 'logs')
)

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$outFile = Join-Path $OutputDirectory "baseline-$timestamp.json"

if (-not (Test-Path $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
}

$baseline = [ordered]@{
    ExportedAt   = (Get-Date).ToString('o')
    Computer     = $env:COMPUTERNAME
    DomainFqdn   = $DomainFqdn
    AuditPolicy  = @()
    AdSummary    = @{}
}

try {
    $audit = auditpol /get /category:* 2>&1 | Out-String
    $baseline.AuditPolicy = $audit
}
catch {
    $baseline.AuditPolicy = "auditpol failed: $_"
}

if (Get-Module -ListAvailable -Name ActiveDirectory) {
    Import-Module ActiveDirectory -ErrorAction SilentlyContinue
    try {
        $noPreAuth = @(Get-ADUser -Filter { DoesNotRequirePreAuth -eq $true } -Properties DoesNotRequirePreAuth)
        $spnUsers = @(Get-ADUser -Filter { ServicePrincipalName -like '*' } -Properties ServicePrincipalName)
        $baseline.AdSummary = @{
            DoesNotRequirePreAuthCount = $noPreAuth.Count
            DoesNotRequirePreAuthSam   = ($noPreAuth | Select-Object -ExpandProperty SamAccountName)
            UserSpnCount               = $spnUsers.Count
        }
    }
    catch {
        $baseline.AdSummary = @{ Error = $_.Exception.Message }
    }
}
else {
    $baseline.AdSummary = @{ Note = 'Install RSAT ActiveDirectory module on this host for AD summary.' }
}

$baseline | ConvertTo-Json -Depth 5 | Set-Content -Path $outFile -Encoding UTF8
Write-Host "Baseline written to $outFile" -ForegroundColor Green
