@echo off
cd /d "%~dp0frontend"
if not exist node_modules (
  echo Frontend dependencies not found. Run SETUP_FRONTEND.bat first.
  pause
  exit /b 1
)
npm start
pause
