#!/bin/bash

# Script para instalação automática da AWS CLI no Linux
# Versão: Interativa (solicita credenciais durante execução)

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variáveis globais
QUIET=false
SKIP_SUDO_CHECK=false

# Funções utilitárias
print_color() {
    local color=$1
    local message=$2
    if [ "$QUIET" = false ]; then
        echo -e "${color}${message}${NC}"
    fi
}

print_error() {
    print_color "$RED" "✗ $1"
}

print_success() {
    print_color "$GREEN" "✓ $1"
}

print_warning() {
    print_color "$YELLOW" "⚠ $1"
}

print_info() {
    print_color "$BLUE" "$1"
}

print_cyan() {
    print_color "$CYAN" "$1"
}

# Verificar se o usuário tem privilégios sudo
check_sudo() {
    if [ "$SKIP_SUDO_CHECK" = true ]; then
        return 0
    fi
    
    if ! sudo -n true 2>/dev/null; then
        print_error "Este script precisa de privilégios sudo para instalação!"
        print_warning "Execute: sudo $0"
        exit 1
    fi
}

# Detectar distribuição Linux
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    elif [ -f /etc/redhat-release ]; then
        echo "rhel"
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    else
        echo "unknown"
    fi
}

# Instalar dependências baseadas na distribuição
install_dependencies() {
    local distro=$(detect_distro)
    
    print_info "Detectada distribuição: $distro"
    print_info "Instalando dependências..."
    
    case $distro in
        ubuntu|debian)
            sudo apt-get update -qq
            sudo apt-get install -y curl unzip
            ;;
        fedora)
            sudo dnf install -y curl unzip
            ;;
        centos|rhel|rocky|almalinux)
            sudo yum install -y curl unzip
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm curl unzip
            ;;
        opensuse*)
            sudo zypper install -y curl unzip
            ;;
        *)
            print_warning "Distribuição não reconhecida. Tentando instalar dependências manualmente..."
            if command -v apt-get &> /dev/null; then
                sudo apt-get update -qq && sudo apt-get install -y curl unzip
            elif command -v yum &> /dev/null; then
                sudo yum install -y curl unzip
            elif command -v dnf &> /dev/null; then
                sudo dnf install -y curl unzip
            else
                print_error "Não foi possível instalar dependências automaticamente"
                print_warning "Instale manualmente: curl, unzip"
                exit 1
            fi
            ;;
    esac
    
    print_success "Dependências instaladas!"
}

# Verificar se AWS CLI já está instalado
check_aws_installation() {
    if command -v aws &> /dev/null; then
        print_warning "AWS CLI já está instalado. Versão:"
        aws --version
        
        if [ "$QUIET" = false ]; then
            read -p "Deseja reinstalar? (s/n): " reinstall
            if [[ ! "$reinstall" =~ ^[Ss]$ ]]; then
                print_warning "Pulando instalação..."
                return 1
            fi
        else
            return 1
        fi
    fi
    return 0
}

# Instalar AWS CLI
install_aws_cli() {
    print_info "Baixando AWS CLI..."
    
    # Detectar arquitetura
    local arch=$(uname -m)
    local aws_cli_url
    
    case $arch in
        x86_64)
            aws_cli_url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
            ;;
        aarch64|arm64)
            aws_cli_url="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"
            ;;
        *)
            print_error "Arquitetura não suportada: $arch"
            exit 1
            ;;
    esac
    
    local temp_dir=$(mktemp -d)
    local zip_file="$temp_dir/awscliv2.zip"
    
    # Download
    if ! curl -sL "$aws_cli_url" -o "$zip_file"; then
        print_error "Falha no download da AWS CLI"
        rm -rf "$temp_dir"
        exit 1
    fi
    
    print_success "Download concluído!"
    
    # Extrair e instalar
    print_info "Instalando AWS CLI..."
    cd "$temp_dir"
    unzip -q awscliv2.zip
    
    # Remover instalação anterior se existir
    if [ -d "/usr/local/aws-cli" ]; then
        sudo rm -rf /usr/local/aws-cli
    fi
    
    if [ -L "/usr/local/bin/aws" ]; then
        sudo rm /usr/local/bin/aws
    fi
    
    if [ -L "/usr/local/bin/aws_completer" ]; then
        sudo rm /usr/local/bin/aws_completer
    fi
    
    # Instalar
    sudo ./aws/install
    
    # Limpar arquivos temporários
    rm -rf "$temp_dir"
    
    print_success "AWS CLI instalada com sucesso!"
}

