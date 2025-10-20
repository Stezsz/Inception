#!/bin/bash

# Script de instalação do Docker e Docker Compose no Ubuntu WSL
# Para o projeto Inception

echo "======================================"
echo "  Instalando Docker no WSL Ubuntu"
echo "======================================"
echo ""

# Atualizar repositórios
echo "[1/6] Atualizando repositórios..."
sudo apt-get update

# Instalar dependências
echo ""
echo "[2/6] Instalando dependências..."
sudo apt-get install -y \
	ca-certificates \
	curl \
	gnupg \
	lsb-release

# Adicionar chave GPG oficial do Docker
echo ""
echo "[3/6] Adicionando chave GPG do Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Adicionar repositório do Docker
echo ""
echo "[4/6] Adicionando repositório do Docker..."
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualizar repositórios novamente
echo ""
echo "[5/6] Atualizando lista de pacotes..."
sudo apt-get update

# Instalar Docker Engine, CLI, Containerd e Docker Compose
echo ""
echo "[6/6] Instalando Docker Engine, CLI e Docker Compose..."
sudo apt-get install -y \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	docker-buildx-plugin \
	docker-compose-plugin

# Adicionar usuário ao grupo docker
echo ""
echo "Adicionando usuário ao grupo docker..."
sudo usermod -aG docker $USER

# Iniciar serviço Docker
echo ""
echo "Iniciando serviço Docker..."
sudo service docker start

# Verificar instalação
echo ""
echo "======================================"
echo "  Verificando instalação"
echo "======================================"
docker --version
docker compose version

echo ""
echo "======================================"
echo "  Instalação concluída!"
echo "======================================"
echo ""
echo "IMPORTANTE:"
echo "1. Feche e reabra o terminal WSL para aplicar as permissões do grupo docker"
echo "2. Ou execute: newgrp docker"
echo ""
echo "Para testar, execute:"
echo "  docker run hello-world"
echo ""
echo "Para o projeto Inception, execute:"
echo "  cd ~/Inception/inception"
echo "  make all"
echo ""
