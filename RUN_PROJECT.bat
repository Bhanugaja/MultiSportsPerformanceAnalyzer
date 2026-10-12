@echo off
setlocal
cd /d "%~dp0"
if not exist backend\venv\Scripts\python.exe (
  echo Run SETUP_WINDOWS.bat first.
  pause
  exit /b 1
)
if not exist frontend\node_modules (
  echo Run SETUP_FRONTEND.bat first.
  pause
  exit /b 1
)
start "Sports Analyzer Backend" cmd /k "cd /d "%~dp0backend" && venv\Scripts\python.exe app.py"
timeout /t 2 /nobreak >nul
start "Sports Analyzer Frontend" cmd /k "cd /d "%~dp0frontend" && npm start"
echo Project started. Open http://localhost:3000
