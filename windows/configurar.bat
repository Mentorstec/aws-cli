@echo off
echo ========================================
echo    CONFIGURAR AWS - PASSO A PASSO
echo ========================================
echo.
echo Este script vai te ensinar a configurar a AWS CLI.
echo Vai ser bem facil, prometo!
echo.
echo IMPORTANTE: Voce precisa ter em maos:
echo 1. Access Key ID (comeca com AKIA...)
echo 2. Secret Access Key (string longa de 40 caracteres)
echo.
echo Se voce NAO tem essas informacoes, pare aqui e:
echo - Va no console da AWS
echo - Acesse IAM
echo - Crie um usuario ou pegue as chaves existentes
echo.
pause
echo.
echo ========================================
echo    VAMOS COMECAR A CONFIGURACAO
echo ========================================
echo.
echo O que vai acontecer agora:
echo 1. Vou perguntar sua Access Key ID
echo 2. Vou perguntar sua Secret Access Key
echo 3. Vou perguntar a regiao (pode deixar em branco)
echo 4. Vou perguntar o formato (pode deixar em branco)
echo.
echo ATENCAO: Digite as informacoes com CUIDADO!
echo Se errar, pode rodar este script de novo.
echo.
pause
echo.
echo Iniciando configuracao...
aws configure
echo.
echo ========================================
echo    TESTANDO SE FUNCIONOU
echo ========================================
echo.
echo Agora vou testar se a configuracao esta funcionando...
echo.
aws sts get-caller-identity
echo.
if %errorlevel% equ 0 (
    echo ========================================
    echo    SUCESSO! TUDO FUNCIONANDO!
    echo ========================================
    echo.
    echo Parabens! Sua AWS CLI esta configurada e funcionando.
    echo.
    echo COMANDOS UTEIS PARA VOCE USAR:
    echo aws s3 ls                                              (listar todos os buckets)
    echo aws s3 ls s3://systra-avanco-economico-imports/        (listar arquivos do bucket)
    echo aws ec2 describe-instances                             (listar instancias EC2)
    echo.
    echo TESTE FINAL - Vamos ver se consegue acessar o bucket:
    echo.
    aws s3 ls s3://systra-avanco-economico-imports/
    echo.
    if %errorlevel% equ 0 (
        echo PERFEITO! Voce consegue acessar o bucket systra-avanco-economico-imports
        echo Isso significa que sua configuracao esta 100%% funcionando!
    ) else (
        echo ATENCAO: Nao foi possivel acessar o bucket systra-avanco-economico-imports
        echo Isso pode ser porque voce nao tem permissao para este bucket especifico.
        echo Mas se o comando anterior funcionou, sua AWS CLI esta OK!
    )
    echo.
) else (
    echo ========================================
    echo    ALGO DEU ERRADO...
    echo ========================================
    echo.
    echo Nao foi possivel conectar na AWS.
    echo Isso pode acontecer por:
    echo.
    echo 1. Access Key ID digitada errada
    echo 2. Secret Access Key digitada errada  
    echo 3. Usuario sem permissao
    echo 4. Problema de internet
    echo.
    echo SOLUCAO: Execute este script novamente e
    echo confira bem as informacoes que voce digitou.
    echo.
)
echo.
pause