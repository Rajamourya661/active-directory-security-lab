<#
.SYNOPSIS
    Validates basic Active Directory lab connectivity from a domain-joined host.

.DESCRIPTION
    Checks DNS resolution, LDAP reachability, and time skew against the domain.
    Intended for the AD Security Lab only. Does not modify domain objects.

.PARAMETER DomainFqdn
    Fully qualified domain name (e.g., corp.lab.local).

.PARAMETER DomainController
    Hostname or IP of a domain controller.

.EXAMPLE
    .\Test-LabConnectivity.ps1 -DomainFqdn corp.lab.local -DomainController DC01
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string] $DomainFqdn,

    [Parameter(Mandatory = $true)]
    [string] $DomainController
)

$ErrorActionPreference = 'Stop'
$failures = @()

function Add-Failure {
    param([string] $Message)
    $script:failures += $Message
    Write-Warning $Message
}

Write-Host "=== AD Security Lab Connectivity Check ===" -ForegroundColor Cyan
Write-Host "Domain: $DomainFqdn"
Write-Host "DC:     $DomainController"
Write-Host ""

# DNS
try {
    $dns = Resolve-DnsName -Name $DomainFqdn -Type A -ErrorAction Stop
    Write-Host "[OK] DNS resolves $DomainFqdn -> $($dns[0].IPAddress)" -ForegroundColor Green
}
catch {
    Add-Failure "DNS failed for $DomainFqdn : $_"
}

# DC locator
try {
    $dc = nltest /dsgetdc:$DomainFqdn 2>&1
    if ($LASTEXITCODE -ne 0) { throw $dc }
    Write-Host "[OK] nltest located a domain controller" -ForegroundColor Green
}
catch {
    Add-Failure "nltest /dsgetdc failed: $_"
}

# LDAP port
try {
    $tcp = Test-NetConnection -ComputerName $DomainController -Port 389 -WarningAction SilentlyContinue
    if (-not $tcp.TcpTestSucceeded) { throw "TCP 389 not reachable" }
    Write-Host "[OK] LDAP (389) reachable on $DomainController" -ForegroundColor Green
}
catch {
    Add-Failure "LDAP connectivity failed: $_"
}

# Time skew (Kerberos)
try {
    $w32tm = w32tm /stripchart /computer:$DomainController /samples:1 /dataonly 2>&1
    Write-Host "[INFO] Time sample vs DC:" $w32tm
    Write-Host "[OK] Time check executed (review skew; keep under 5 minutes for Kerberos)" -ForegroundColor Green
}
catch {
    Add-Failure "w32tm check failed: $_"
}

# Optional: current domain membership
try {
    $cs = Get-CimInstance Win32_ComputerSystem
    if ($cs.PartOfDomain) {
        Write-Host "[OK] Computer is domain-joined: $($cs.Domain)" -ForegroundColor Green
    }
    else {
        Add-Failure "Computer is not domain-joined (workgroup: $($cs.Workgroup))"
    }
}
catch {
    Add-Failure "Could not read domain join status: $_"
}

Write-Host ""
if ($failures.Count -eq 0) {
    Write-Host "All checks passed." -ForegroundColor Green
    exit 0
}

Write-Host "$($failures.Count) check(s) failed." -ForegroundColor Red
exit 1
