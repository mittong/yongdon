@echo off
chcp 65001 >nul
cd /d "%~dp0"
set PORT=8080

where python >nul 2>nul
if %errorlevel%==0 goto usepython
where py >nul 2>nul
if %errorlevel%==0 goto usepy
where npx >nul 2>nul
if %errorlevel%==0 goto usenode

echo.
echo  Python or Node.js is required to preview the app.
echo  Install Python from https://www.python.org/downloads/ (check "Add python.exe to PATH"), then run this file again.
echo.
pause
exit /b

:usepython
echo.
echo  Preview: http://localhost:%PORT%/preview.html   (close this window to stop)
echo.
start "" "http://localhost:%PORT%/preview.html"
python -m http.server %PORT%
goto end

:usepy
echo.
echo  Preview: http://localhost:%PORT%/preview.html   (close this window to stop)
echo.
start "" "http://localhost:%PORT%/preview.html"
py -m http.server %PORT%
goto end

:usenode
echo.
echo  Preview: http://localhost:%PORT%/preview.html   (close this window to stop)
echo.
start "" "http://localhost:%PORT%/preview.html"
npx --yes http-server -p %PORT% -c-1
goto end

:end
pause
