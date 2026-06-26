# publish.ps1 — render the site and publish it to GitHub Pages (datawithaplot.org).
#
# Run this from the project folder in PowerShell:   ./publish.ps1
#
# It locates your R installation (which lives in a non-standard AppData folder
# that Quarto can't find on its own), puts it on PATH for this run, then calls
# `quarto publish gh-pages`. That regenerates the Hip-Hop periodic table from
# hiphop/data/hiphop_artists.xlsx and deploys the rendered site.

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
  Write-Warning "Could not auto-locate R. If publishing fails, install R or add it to PATH."
}

quarto publish gh-pages
