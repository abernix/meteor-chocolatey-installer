Param(
  [string]$releaseVersion
)

$checkoutDirectory = (Get-Item $PSScriptRoot).parent.FullName
$buildDirectory = Join-Path $checkoutDirectory 'build'

# Trying to install the package we just made.
$nupkg = Get-ChildItem -Path $buildDirectory -Filter '*.nupkg' |
  Select-Object -First 1

If (!(Test-Path -PathType 'Leaf' -Path $nupkg.FullName)) {
  throw "Couldn't find the '.nupkg'.  It should be the only file in '.\build'!"
}

Write-Host "Trying to install $($nupkg.FullName)..." `
  -ForegroundColor Magenta

If ($releaseVersion) {
  & choco.exe install meteor --force --yes -d `
    --allow-downgrade `
    --params="'/Release:${releaseVersion}'" `
    --source "'$buildDirectory;https://chocolatey.org/api/v2/'"
} Else {
  & choco.exe install meteor --force --yes -d `
    --allow-downgrade `
    --source "'$buildDirectory;https://chocolatey.org/api/v2/'"
}

Write-Host "The result was '$result'"