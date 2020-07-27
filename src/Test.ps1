<#
.SYNOPSIS
This script runs all the unit tests specified in the testDlls variable below.
#>

$ErrorActionPreference = "Stop"

Import-Module (Join-Path $PSScriptRoot Common.psm1) -Function `
    AssertDotnet, `
    FindReportGenerator, `
    CreateAndGetArtefactsDir

function Main
{
    Set-Location $PSScriptRoot

    AssertDotnet

    $reportGeneratorExe = FindReportGenerator

    $artefactsDir = CreateAndGetArtefactsDir

    dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover
    if($LASTEXITCODE -ne 0)
    {
        throw "dotnet test failed."
    }

    $targetDir = Join-Path $artefactsDir "coverage-report"

    & $reportGeneratorExe `
        "-reports:**/coverage.opencover.xml" `
        "-targetdir:$targetDir" `
        "-reporttypes:Html"
    if($LASTEXITCODE -ne 0)
    {
        throw "Report generator failed."
    }
}

$previousLocation = Get-Location; try { Main } finally { Set-Location $previousLocation }
