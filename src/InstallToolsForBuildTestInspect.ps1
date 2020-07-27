<#
.SYNOPSIS
This script installs the tools necessary to build and check the solution.
#>

Import-Module (Join-Path $PSScriptRoot Common.psm1) -Function `
    AssertDotnet, `
    GetToolsDir

function Main {
    if ($null -eq (Get-Command "nuget.exe" -ErrorAction SilentlyContinue))
    {
       throw "Unable to find nuget.exe in your PATH"
    }

    AssertDotnet

    $toolsDir = GetToolsDir
    New-Item -ItemType Directory -Force -Path $toolsDir|Out-Null

    Write-Host "Installing ReportGenerator ..."
    nuget install ReportGenerator -Version 4.6.1 -OutputDirectory $toolsDir

    Write-Host "Installing Resharper CLI ..."
    nuget install JetBrains.ReSharper.CommandLineTools -Version 2020.1.4 -OutputDirectory $toolsDir

    Write-Host "Restoring dotnet tools for the solution ..."
    dotnet tool restore
}

$previousLocation = Get-Location; try { Main } finally { Set-Location $previousLocation }
