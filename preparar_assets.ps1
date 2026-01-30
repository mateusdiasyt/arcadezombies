# Prepara a pasta assets/ a partir de extracted/ para o Assets.as
# Execute na raiz do projeto: .\preparar_assets.ps1

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$extracted = Join-Path $root "extracted"
$assets = Join-Path $root "assets"

if (-not (Test-Path $extracted)) {
    Write-Error "Pasta extracted/ nao encontrada. Execute a extracao do SWF primeiro."
}

# Criar estrutura de pastas
@("", "maps", "links", "fonts", "sound") | ForEach-Object {
    $dir = Join-Path $assets $_
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
}

# Mapeamento: arquivo destino em assets/ -> padrao do nome da classe (para achar em extracted)
$imageMap = @{
    "title.png" = "Assets_GFX_TITLE"
    "titlescreen.jpg" = "Assets_GFX_TITLESCREEN"
    "backgroundwindow.jpg" = "Assets_GFX_BACKGROUND_WINDOW"
    "gameover.jpg" = "Assets_GFX_GAME_OVER"
    "youwin.jpg" = "Assets_GFX_YOU_WIN"
    "level_select.jpg" = "Assets_GFX_LEVEL_SELECT"
    "flashpunk.png" = "Assets_GFX_FLASH_PUNK"
    "zombie_head.png" = "Assets_GFX_ZOMBIE_HEAD"
    "zombie_head_over.png" = "Assets_GFX_ZOMBIE_HEAD_OVER"
    "bullet_select.png" = "Assets_GFX_BULLET_SELECT"
    "maps/easy.png" = "Assets_GFX_EASY_MAP"
    "maps/normal.png" = "Assets_GFX_NORMAL_MAP"
    "maps/hard.png" = "Assets_GFX_HARD_MAP"
    "maps/insane.png" = "Assets_GFX_INSANE_MAP"
    "gems.png" = "Assets_GFX_GEMS"
    "HUD.png" = "Assets_GFX_HUD"
    "HUD_score_text.png" = "Assets_GFX_HUD_SCORE_TEXT"
    "banner.png" = "Assets_GFX_HUD_BANNER"
    "TowerMenu.png" = "Assets_GFX_TOWER_MENU"
    "TowerMenuHover.png" = "Assets_GFX_TOWER_MENU_HOVER"
    "options_menu.png" = "Assets_GFX_OPTIONS_MENU"
    "Button.png" = "Assets_GFX_BUTTON"
    "Button_small.png" = "Assets_GFX_BUTTON_SMALL"
    "info_bg.png" = "Assets_GFX_ZOMBIE_INFO"
    "target.png" = "Assets_GFX_TARGET_SPRITESHEET"
    "menu_items.png" = "Assets_GFX_MENU_ITEMS"
    "upgrade_icons.png" = "Assets_GFX_UPGRADE_ICONS"
    "helpwindow.png" = "Assets_GFX_HELP_WINDOW"
    "dial.png" = "Assets_GFX_DIAL"
    "knob.png" = "Assets_GFX_KNOB"
    "links/tl_achiev_normal.png" = "Assets_GFX_TL_ACHIEV_NORMAL"
    "links/tl_achiev_selected.png" = "Assets_GFX_TL_ACHIEV_SELECTED"
    "links/tl_credits_normal.png" = "Assets_GFX_TL_CREDITS_NORMAL"
    "links/tl_credits_selected.png" = "Assets_GFX_TL_CREDITS_SELECTED"
    "links/tl_newgame_normal.png" = "Assets_GFX_TL_NEWGAME_NORMAL"
    "links/tl_newgame_selected.png" = "Assets_GFX_TL_NEWGAME_SELECTED"
    "links/tl_scores_normal.png" = "Assets_GFX_TL_SCORES_NORMAL"
    "links/tl_scores_selected.png" = "Assets_GFX_TL_SCORES_SELECTED"
    "statusicons.png" = "Assets_GFX_STATUS_ICONS"
    "zombies.png" = "Assets_GFX_ZOMBIES"
    "zombie_portraits.png" = "Assets_GFX_ZOMBIE_PORTRAITS"
    "zombies_info_portraits.png" = "Assets_GFX_ZOMBIE_INFO_PORTRAITS"
    "halo.png" = "Assets_GFX_HALO"
    "towers.png" = "Assets_GFX_TOWER_SPRITESHEET"
    "bases.png" = "Assets_GFX_TOWER_BASES"
    "tower_portraits.png" = "Assets_GFX_TOWER_PORTRAITS"
    "flash.png" = "Assets_GFX_SENTRY_FLASH"
    "missile_flash.png" = "Assets_GFX_MISSILE_FLASH"
    "bullet.png" = "Assets_GFX_SENTRY_BULLET"
    "snowball.png" = "Assets_GFX_SNOW_BALL"
    "bomb.png" = "Assets_GFX_BOMB"
    "sawblade.png" = "Assets_GFX_SAWBLADE"
    "rocket.png" = "Assets_GFX_ROCKET"
    "super_missile.png" = "Assets_GFX_SUPER_MISSILE"
    "flame_1.png" = "Assets_GFX_FLAME_1"
    "flame_2.png" = "Assets_GFX_FLAME_2"
    "flame_3.png" = "Assets_GFX_FLAME_3"
    "flame_4.png" = "Assets_GFX_FLAME_4"
    "flame_5.png" = "Assets_GFX_FLAME_5"
    "blast_ball.png" = "Assets_GFX_BLAST_BALL"
    "blast_shrapnel.png" = "Assets_GFX_BLAST_SHRAPNEL"
    "smoke.png" = "Assets_GFX_SMOKE"
    "snowflake.png" = "Assets_GFX_SNOW_FLAKE"
    "burn.png" = "Assets_GFX_BURN"
    "splatter.png" = "Assets_GFX_SPLATTER"
    "ice_particle.png" = "Assets_GFX_ICE_PARTICLE"
    "blood_spec.png" = "Assets_GFX_BLOOD_SPEC"
    "blood_pool.png" = "Assets_GFX_BLOOD_POOL"
    "achievements.png" = "Assets_GFX_ACHIEVEMENTS"
    "achievements_disabled.png" = "Assets_GFX_ACHIEVEMENTS_DISABLED"
}

