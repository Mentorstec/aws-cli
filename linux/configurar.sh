#!/bin/bash

echo "========================================"
echo "   CONFIGURAR AWS - PASSO A PASSO"
echo "========================================"
echo
echo "Este script vai te ensinar a configurar a AWS CLI."
echo "Vai ser bem fácil, prometo!"
echo
echo "IMPORTANTE: Você precisa ter em mãos:"
echo "1. Access Key ID (começa com AKIA...)"
echo "2. Secret Access Key (string longa de 40 caracteres)"
echo
echo "Se você NÃO tem essas informações, pare aqui e:"
echo "- Vá no console da AWS"
echo "- Acesse IAM"
echo "- Crie um usuário ou pegue as chaves existentes"
echo
read -p "Pressione Enter quando estiver pronto para continuar..."
echo
echo "========================================"
echo "   VAMOS COMEÇAR A CONFIGURAÇÃO"
echo "========================================"
echo
echo "O que vai acontecer agora:"
echo "1. Vou perguntar sua Access Key ID"
echo "2. Vou perguntar sua Secret Access Key"
echo "3. Vou perguntar a região (pode deixar em branco)"
echo "4. Vou perguntar o formato (pode deixar em branco)"
echo
echo "ATENÇÃO: Digite as informações com CUIDADO!"
echo "Se errar, pode rodar este script de novo."
echo
read -p "Pressione Enter para começar..."
echo
echo "Iniciando configuração..."
aws configure
echo
echo "========================================"
echo "   TESTANDO SE FUNCIONOU"
echo "========================================"
echo
echo "Agora vou testar se a configuração está funcionando..."
echo

if aws sts get-caller-identity > /dev/null 2>&1; then
    echo "========================================"
    echo "   SUCESSO! TUDO FUNCIONANDO!"
    echo "========================================"
    echo
    echo "Parabéns! Sua AWS CLI está configurada e funcionando."
    echo
    echo "Sua identidade AWS:"
    aws sts get-caller-identity
    echo
    echo "COMANDOS ÚTEIS PARA VOCÊ USAR:"
    echo "aws s3 ls                                              (listar todos os buckets)"
    echo "aws s3 ls s3://systra-avanco-economico-imports/        (listar arquivos do bucket)"
    echo "aws ec2 describe-instances                             (listar instâncias EC2)"
    echo
    echo "TESTE FINAL - Vamos ver se consegue acessar o bucket:"
    echo
    if aws s3 ls s3://systra-avanco-economico-imports/ > /dev/null 2>&1; then
        echo "PERFEITO! Você consegue acessar o bucket systra-avanco-economico-imports"
        echo "Isso significa que sua configuração está 100% funcionando!"
        echo
        echo "Conteúdo do bucket:"
        aws s3 ls s3://systra-avanco-economico-imports/
    else
        echo "ATENÇÃO: Não foi possível acessar o bucket systra-avanco-economico-imports"
        echo "Isso pode ser porque você não tem permissão para este bucket específico."
        echo "Mas se o comando anterior funcionou, sua AWS CLI está OK!"
    fi
    echo
else
    echo "========================================"
    echo "   ALGO DEU ERRADO..."
    echo "========================================"
    echo
    echo "Não foi possível conectar na AWS."
    echo "Isso pode acontecer por:"
    echo
    echo "1. Access Key ID digitada errada"
    echo "2. Secret Access Key digitada errada"
    echo "3. Usuário sem permissão"
    echo "4. Problema de internet"
    echo
    echo "SOLUÇÃO: Execute este script novamente e"
    echo "confira bem as informações que você digitou."
    echo
fi

echo
read -p "Pressione Enter para finalizar..."