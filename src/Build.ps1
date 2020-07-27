<#
.DESCRIPTION
This script builds the solution.

It is expected that you installed 
the dev dependencies (with InstallDevDependenciesOnMV.ps1 or manually) 
as well as solution dependencies (InstallBuildDependencies.ps1 or manually).
#>

$ErrorActionPreference = "Stop"

Import-Module (Join-Path $PSScriptRoot Common.psm1) -Function `
    AssertDotnet, `
    CreateAndGetArtefactsDir

function Main
{
    AssertDotnet

    $configuration = "Debug"
    $artefactsDir = CreateAndGetArtefactsDir

    $outputPath = Join-Path $artefactsDir (Join-Path "build" $configuration)

    Write-Host "Building to: $outputPath"

    Set-Location $PSScriptRoot
    dotnet build --output $outputPath

    $buildExitCode = $LASTEXITCODE
    Write-Host "Build exit code: $buildExitCode"
    if ($buildExitCode -ne 0)
    {
        throw "Build failed."
    }
}

$previousLocation = Get-Location; try { Main } finally { Set-Location $previousLocation }
