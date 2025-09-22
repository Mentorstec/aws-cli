@echo off
setlocal

REM Caminho base
set BASE_PATH=\\systra.info\BR_DFS\SAOPAULO\PMO\9_Cloud
set BUCKET=s3://systra-avanco-economico-imports/

REM Caminhos para as pastas de origem
set PATH_RLS=%BASE_PATH%\0_RLS
set PATH_AVANCO_ECONOMICO_HOM=%BASE_PATH%\1_Avanco_Economico\Homologacao
set PATH_AVANCO_ECONOMICO_PROD=%BASE_PATH%\1_Avanco_Economico\Producao
set PATH_AVANCO_FISICO_HOM=%BASE_PATH%\2_Avanco_Fisico\Homologacao
set PATH_AVANCO_FISICO_PROD=%BASE_PATH%\2_Avanco_Fisico\Producao

REM Upload apenas de arquivos .xls e .xlsx
aws s3 cp "%PATH_RLS%" "%BUCKET%0_RLS/" --recursive --exclude "*" --include "*.xls" --include "*.xlsx"
aws s3 cp "%PATH_AVANCO_ECONOMICO_HOM%" "%BUCKET%1_Avanco_Economico/Homologacao/" --recursive --exclude "*" --include "*.xls" --include "*.xlsx"
aws s3 cp "%PATH_AVANCO_ECONOMICO_PROD%" "%BUCKET%1_Avanco_Economico/Producao/" --recursive --exclude "*" --include "*.xls" --include "*.xlsx"
aws s3 cp "%PATH_AVANCO_FISICO_HOM%" "%BUCKET%2_Avanco_Fisico/Homologacao/" --recursive --exclude "*" --include "*.xls" --include "*.xlsx"
aws s3 cp "%PATH_AVANCO_FISICO_PROD%" "%BUCKET%2_Avanco_Fisico/Producao/" --recursive --exclude "*" --include "*.xls" --include "*.xlsx"

pause
