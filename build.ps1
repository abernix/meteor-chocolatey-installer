Write-Host "Ensuring 'build' directory exists..." -ForegroundColor Magenta
$buildDirectory = Join-Path $PSScriptRoot 'build'
New-Item -Type Directory -Force $buildDirectory

$nuspecFile = Join-Path $PSScriptRoot 'meteor.nuspec'

Write-Host "Running 'choco pack' for ${testVersion}..." -ForegroundColor Magenta
& choco.exe pack $nuspecFile --outputdirectory $buildDirectory

Get-ChildItem $buildDirectory
