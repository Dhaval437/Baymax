@echo off
cd /d "%~dp0"
node --env-file-if-exists=.env start-baymax.mjs
if errorlevel 1 pause
