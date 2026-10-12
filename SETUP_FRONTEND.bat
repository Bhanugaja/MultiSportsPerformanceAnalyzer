@echo off
cd /d "%~dp0frontend"
echo Installing frontend dependencies...
npm install
if errorlevel 1 (
  echo Frontend installation failed.
  pause
  exit /b 1
)
echo Frontend setup complete. Run START_FRONTEND.bat next.
pause
