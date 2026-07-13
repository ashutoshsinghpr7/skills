@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "SCRIPT_PATH=%~dp0resolve-latest-model-info.cjs"

if defined NODE (
  if exist "%NODE%" (
    "%NODE%" "%SCRIPT_PATH%" %*
    exit /b !ERRORLEVEL!
  )
)

where node >nul 2>nul
if not errorlevel 1 (
  node "%SCRIPT_PATH%" %*
  exit /b !ERRORLEVEL!
)

for %%N in (
  "%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\node\bin\node.exe"
  "%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\bin\node.exe"
  "%LOCALAPPDATA%\Programs\nodejs\node.exe"
  "%ProgramFiles%\nodejs\node.exe"
  "%ProgramFiles(x86)%\nodejs\node.exe"
) do (
  if exist "%%~N" (
    "%%~N" "%SCRIPT_PATH%" %*
    exit /b !ERRORLEVEL!
  )
)

>&2 echo No usable Node runtime found for resolve-latest-model-info.cjs
exit /b 127
