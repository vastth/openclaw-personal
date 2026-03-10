param(
    [string]$RootPath = ".\\backups"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

try {
    $resolvedRoot = Resolve-Path -LiteralPath $RootPath
    $gitEntries = Get-ChildItem -LiteralPath $resolvedRoot -Recurse -Force |
        Where-Object { $_.Name -eq ".git" }

    if (-not $gitEntries) {
        Write-Output "No nested .git entries found under $resolvedRoot"
        exit 0
    }

    $renamed = @()
    foreach ($entry in $gitEntries) {
        $parentPath = Split-Path -Parent $entry.FullName
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $targetName = ".git.disabled-$timestamp"
        $targetPath = Join-Path $parentPath $targetName
        $suffix = 1

        while (Test-Path -LiteralPath $targetPath) {
            $targetName = ".git.disabled-$timestamp-$suffix"
            $targetPath = Join-Path $parentPath $targetName
            $suffix += 1
        }

        Move-Item -LiteralPath $entry.FullName -Destination $targetPath
        $renamed += [pscustomobject]@{
            Source = $entry.FullName
            Destination = $targetPath
        }
    }

    $renamed | Format-Table -AutoSize | Out-String | Write-Output
}
catch {
    Write-Error ("Failed to disable nested git entries: " + $_.Exception.Message)
    exit 1
}