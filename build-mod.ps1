# Builds the mod portal zip from the committed HEAD.
# Usage: ./build-mod.ps1 [-Install]
#   -Install  also copies the zip into %APPDATA%\Factorio\mods
param(
  [switch]$Install
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$info = Get-Content info.json -Raw | ConvertFrom-Json
$zipName = "$($info.name)_$($info.version).zip"
$outDir = Join-Path $PSScriptRoot "dist"
$zipPath = Join-Path $outDir $zipName

if (git status --porcelain --untracked-files=no) {
  Write-Warning "Uncommitted changes are not included. The zip is built from HEAD."
}

New-Item -ItemType Directory -Force $outDir | Out-Null
git archive --format=zip --prefix="$($info.name)/" -o $zipPath HEAD
if ($LASTEXITCODE -ne 0) { throw "git archive failed" }

# The portal rejects executable files, so fail here instead of on upload
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
try {
  $entries = $zip.Entries | ForEach-Object FullName
} finally {
  $zip.Dispose()
}
$forbidden = $entries | Where-Object { $_ -match '\.(exe|bat|ps1|sh|py)$' }
if ($forbidden) {
  Remove-Item $zipPath
  throw "Zip contains files the mod portal rejects:`n$($forbidden -join "`n")"
}

Write-Host "Built $zipPath ($($entries.Count) entries)"

if ($Install) {
  $modsDir = Join-Path $env:APPDATA "Factorio\mods"
  Copy-Item $zipPath $modsDir -Force
  Write-Host "Installed to $modsDir"
}
