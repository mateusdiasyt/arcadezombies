@echo off
REM Execute no Git Bash ou instale o Git e adicione ao PATH.
REM https://git-scm.com/download/win

cd /d "%~dp0"

echo Inicializando repo...
git init
git remote add origin https://github.com/mateusdiasyt/arcadezombies.git 2>nul
git remote set-url origin https://github.com/mateusdiasyt/arcadezombies.git

echo Adicionando arquivos...
git add .
git status

echo.
echo Agora rode:
echo   git commit -m "Zombie TD Reborn: jogo + API Vercel + Neon"
echo   git branch -M main
echo   git push -u origin main
echo.
pause
