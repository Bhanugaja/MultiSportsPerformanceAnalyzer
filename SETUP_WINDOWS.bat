@echo off
setlocal
cd /d "%~dp0backend"
where py >nul 2>nul
if %errorlevel%==0 (set PY=py) else (set PY=python)
if not exist venv\Scripts\python.exe (
  echo Creating Python virtual environment...
  %PY% -m venv venv || goto :error
)
echo Installing backend dependencies...
venv\Scripts\python.exe -m pip install -r requirements.txt || goto :error
echo Training models and loading all supplied datasets...
venv\Scripts\python.exe bootstrap.py --reset || goto :error
echo.
echo Backend setup complete.
echo Run START_BACKEND.bat next.
pause
exit /b 0
:error
echo Setup failed. Check the error above.
pause
exit /b 1
