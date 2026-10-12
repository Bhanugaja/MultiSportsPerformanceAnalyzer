@echo off
cd /d "%~dp0backend"
if not exist venv\Scripts\python.exe (
  echo Backend environment not found. Run SETUP_WINDOWS.bat first.
  pause
  exit /b 1
)
venv\Scripts\python.exe app.py
pause