$fontMap = @{
    "fonts/arial.ttf" = "Assets_FNT_ARIAL"
    "fonts/JezzabelBimbo.ttf" = "Assets_FNT_JEZZABELBIMBO"
    "fonts/exoteric.ttf" = "Assets_FNT_EXOTERIC"
}

$binaryMap = @{
    "maps/EasyMap2.oel" = "Assets_OEL_EASYMAP"
    "maps/NormalMap2.oel" = "Assets_OEL_NORMALMAP"
    "maps/HardMap2.oel" = "Assets_OEL_HARDMAP"
    "maps/InsaneMap2.oel" = "Assets_OEL_INSANEMAP"
}

$imagesDir = Join-Path $extracted "images"
$fontsDir = Join-Path $extracted "fonts"
$binaryDir = Join-Path $extracted "binaryData"

function Copy-ByPattern {
    param($sourceDir, $destPath, $pattern)
    $destFull = Join-Path $assets $destPath
    $found = Get-ChildItem -Path $sourceDir -Filter "*$pattern*" -File -ErrorAction SilentlyContinue
    if ($found) {
        Copy-Item -Path $found[0].FullName -Destination $destFull -Force
        Write-Host "  OK $destPath"
    } else {
        Write-Warning "  Faltando: $destPath (padrao: $pattern)"
    }
}

Write-Host "Copiando imagens..."
foreach ($entry in $imageMap.GetEnumerator()) {
    Copy-ByPattern -sourceDir $imagesDir -destPath $entry.Key -pattern $entry.Value
}

Write-Host "Copiando fontes..."
foreach ($entry in $fontMap.GetEnumerator()) {
    Copy-ByPattern -sourceDir $fontsDir -destPath $entry.Key -pattern $entry.Value
}

Write-Host "Copiando mapas (.oel)..."
foreach ($entry in $binaryMap.GetEnumerator()) {
    $destFull = Join-Path $assets $entry.Key
    $found = Get-ChildItem -Path $binaryDir -Filter "*$($entry.Value)*" -File -ErrorAction SilentlyContinue
    if ($found) {
        Copy-Item -Path $found[0].FullName -Destination $destFull -Force
        Write-Host "  OK $($entry.Key)"
    } else {
        Write-Warning "  Faltando: $($entry.Key)"
    }
}

Write-Host ""
Write-Host "Pronto. Pasta assets/ criada em: $assets"
Write-Host "Nota: Sons sao esperados de Sounds.swf no codigo; use extracted/sounds/ se for mudar para MP3."
