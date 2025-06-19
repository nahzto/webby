@echo off
chcp 65001 >nul
title Discord Webhook Spammer
setlocal enabledelayedexpansion

echo ██     ██ ███████ ██████  ██████  ██    ██ 
echo ██     ██ ██      ██   ██ ██   ██  ██  ██  
echo ██  █  ██ █████   ██████  ██████    ████   
echo ██ ███ ██ ██      ██   ██ ██   ██    ██    
echo  ███ ███  ███████ ██████  ██████     ██     
echo.

:: Ask for the webhook URL
set /p webhook_url="Webhook URL: "

:: Ask for the message to spam
set /p message="Message: "

:: Ask for the number of times to spam
set /p times="How many times you want to spam the message: "

:: Spamming process
echo Spamming started...
for /l %%i in (1,1,%times%) do (
    curl -X POST -H "Content-Type: application/json" -d "{\"content\": \"%message%\"}" %webhook_url%
    if errorlevel 1 (
        echo Failed to send message %%i/%times%
    ) else (
        echo Sent message %%i/%times%
    )
)
echo Spamming finished!

:: Ask if the user wants to delete the webhook
set /p delete_webhook="Do you want to delete the webhook? (yes/no): "
if /i "%delete_webhook%"=="yes" (
    curl -X DELETE %webhook_url%
    if errorlevel 1 (
        echo Failed to delete webhook!
    ) else (
        echo Webhook deleted!
    )
) else (
    echo Webhook not deleted.
)

pause
exit
