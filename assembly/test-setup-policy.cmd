@echo off
setlocal
cd /d "%~dp0.."
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat" >nul
if errorlevel 1 exit /b 1
if not exist ".tools\build\host" mkdir ".tools\build\host"
cl /nologo /std:c++17 /EHsc test\setup-policy.cpp /Fe:.tools\build\host\setup-policy.exe /Fo:.tools\build\host\setup-policy.obj
if errorlevel 1 exit /b 1
.tools\build\host\setup-policy.exe
