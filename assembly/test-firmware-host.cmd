@echo off
setlocal
cd /d "%~dp0.."
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat" >nul
if not "%errorlevel%"=="0" exit /b %errorlevel%
if not exist ".tools\build\host" mkdir ".tools\build\host"
cl /nologo /std:c++17 /EHsc /Itest\firmware-stubs test\servo-controller.cpp /Fe:.tools\build\host\servo-controller.exe /Fo:.tools\build\host\servo-controller.obj
if not "%errorlevel%"=="0" exit /b %errorlevel%
.tools\build\host\servo-controller.exe
if not "%errorlevel%"=="0" exit /b %errorlevel%
cl /nologo /std:c++17 /EHsc test\listening-policy.cpp /Fe:.tools\build\host\listening-policy.exe /Fo:.tools\build\host\listening-policy.obj
if not "%errorlevel%"=="0" exit /b %errorlevel%
.tools\build\host\listening-policy.exe
if not "%errorlevel%"=="0" exit /b %errorlevel%
cl /nologo /std:c++17 /EHsc test\noise-floor.cpp /Fe:.tools\build\host\noise-floor.exe /Fo:.tools\build\host\noise-floor.obj
if not "%errorlevel%"=="0" exit /b %errorlevel%
.tools\build\host\noise-floor.exe
if not "%errorlevel%"=="0" exit /b %errorlevel%
cl /nologo /std:c++17 /EHsc test\speech-onset.cpp /Fe:.tools\build\host\speech-onset.exe /Fo:.tools\build\host\speech-onset.obj
if not "%errorlevel%"=="0" exit /b %errorlevel%
.tools\build\host\speech-onset.exe
