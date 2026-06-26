# render.ps1 — build the site locally into _site/ so you can preview it before
# publishing. Run from the project folder:   ./render.ps1
#
# Like publish.ps1, it puts your R installation on PATH first so Quarto can run
# the pre-render step that rebuilds the Hip-Hop periodic table from Excel.

$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot

$rRoots = @(
  "$env:LOCALAPPDATA\Programs\R",
  "$env:ProgramFiles\R",
  "${env:ProgramFiles(x86)}\R"
)
$rBin = $rRoots |
  Where-Object { Test-Path $_ } |
  ForEach-Object { Get-ChildItem "$_\R-*\bin" -Directory -ErrorAction SilentlyContinue } |
  Sort-Object Name -Descending |
  Select-Object -First 1

if ($rBin) {
  $env:PATH = "$($rBin.FullName);$env:PATH"
  Write-Host "Using R at $($rBin.FullName)" -ForegroundColor Green
} else {
  Write-Warning "Could not auto-locate R. If rendering fails, install R or add it to PATH."
}

quarto render
Write-Host "`nDone. Open _site/index.html in your browser to preview." -ForegroundColor Cyan
