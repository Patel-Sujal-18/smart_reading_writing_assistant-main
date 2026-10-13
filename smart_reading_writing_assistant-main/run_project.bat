@echo off
setlocal

REM Auto-detect project folder whether run from root or inner folder
set "BASE_DIR=%~dp0"
if exist "%BASE_DIR%smart_reading_writing_assistant-main\backend.py" (
    set "PROJECT_DIR=%BASE_DIR%smart_reading_writing_assistant-main"
) else if exist "%BASE_DIR%backend.py" (
    set "PROJECT_DIR=%BASE_DIR:~0,-1%"
) else (
    echo [ERROR] Could not find backend.py!
    echo Please make sure this file is placed inside the project repository.
    pause
    exit /b 1
)

set "PYTHON_EXE=%PROJECT_DIR%\.venv\Scripts\python.exe"
set "FRONTEND_DIR=%PROJECT_DIR%\frontend"

echo ==========================================================
echo Starting LexiFlow - Smart Reading and Writing Assistant
echo Project Directory: %PROJECT_DIR%
echo ==========================================================

REM Check virtual environment
if not exist "%PYTHON_EXE%" (
    echo [ERROR] Python virtual environment was not found at:
    echo "%PYTHON_EXE%"
    echo.
    echo Please run setup_env.bat inside "%PROJECT_DIR%" first!
    pause
    exit /b 1
)

REM Check frontend directory
if not exist "%FRONTEND_DIR%\package.json" (
    echo [ERROR] Frontend directory not found at:
    echo "%FRONTEND_DIR%"
    pause
    exit /b 1
)

echo [1/2] Starting FastAPI Backend on http://localhost:8000 ...
start "LexiFlow Backend (FastAPI)" cmd /k "title LexiFlow Backend && cd /d "%PROJECT_DIR%" && "%PYTHON_EXE%" -m uvicorn backend:app --reload --port 8000"

echo [2/2] Starting Vite Frontend on http://localhost:5173 ...
start "LexiFlow Frontend (Vite)" cmd /k "title LexiFlow Frontend && cd /d "%FRONTEND_DIR%" && if not exist node_modules (echo Installing frontend packages... && npm install) && npm run dev"

echo.
echo ==========================================================
echo Both Backend and Frontend have been launched in new windows!
echo - Backend API:  http://localhost:8000 (Docs: http://localhost:8000/docs)
echo - Frontend UI:  http://localhost:5173
echo ==========================================================
echo Opening browser in 3 seconds...
ping -n 4 127.0.0.1 >nul
start http://localhost:5173
