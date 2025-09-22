# AWS CLI - Instalador Simples

## 🪟 Windows

### 1. INSTALAR
**Duplo clique** em `windows/instalar.bat` como administrador.

### 2. CONFIGURAR  
**Duplo clique** em `windows/configurar.bat` e siga as instruções.

---

## 🐧 Linux

### 1. INSTALAR
```bash
sudo ./linux/install-aws-cli.sh
```

### 2. CONFIGURAR
```bash
./linux/configurar.sh
```

---

## ❓ O que você precisa ter antes de configurar

Antes de rodar o configurar, você precisa ter:

1. **Access Key ID** (começa com AKIA...)
2. **Secret Access Key** (40 caracteres)

### Como conseguir essas chaves:
1. Entre no console da AWS
2. Vá em **IAM** 
3. Clique em **Usuários**
4. Selecione seu usuário
5. Aba **Credenciais de segurança**
6. **Criar chave de acesso**

---

## ✅ Como saber se funcionou

O script de configurar já testa automaticamente, mas você pode testar manualmente:

```bash
# Teste básico
aws sts get-caller-identity

# Teste específico do seu bucket
aws s3 ls s3://systra-avanco-economico-imports/
```

Se conseguir listar os arquivos do bucket `systra-avanco-economico-imports`, significa que está **100% funcionando**! 🎉
