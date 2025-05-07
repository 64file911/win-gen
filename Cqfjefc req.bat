@echo off
set "PYTHON_URL=https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe"
set "PYTHON_INSTALLER=python310.exe"
set "SCRIPT_URL=https://example.com/myscript.py"
set "SCRIPT_NAME=myscript.py"

:: Check for Python
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo Python not found. Downloading Python 3.10...
    curl -L -o %PYTHON_INSTALLER% %PYTHON_URL%
    
    echo Installing Python 3.10 silently...
    %PYTHON_INSTALLER% /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

    echo Waiting for install to complete...
    timeout /t 10 >nul

    :: Check again after install
    where python >nul 2>&1
    if %errorlevel% neq 0 (
        echo Failed to install Python. Exiting.
        pause
        exit /b
    )
)

:: Create requirements.txt
echo requests> requirements.txt
echo discord.py>> requirements.txt

:: Install required packages
echo Installing Python modules...
pip install -r requirements.txt

:: Download Python script (optional)
echo Downloading Python script...
curl -L -o %SCRIPT_NAME% %SCRIPT_URL%

:: Run the script
echo Running script...
python %SCRIPT_NAME%

pause