# Verificar instalação
verify_installation() {
    print_info "Verificando instalação..."
    
    if command -v aws &> /dev/null; then
        local version=$(aws --version 2>&1)
        print_success "AWS CLI instalada: $version"
        return 0
    else
        print_error "AWS CLI não foi encontrada no PATH"
        print_warning "Você pode precisar reiniciar o terminal ou fazer logout/login"
        return 1
    fi
}

# Configurar AWS CLI
configure_aws_cli() {
    print_color "$GREEN" "\n=== Configuração AWS CLI ==="
    echo
    
    # Solicitar credenciais
    read -p "Digite sua AWS Access Key ID: " access_key
    read -s -p "Digite sua AWS Secret Access Key: " secret_key
    echo
    
    echo
    print_color "$NC" "Regiões AWS mais comuns:"
    print_color "$NC" "  us-east-1      (Norte da Virgínia)"
    print_color "$NC" "  us-west-2      (Oregon)"
    print_color "$NC" "  eu-west-1      (Irlanda)"
    print_color "$NC" "  sa-east-1      (São Paulo)"
    print_color "$NC" "  ap-southeast-1 (Singapura)"
    
    read -p "Digite a região AWS [padrão: us-east-1]: " region
    region=${region:-us-east-1}
    
    read -p "Formato de saída (json/yaml/text/table) [padrão: json]: " output_format
    output_format=${output_format:-json}
    
    print_info "\nConfigurando AWS CLI..."
    
    # Criar diretório .aws se não existir
    mkdir -p ~/.aws
    
    # Configurar usando aws configure
    aws configure set aws_access_key_id "$access_key"
    aws configure set aws_secret_access_key "$secret_key"
    aws configure set default.region "$region"
    aws configure set default.output "$output_format"
    
    print_success "AWS CLI configurada com sucesso!"
    
    # Testar configuração
    print_info "\nTestando configuração..."
    
    if identity=$(aws sts get-caller-identity 2>&1); then
        print_success "Teste realizado com sucesso!"
        print_cyan "Identidade AWS:"
        echo "$identity"
    else
        print_warning "Não foi possível testar a configuração"
        print_error "Erro: $identity"
        print_warning "Verifique suas credenciais e conectividade com a internet"
    fi
    
    # Limpar variáveis sensíveis
    unset access_key secret_key
}

# Mostrar informações de uso
show_usage_info() {
    print_color "$GREEN" "\n=== Instalação e Configuração Concluída ==="
    echo
    print_cyan "Comandos úteis:"
    print_color "$NC" "  aws --version                    # Verificar versão"
    print_color "$NC" "  aws configure list               # Ver configuração atual"
    print_color "$NC" "  aws sts get-caller-identity      # Testar credenciais"
    print_color "$NC" "  aws s3 ls                        # Listar buckets S3"
    echo
    print_warning "Para reconfigurar: aws configure"
}

# Mostrar ajuda
show_help() {
    echo "Uso: $0 [opções]"
    echo
    echo "Opções:"
    echo "  -q, --quiet           Modo silencioso"
    echo "  --skip-sudo-check     Pular verificação de sudo"
    echo "  -h, --help            Mostrar esta ajuda"
    echo
}

# Processar argumentos da linha de comando
while [[ $# -gt 0 ]]; do
    case $1 in
        -q|--quiet)
            QUIET=true
            shift
            ;;
        --skip-sudo-check)
            SKIP_SUDO_CHECK=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "Opção desconhecida: $1"
            show_help
            exit 1
            ;;
    esac
done

# Script principal
main() {
    print_color "$GREEN" "=== Instalador Automático AWS CLI ==="
    
    # Verificar privilégios
    check_sudo
    
    # Instalar dependências
    install_dependencies
    
    # Verificar instalação existente
    skip_install=false
    if ! check_aws_installation; then
        skip_install=true
    fi
    
    # Instalar AWS CLI se necessário
    if [ "$skip_install" = false ]; then
        install_aws_cli
    fi
    
    # Verificar instalação
    if ! verify_installation; then
        exit 1
    fi
    
    # Configurar AWS CLI
    configure_aws_cli
    
    # Mostrar informações de uso
    show_usage_info
    
    if [ "$QUIET" = false ]; then
        read -p "Pressione Enter para continuar..."
    fi
}

# Executar script principal
main "$@"