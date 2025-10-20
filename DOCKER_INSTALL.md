# 🐳 Instalação do Docker no WSL Ubuntu 24.04

## Método 1: Script Automático (Recomendado)

Execute o script de instalação que criei:

```bash
# No terminal WSL Ubuntu
cd ~/Inception
chmod +x install_docker.sh
./install_docker.sh
```

Depois da instalação:
```bash
# Feche e reabra o terminal WSL, ou execute:
newgrp docker

# Teste a instalação
docker run hello-world
```

---

## Método 2: Instalação Manual

### 1. Atualizar sistema
```bash
sudo apt-get update
sudo apt-get upgrade -y
```

### 2. Instalar dependências
```bash
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

### 3. Adicionar chave GPG do Docker
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

### 4. Adicionar repositório do Docker
```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### 5. Instalar Docker
```bash
sudo apt-get update
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
```

### 6. Configurar permissões
```bash
# Adicionar usuário ao grupo docker
sudo usermod -aG docker $USER

# Iniciar serviço Docker
sudo service docker start

# Aplicar permissões (feche e reabra o terminal, ou execute):
newgrp docker
```

### 7. Verificar instalação
```bash
docker --version
docker compose version
docker run hello-world
```

---

## Método 3: Docker Desktop (Alternativa)

Se preferir usar interface gráfica:

1. Baixe o [Docker Desktop para Windows](https://www.docker.com/products/docker-desktop/)
2. Durante a instalação, habilite a integração com WSL
3. Nas configurações do Docker Desktop:
   - Settings → Resources → WSL Integration
   - Habilite para Ubuntu-24.04

---

## Comandos úteis

### Iniciar Docker no WSL
```bash
sudo service docker start
```

### Verificar status
```bash
sudo service docker status
```

### Parar Docker
```bash
sudo service docker stop
```

### Auto-iniciar Docker (adicione ao ~/.bashrc)
```bash
echo 'if ! service docker status >/dev/null 2>&1; then sudo service docker start >/dev/null 2>&1; fi' >> ~/.bashrc
```

---

## Troubleshooting

### Erro: "Cannot connect to Docker daemon"
```bash
sudo service docker start
```

### Erro: "permission denied"
```bash
# Adicionar usuário ao grupo docker
sudo usermod -aG docker $USER
newgrp docker
```

### Verificar se Docker está rodando
```bash
ps aux | grep docker
```

---

## Para o projeto Inception

Após instalar o Docker:

```bash
cd ~/Inception/inception

# Criar diretórios de dados e iniciar projeto
make all

# Ver logs
make logs

# Ver status
make status

# Parar containers
make down

# Limpar tudo
make fclean
```

---

## Comandos do Makefile

- `make` ou `make all` - Setup e iniciar tudo
- `make up` - Build e start containers
- `make down` - Parar e remover containers
- `make clean` - Limpar volumes e imagens
- `make fclean` - Limpar tudo (incluindo dados)
- `make re` - Rebuild completo
- `make logs` - Ver logs
- `make status` - Ver status dos containers
- `make help` - Mostrar ajuda

---

## Notas Importantes

⚠️ **Para WSL 2**: Certifique-se de estar usando WSL 2, não WSL 1:
```bash
wsl --list --verbose
# Se aparecer WSL 1, converta:
wsl --set-version Ubuntu-24.04 2
```

⚠️ **Systemd**: O Ubuntu 24.04 no WSL já tem systemd habilitado por padrão

⚠️ **Memória**: Docker no WSL compartilha recursos com Windows. Configure em `.wslconfig` se necessário
