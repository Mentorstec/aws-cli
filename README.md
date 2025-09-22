# AWS CLI - Instalador Simples

## 🔧 Como abrir CMD como administrador

### Windows 10/11:
1. **Clique** no botão Iniciar
2. **Digite** "cmd" ou "prompt"
3. **Clique com botão direito** em "Prompt de Comando"
4. **Selecione** "Executar como administrador"

### Ou pelo atalho:
**Pressione** `Windows + X` e escolha "Terminal (Admin)" ou "Prompt de Comando (Admin)"

---

## 📥 Como baixar este projeto

```bash
# Criar pasta e navegar até ela
mkdir -p ~/Documentos/mentorstec
cd ~/Documentos/mentorstec

# Clonar o repositório
git clone https://github.com/Mentorstec/aws-cli.git
cd aws-cli
```

**No Windows (CMD):**
```cmd
mkdir "%USERPROFILE%\Documentos\mentorstec"
cd "%USERPROFILE%\Documentos\mentorstec"
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
aws s3 ls << nome do bucket >>
```

Se aparecer sua identidade AWS e conseguir listar buckets, significa que está **100% funcionando**! 🎉

---

## 📤 Script para enviar arquivos ao S3

O projeto inclui um script `envia_arquivos_s3.bat` que automatiza o envio de arquivos Excel para o S3.

### ⚙️ O que o script faz:
- **Envia apenas** arquivos `.xls` e `.xlsx`
- **Organiza** os arquivos em pastas específicas no S3
- **Sincroniza** com as pastas da rede Systra

### 📁 Estrutura de pastas:
```
Origem (Rede Systra):                    → Destino (S3):
\\systra.info\BR_DFS\SAOPAULO\PMO\9_Cloud\
├── 0_RLS\                              → s3://bucket/0_RLS/
├── 1_Avanco_Economico\Homologacao\     → s3://bucket/1_Avanco_Economico/Homologacao/
├── 1_Avanco_Economico\Producao\        → s3://bucket/1_Avanco_Economico/Producao/
├── 2_Avanco_Fisico\Homologacao\        → s3://bucket/2_Avanco_Fisico/Homologacao/
└── 2_Avanco_Fisico\Producao\           → s3://bucket/2_Avanco_Fisico/Producao/
```

### 🚀 Como usar:
1. **Configure** a AWS CLI primeiro (use os scripts de instalação)
2. **Duplo clique** em `envia_arquivos_s3.bat`
3. **Aguarde** o upload concluir

### ⚠️ Pré-requisitos:
- AWS CLI configurada e funcionando
- Acesso à rede `\\systra.info\BR_DFS\`
- Permissões para gravar no bucket S3
