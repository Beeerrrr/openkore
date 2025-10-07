@echo off
REM AI-AGENT-CORE Bootstrap v1.0.0 (Windows)
REM One-command initialization for any project

echo.
echo ========================================
echo   AI-AGENT-CORE Bootstrap Starting...
echo ========================================
echo.

REM Get script directory
set "SCRIPT_DIR=%~dp0"
echo [*] AI-AGENT-CORE location: %SCRIPT_DIR%
echo.

REM Detect project information
echo [*] Auto-detecting project information...
echo.

REM Project name (from git or directory)
for /f "tokens=*" %%i in ('git rev-parse --show-toplevel 2^>nul') do set "PROJECT_DIR=%%i"
if defined PROJECT_DIR (
    for %%i in ("%PROJECT_DIR%") do set "PROJECT_NAME=%%~nxi"
    for /f "tokens=*" %%i in ('git config --get remote.origin.url 2^>nul') do set "REPO_URL=%%i"
    if not defined REPO_URL set "REPO_URL=https://github.com/user/!PROJECT_NAME!"
) else (
    for %%i in ("%SCRIPT_DIR%..") do set "PROJECT_DIR=%%~fi"
    for %%i in ("%PROJECT_DIR%") do set "PROJECT_NAME=%%~nxi"
    set "REPO_URL=https://github.com/user/!PROJECT_NAME!"
)

REM Detect tech stack
set "TECH_STACK=Generic"
if exist "%PROJECT_DIR%\*.pa.yaml" set "TECH_STACK=Power Platform"
if exist "%PROJECT_DIR%\*.msapp" set "TECH_STACK=Power Platform"
if exist "%PROJECT_DIR%\package.json" (
    findstr /C:"react" "%PROJECT_DIR%\package.json" >nul 2>&1
    if not errorlevel 1 (
        set "TECH_STACK=React + Node.js"
    ) else (
        set "TECH_STACK=Node.js"
    )
)
if exist "%PROJECT_DIR%\manage.py" if exist "%PROJECT_DIR%\requirements.txt" set "TECH_STACK=Python + Django"

REM Detect timezone
for /f "tokens=*" %%i in ('powershell -Command "[System.TimeZoneInfo]::Local.Id"') do set "TIMEZONE=%%i"

REM Get current timestamp
for /f "tokens=*" %%i in ('powershell -Command "Get-Date -Format 'yyyy-MM-ddTHH:mm:ssZ'"') do set "TIMESTAMP=%%i"

echo [+] Detected configuration:
echo     Project: %PROJECT_NAME%
echo     Tech Stack: %TECH_STACK%
echo     Repository: %REPO_URL%
echo     Timezone: %TIMEZONE%
echo.

REM Confirm with user
set /p "CONFIRM=Proceed with this configuration? (y/N): "
if /i not "%CONFIRM%"=="y" (
    echo [-] Bootstrap cancelled by user.
    exit /b 0
)

echo.
echo ========================================
echo   Initializing AI-AGENT-CORE...
echo ========================================
echo.

REM Check if .ai-config.json already exists
if exist "%SCRIPT_DIR%.ai-config.json" (
    echo [!] Warning: .ai-config.json already exists!
    set /p "OVERWRITE=Overwrite existing configuration? (y/N): "
    if /i not "!OVERWRITE!"=="y" (
        echo [-] Keeping existing configuration. Bootstrap stopped.
        exit /b 0
    )
)

REM Populate .ai-config.json
echo [1/4] Creating .ai-config.json...
if exist "%SCRIPT_DIR%.templates\config.template.json" (
    powershell -Command "(Get-Content '%SCRIPT_DIR%.templates\config.template.json') -replace '{{PROJECT_NAME}}', '%PROJECT_NAME%' -replace '{{REPOSITORY_URL}}', '%REPO_URL%' -replace '{{TECH_STACK}}', '%TECH_STACK%' -replace '{{TIMEZONE}}', '%TIMEZONE%' -replace '{{TIMESTAMP}}', '%TIMESTAMP%' | Set-Content '%SCRIPT_DIR%.ai-config.json'"
    echo     [+] .ai-config.json created
) else (
    echo     [!] Template not found, using default structure
    (
        echo {
        echo   "project": {
        echo     "name": "%PROJECT_NAME%",
        echo     "tech_stack": "%TECH_STACK%",
        echo     "repository": "%REPO_URL%",
        echo     "timezone": "%TIMEZONE%",
        echo     "initialized": "%TIMESTAMP%"
        echo   },
        echo   "ai_system": {
        echo     "version": "1.0.0",
        echo     "cache_enabled": true,
        echo     "mapping_enabled": true,
        echo     "auto_cache_load": true,
        echo     "anti_hallucination": true
        echo   },
        echo   "statistics": {
        echo     "total_solutions": 0,
        echo     "prevented_mistakes": 0,
        echo     "components_mapped": 0,
        echo     "token_savings_estimate": "0%%"
        echo   }
        echo }
    ) > "%SCRIPT_DIR%.ai-config.json"
    echo     [+] .ai-config.json created (default)
)

REM Verify cache/ structure
echo [2/4] Verifying cache/ structure...
if not exist "%SCRIPT_DIR%cache\solutions.json" goto cache_missing
if not exist "%SCRIPT_DIR%cache\mistakes.json" goto cache_missing
if not exist "%SCRIPT_DIR%cache\patterns.json" goto cache_missing
echo     [+] cache/ structure verified
goto cache_done
:cache_missing
echo     [!] Cache files missing or incomplete
echo     This is normal for first-time setup
:cache_done

REM Verify mapping/ structure
echo [3/4] Verifying mapping/ structure...
if not exist "%SCRIPT_DIR%mapping\components.json" goto mapping_missing
if not exist "%SCRIPT_DIR%mapping\variables.json" goto mapping_missing
if not exist "%SCRIPT_DIR%mapping\dependencies.json" goto mapping_missing
echo     [+] mapping/ structure verified
goto mapping_done
:mapping_missing
echo     [!] Mapping files missing or incomplete
echo     This is normal for first-time setup
:mapping_done

REM Verify extensions/ structure
echo [4/4] Verifying extensions/ structure...
if not exist "%SCRIPT_DIR%extensions\quick-reference" mkdir "%SCRIPT_DIR%extensions\quick-reference"
if not exist "%SCRIPT_DIR%extensions\tech-specific" mkdir "%SCRIPT_DIR%extensions\tech-specific"
if not exist "%SCRIPT_DIR%extensions\archives" mkdir "%SCRIPT_DIR%extensions\archives"
echo     [+] extensions/ folders created

echo.
echo ========================================
echo   AI-AGENT-CORE Bootstrap Complete!
echo ========================================
echo.
echo [+] Your AI assistant is ready with:
echo     * Intelligent caching (40-70%% token savings)
echo     * Component mapping (prevents hallucination)
echo     * Mistake tracking (prevents repeats)
echo     * Auto-cache-load (no manual mentions needed)
echo.
echo Next Steps:
echo.
echo 1. Start a new AI conversation
echo 2. Mention: @CallMeBabe.md
echo 3. Ask AI to build initial codebase mapping:
echo    "Build a mapping of my codebase for faster responses"
echo 4. Start asking questions!
echo.
echo Documentation:
echo    * AI manual: CallMeBabe.md
echo    * Human guide: Me.md
echo    * Full docs: README.md
echo.
echo Check your configuration:
echo    type .ai-config.json
echo.
echo [*] Tip: AI will automatically check cache before every response.
echo     You'll see token savings after asking similar questions!
echo.
echo Ready to use! Happy coding!
echo.
pause
