param([switch]$Voice, [switch]$MaxVolume, [string]$Port = 'COM14')
$ErrorActionPreference = 'Stop'
$monitor = $null
try { $monitor = Invoke-RestMethod 'http://127.0.0.1:8792/state' -TimeoutSec 3 } catch {
    Write-Output 'Microphone graph unavailable; serial access and firmware identity will be checked directly.'
}
if ($monitor.status -in @('running', 'connecting')) { throw 'Microphone graph is using the serial port.' }
if ($MaxVolume) { $Voice = $true }
$speakerPort = [System.IO.Ports.SerialPort]::new($Port, 115200)
$speakerPort.DtrEnable = $false
$speakerPort.RtsEnable = $false
$speakerPort.WriteTimeout = 1000
$speakerLog = [System.Text.StringBuilder]::new()
try {
    $speakerPort.Open()
    Start-Sleep -Milliseconds 1000
    $speakerPort.DiscardInBuffer()
    $speakerPort.Write('X?')
    Start-Sleep -Milliseconds 700
    $before = $speakerPort.ReadExisting()
    [void]$speakerLog.Append($before)
    if ($before -notmatch 'MIC STATUS motors_off=1 testing=0.*speaker_active=0 speaker_test=T') {
        throw 'Speaker diagnostic identity and stopped motors were not verified.'
    }
    if ($Voice -and $before -notmatch 'voice_test=V') { throw 'Voice command not available in this firmware.' }
    if ($MaxVolume -and $before -notmatch 'loud_voice_test=U') { throw 'Maximum-volume command not available in this firmware.' }
    $command = if ($MaxVolume) { 'U' } elseif ($Voice) { 'V' } else { 'T' }
    $tag = if ($Voice) { 'VOICE' } else { 'SPEAKER' }
    $timeout = if ($Voice) { 10 } else { 6 }
    $speakerPort.Write($command)
    $timer = [Diagnostics.Stopwatch]::StartNew()
    $result = ''
    while ($timer.Elapsed.TotalSeconds -lt $timeout) {
        Start-Sleep -Milliseconds 200
        $result += $speakerPort.ReadExisting()
        if ($result -match "$tag DONE|ERROR:|$tag STOPPED") { break }
    }
    [void]$speakerLog.Append($result)
    $speakerPort.Write('X?')
    Start-Sleep -Milliseconds 500
    $after = $speakerPort.ReadExisting()
    [void]$speakerLog.Append($after)
    if ($result -notmatch "$tag DONE:") { throw 'Speaker test did not report successful completion.' }
    if ($after -notmatch 'MIC STATUS motors_off=1 testing=0.*speaker_active=0') { throw 'Idle end state not confirmed.' }
} finally {
    if ($speakerPort.IsOpen) {
        $speakerPort.Write('X')
        $speakerPort.Close()
    }
    $speakerPort.Dispose()
    $stamp = [DateTime]::UtcNow.AddHours(5.5).ToString('yyyy-MM-dd_HHmmss')
    $prefix = if ($MaxVolume) { 'VOICE_MAX_TEST' } elseif ($Voice) { 'VOICE_TEST' } else { 'SPEAKER_TEST' }
    $logName = "${prefix}_${stamp}.txt"
    $speakerLog.ToString() | Tee-Object -FilePath (Join-Path $PSScriptRoot $logName)
}
