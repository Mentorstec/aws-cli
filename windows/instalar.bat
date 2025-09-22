@echo off
echo ========================================
echo    AWS CLI - Instalador Simples
echo ========================================
echo.

echo Baixando AWS CLI...
powershell -Command "Invoke-WebRequest -Uri 'https://awscli.amazonaws.com/AWSCLIV2.msi' -OutFile '%TEMP%\aws.msi'"

echo Instalando AWS CLI...
msiexec /i "%TEMP%\aws.msi" /quiet /norestart

echo Limpando arquivos temporarios...
del "%TEMP%\aws.msi"

echo.
echo Instalacao concluida!
echo.
echo Para configurar, digite no prompt:
echo aws configure
echo.
pause