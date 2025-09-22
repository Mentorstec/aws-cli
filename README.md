# AWS CLI - Instalador Simples

## 📥 Como baixar este projeto

```bash
git clone https://github.com/Mentorstec/aws-cli.git
cd aws-cli
```

---

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
**Procure o Fernando Akira ou Fecarotta** - eles vão te fornecer as credenciais necessárias.

---

## ✅ Como saber se funcionou

O script de configurar já testa automaticamente, mas você pode testar manualmente:

```bash
# Teste básico
aws sts get-caller-identity

# Listar buckets disponíveis
aws s3 ls
```

Se aparecer sua identidade AWS e conseguir listar buckets, significa que está **100% funcionando**! 🎉
