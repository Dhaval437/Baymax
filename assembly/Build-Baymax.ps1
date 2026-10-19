param([switch]$Upload, [string]$Port = 'COM14')
$ErrorActionPreference = 'Stop'
$taskRoot = Split-Path -Parent $PSScriptRoot
Push-Location -LiteralPath $taskRoot
try {
    & node 'assembly/prepare-phone-setup.mjs'
    if ($LASTEXITCODE -ne 0) { throw 'Phone setup page preparation failed. Nothing uploaded.' }
    $taskCli = Join-Path $taskRoot '.tools/arduino-cli/arduino-cli.exe'
    $taskBuild = Join-Path $taskRoot '.tools/build/baymax-integrated'
    $taskBoard = 'esp32:esp32:esp32s3:FlashSize=16M,PSRAM=opi,CDCOnBoot=cdc,PartitionScheme=app3M_fat9M_16MB'
    & $taskCli compile --config-file '.tools/arduino-cli.yaml' --fqbn $taskBoard --build-path $taskBuild 'firmware/MiniBaymax'
    if ($LASTEXITCODE -ne 0) { throw 'Firmware compilation failed. Nothing uploaded.' }
    $taskReportDir = Join-Path $PSScriptRoot 'verification'
    New-Item -ItemType Directory -Path $taskReportDir -Force | Out-Null
    $taskBinary = Join-Path $taskBuild 'MiniBaymax.ino.bin'
    $taskOtaDir = Join-Path $taskRoot 'output/phone-setup'
    New-Item -ItemType Directory -Force -Path $taskOtaDir | Out-Null
    Copy-Item -LiteralPath $taskBinary -Destination (Join-Path $taskOtaDir 'Baymax-ESP32S3-application.bin') -Force
    Get-FileHash -LiteralPath $taskBinary -Algorithm SHA256 | Select-Object Algorithm,Hash | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $taskOtaDir 'sha256.json') -Encoding utf8
    @{
        date = (Get-Date).ToUniversalTime().ToString('o')
        board = $taskBoard
        binary = $taskBinary
        sha256 = (Get-FileHash -LiteralPath $taskBinary -Algorithm SHA256).Hash
        uploaded = $false
    } | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $taskReportDir 'integrated-build.json') -Encoding utf8
    if ($Upload) {
        & $taskCli upload --config-file '.tools/arduino-cli.yaml' --fqbn $taskBoard --port $Port --input-dir $taskBuild 'firmware/MiniBaymax'
        if ($LASTEXITCODE -ne 0) { throw 'Upload failed. Do not assume the new firmware is installed.' }
        $taskReportPath = Join-Path $taskReportDir 'integrated-build.json'
        $taskReport = Get-Content -LiteralPath $taskReportPath -Raw | ConvertFrom-Json
        $taskReport.uploaded = $true
        $taskReport | Add-Member -NotePropertyName port -NotePropertyValue $Port -Force
        $taskReport | Add-Member -NotePropertyName uploadedAt -NotePropertyValue ((Get-Date).ToUniversalTime().ToString('o')) -Force
        $taskReport | ConvertTo-Json | Set-Content -LiteralPath $taskReportPath -Encoding utf8
        Write-Output 'Upload completed. Firmware starts automatic listening after boot; check serial status at 115200.'
    } else { Write-Output 'Build completed. Nothing uploaded and no hardware activated.' }
} finally { Pop-Location }
