# Recompila os scripts extraidos de volta no SWF usando FFDec.
# Use depois de editar arquivos em extracted\scripts\
# Gera: zombie_td_reborn_modificado.swf

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$swfOriginal = Join-Path $root "zombie_td_reborn.swf"
$swfSaida   = Join-Path $root "zombie_td_reborn_modificado.swf"
$scripts    = Join-Path $root "extracted\scripts"
$ffdec      = Join-Path $root "ffdec\ffdec-cli.exe"

if (-not (Test-Path $swfOriginal)) {
    Write-Error "Arquivo original nao encontrado: $swfOriginal"
}
if (-not (Test-Path $ffdec)) {
    Write-Error "FFDec nao encontrado. Execute a extracao primeiro (ffdec esta em ffdec\)."
}

Write-Host "Recompilando scripts no SWF..."
& $ffdec -onerror ignore -importScript $swfOriginal $swfSaida $scripts
if ($LASTEXITCODE -eq 0 -and (Test-Path $swfSaida)) {
    Write-Host "OK. SWF gerado: zombie_td_reborn_modificado.swf"
    Write-Host "Abra com Ruffle para testar."
} else {
    Write-Host "Aviso: verifique se o SWF foi gerado em $swfSaida"
}
