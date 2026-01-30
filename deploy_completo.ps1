# Recompila o SWF, copia para public e faz push (Vercel faz o deploy automaticamente).
# Uso: .\deploy_completo.ps1 [mensagem de commit]

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot
$msg = if ($args.Count -gt 0) { $args -join " " } else { "Deploy: recompilacao SWF + build" }

Set-Location $root

# 1. Recompilar SWF
Write-Host "=== 1/4 Recompilando SWF (FFDec) ===" -ForegroundColor Cyan
& "$root\compilar_swf.ps1"
if (-not (Test-Path "$root\zombie_td_reborn_modificado.swf")) {
    Write-Error "SWF nao foi gerado. Verifique o FFDec e extracted\scripts."
}

# 2. Copiar SWF para public/
Write-Host "`n=== 2/4 Copiando SWF para public ===" -ForegroundColor Cyan
$swfSrc = Join-Path $root "zombie_td_reborn_modificado.swf"
$swfDest = Join-Path $root "public\zombie_td_reborn_modificado.swf"
if (-not (Test-Path "$root\public")) { New-Item -ItemType Directory -Path "$root\public" -Force | Out-Null }
if (Test-Path $swfSrc) {
    Copy-Item $swfSrc $swfDest -Force
    Write-Host "SWF copiado para public/"
}

# 3. Git add e commit
Write-Host "`n=== 3/4 Git add + commit ===" -ForegroundColor Cyan
$git = "C:\Program Files\Git\bin\git.exe"
if (-not (Test-Path $git)) { $git = "git" }
& $git add -A
& $git status --short
& $git commit -m $msg
if ($LASTEXITCODE -ne 0) {
    Write-Host "Nada para commitar ou erro no commit." -ForegroundColor Yellow
}

# 4. Push (dispara deploy no Vercel)
Write-Host "`n=== 4/4 Git push ===" -ForegroundColor Cyan
& $git push
if ($LASTEXITCODE -eq 0) {
    Write-Host "`nDeploy enviado. O Vercel vai publicar em instantes." -ForegroundColor Green
} else {
    Write-Host "`nErro no push. Verifique a conexao e o remote." -ForegroundColor Red
}
