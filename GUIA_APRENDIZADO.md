# 📚 Guia de Aprendizado - Projeto Inception

**Aluno:** strodrig
**Data de Início:** 17 de outubro de 2025
**Objetivo:** Aprender System Administration através do Docker

---

## 🎯 Resumo do Projeto

O Inception é um projeto de Administração de Sistemas que envolve:
- Criar uma infraestrutura usando Docker
- Configurar múltiplos serviços em containers separados
- Aprender sobre virtualização, redes e orquestração

---

## 📁 Estrutura Atual do Projeto

```
Inception/                          ← Repositório GitHub pessoal
├── .gitignore                  ✅ Configurado
├── GUIA_APRENDIZADO.md         ✅ Este arquivo
├── README.md
├── en.subject.txt
└── inception/                  ✅ Pasta para submeter (estrutura correta!)
    ├── Makefile                ⚠️  Precisa adaptar para Docker
    └── srcs/
        ├── .env.example        ✅ Template pronto
        ├── .env                ✅ Suas senhas (não commitar!)
        ├── docker-compose.yml  ✅ CRIADO! Nota 9.5/10
        └── requirements/       ✅ Estrutura correta do subject!
            ├── mariadb/
            │   ├── Dockerfile  📝 Em andamento
            │   ├── conf/
            │   └── tools/      ✅ init_db.sh criado
            ├── nginx/
            │   ├── Dockerfile  📝 Próximo
            │   ├── conf/
            │   └── tools/
            └── wordpress/
                ├── Dockerfile  📝 Próximo
                ├── conf/
                └── tools/
```

**Legenda:**
- ✅ Pronto
- ⚠️  Precisa modificar
- 📝 Precisa criar/preencher

---

## 📋 Checklist de Requisitos Obrigatórios
### Estrutura do Projeto
- [x] Criar pasta `srcs/` com todos os arquivos de configuração
- [x] Criar pasta `requirements/` (exigida pelo subject!)
- [x] Criar estrutura de pastas (nginx/, mariadb/, wordpress/)
- [x] Criar `.env.example` (template com variáveis)
- [x] Criar `.env` localmente (com senhas reais - NUNCA commitar!)
- [x] Configurar `.gitignore` para ignorar `.env`
- [ ] Adaptar `Makefile` para orquestrar Docker
- [ ] Adaptar `Makefile` para orquestrar Docker (ainda está do Cub3D)
### Containers Necessários
- [ ] **NGINX** - Servidor web com TLSv1.2 ou TLSv1.3
- [ ] **WordPress** - Com php-fpm (sem nginx)
- [x] **MariaDB** - Banco de dados (em andamento - init_db.sh criado)
- [ ] **MariaDB** - Banco de dados (sem nginx)

### Volumes
- [x] Volume para database do WordPress
- [x] Volume para arquivos do site WordPress
- [x] Volumes configurados em `/home/strodrig/data/`

### Rede
- [x] Docker network conectando os containers
- [x] Apenas porta 443 acessível externamente (NGINX)
### Configurações Importantes
- [x] Containers reiniciam automaticamente em caso de crash (`restart: always`)
- [ ] Usar Alpine ou Debian (penúltima versão estável)
- [ ] Um Dockerfile por serviço
- [ ] Dois usuários no WordPress (admin não pode ter "admin" no nome)
- [x] Senhas NUNCA no Dockerfile (usar arquivo `.env`)
- [x] `.env` NUNCA deve ser commitado no git (usar `.gitignore`)
- [x] Evitar comandos infinitos (usando loops com timeout!)
- [ ] Evitar comandos infinitos (tail -f, sleep infinity, while true)

---

## 🚫 Proibições Importantes

❌ **NÃO FAZER:**
- Usar `network: host`, `--link` ou `links:`
- Pull de imagens prontas do DockerHub (exceto Alpine/Debian base)
- Tag `latest` nas imagens
- Senhas hardcoded nos Dockerfiles
- Comandos infinitos (tail -f, bash, sleep infinity, while true)
- Username com "admin" ou "administrator" no WordPress

---

## 📝 Diário de Aprendizado
### Sessão 1 - [Data: 17/10/2025]
**Tópico:** Estrutura do Projeto, Makefile e Segurança

**O que aprendi hoje:**
- Diferença entre Makefile de compilação (Cub3D) vs orquestração (Inception)
- No Inception, o Makefile não compila código, ele gerencia Docker
- Docker Compose é a ferramenta que orquestra múltiplos containers
- Comandos básicos: docker-compose up/down/build
- **DECISÃO:** Usar apenas `.env` (mais simples que `.env` + `secrets/`)
- `.env` NUNCA deve ir para o git (usar `.gitignore`)
- `.env.example` pode e deve ser commitado (template sem senhas)
- Subject é claro: credenciais no git = falha no projeto!

**Dúvidas que surgiram:**
- ✅ Posso usar só .env ao invés de secrets/? SIM!
- ✅ Preciso ignorar .env no git? SIM, obrigatório!
- Como estruturar as pastas do projeto?
- O que vai dentro de cada Dockerfile?
- Como o docker-compose.yml conecta tudo?

**Conceitos para estudar:**
- ✅ Diferença Makefile compilação vs orquestração
- ✅ .env vs secrets (decidido por usar só .env)
- ✅ .gitignore e segurança de credenciais
- Docker e Containers (próximo)
- Docker Compose (próximo)
- NGINX como reverse proxy
- PHP-FPM
- MariaDB
- TLS/SSL
- Volumes no Docker
- Docker Networks
- PID 1 e processos em containers

**Próximos passos:**
1. ✅ Criar .gitignore
2. ✅ Estrutura de pastas já existe!
3. ✅ .env.example já existe!
4. ✅ docker-compose.yml criado e entendido!
5. Adaptar Makefile para Docker
6. Criar Dockerfiles (MariaDB, WordPress, NGINX)

---

### Sessão 2 - [Data: 17/10/2025]
**Tópico:** Docker Compose - Orquestração de Serviços

**O que aprendi hoje:**
- **Ordem de inicialização:** MariaDB → WordPress → NGINX (dependências!)
- **depends_on:** Garante ordem, mas não garante que serviço está "pronto"
- **Volumes:** Persistem dados mesmo se container morrer (como HD externo)
- **Networks:** Docker cria DNS interno - containers se acham pelo nome!
- **Portas:** Só NGINX expõe 443, outros ficam internos (mais seguro)
- **Variáveis .env:** Docker injeta automaticamente com `${VARIAVEL}`
- NGINX precisa do MESMO volume do WordPress (servir arquivos estáticos)
- `restart: always` é obrigatório pelo subject!

**Conceitos importantes:**
- Volume = dados sobrevivem à morte do container
- Network bridge = containers conversam entre si
- DNS interno = "mariadb" vira hostname automaticamente
- depends_on = ordem de inicialização (não é healthcheck!)

**Dúvidas que surgiram:**
- ✅ Dados são perdidos quando container morre? NÃO, por causa dos volumes!
- ✅ Containers se comunicam por nome? SIM, Docker tem DNS interno!
- ✅ Posso acessar WordPress direto? NÃO, só NGINX tem porta exposta!
- Como fazer healthcheck para garantir que MariaDB está pronto?
**Próximos passos:**
1. ✅ Adaptar Makefile
2. ✅ Criar estrutura requirements/
3. ✅ Criar docker-compose.yml completo
4. ✅ Script init_db.sh do MariaDB
5. Terminar Dockerfile do MariaDB
6. Criar Dockerfile do NGINX + SSL
7. Criar Dockerfile do WordPress
4. Criar Dockerfile do WordPress

---
### Sessão 3 - [Data: 17/10/2025]
**Tópico:** Docker Compose Avançado + Estrutura do Projeto + Scripts de Inicialização

**O que aprendi hoje:**
- ✅ **Estrutura correta:** Pasta `requirements/` é OBRIGATÓRIA pelo subject!
- ✅ **Estratégia de organização:** Usar pasta `inception/` para submeter (repositório pessoal separado)
- ✅ **docker-compose.yml completo:** Criado com healthchecks, depends_on avançado, volumes bind mount
- ✅ **Healthcheck vs depends_on:** depends_on só garante ordem, healthcheck garante que está PRONTO
- ✅ **condition: service_healthy:** WordPress só sobe quando MariaDB está realmente funcionando
- ✅ **Volume read-only (ro):** NGINX usa `:ro` nos volumes (boa prática de segurança)
- ✅ **env_file:** Carrega TODAS variáveis do .env automaticamente
- ✅ **Loop infinito vs timeout:** `until` é perigoso (infinito), `for i in {1..30}` é seguro (timeout)
- ✅ **Scripts de inicialização:** Criar scripts em `tools/` para configurar serviços

**Conceitos técnicos importantes:**
- **Healthcheck:** Testa se serviço está funcionando (não só iniciado)
  - MariaDB: `mysqladmin ping` testa conexão real
  - WordPress: `nc -z localhost 9000` testa se PHP-FPM está escutando
- **Bind mount:** Mapeia pasta real do host (`/home/strodrig/data/`) para container
- **Read-only volume (ro):** Segurança - NGINX só lê, não escreve
- **Loop com timeout:** Evita travamento infinito se serviço não subir

**Boas práticas aplicadas:**
- ✅ Healthchecks em serviços críticos
- ✅ depends_on com condition (não só ordem, mas estado)
- ✅ Timeouts em loops de espera (max 30-60 segundos)
- ✅ Volumes read-only onde possível
- ✅ Mensagens de erro/sucesso em scripts
- ✅ Exit codes corretos (exit 1 em caso de erro)

**Dúvidas que surgiram:**
- ✅ Estrutura está correta? SIM! requirements/ é obrigatória
- ✅ Loop infinito é perigoso? SIM! Sempre usar timeout
- ✅ Healthcheck é necessário? Não obrigatório, mas MUITO recomendado!
- ✅ docker-compose.yml está bom? Nota 9.5/10! 🎉
- Como fazer certificado SSL autoassinado para NGINX?
- Como configurar PHP-FPM corretamente?

**Arquivos criados hoje:**
- ✅ docker-compose.yml completo (com healthchecks)
- ✅ init_db.sh (script de inicialização MariaDB)
- ✅ Estrutura requirements/ reorganizada

**Próximos passos:**
1. Terminar Dockerfile do MariaDB
2. Criar certificado SSL para NGINX
3. Criar Dockerfile do NGINX
4. Criar Dockerfile do WordPress
5. Adaptar Makefile para Docker

---

### Sessão 4 - [Data: __/__/____]
**Tópico:**

**O que aprendi hoje:**
-*O que aprendi hoje:**
-

**Dúvidas que surgiram:**
-

**Próximos passos:**
1.
## 💡 Conceitos Importantes (Preencher conforme aprendo)

### Docker
**O que é:**
(Ainda vou estudar)

**Para que serve:**
(Ainda vou estudar)

**Comandos importantes:**
```bash
# Listar aqui conforme aprendo
docker-compose up -d      # Sobe containers em background
docker-compose down       # Para e remove containers
docker-compose build      # Constrói as imagens
docker-compose ps         # Lista containers rodando
docker volume ls          # Lista volumes
docker volume rm <name>   # Remove volume
docker system prune -a    # Limpa tudo (cuidado!)
```

---

### Docker Compose
**O que é:**
Ferramenta para definir e rodar múltiplos containers Docker

**Para que serve:**
Orquestrar vários containers ao mesmo tempo usando um arquivo YAML

**Comandos importantes:**
```bash
# Comandos básicos já listados acima
```
**Comandos importantes:**
```bash
# Listar aqui conforme aprendo
```

---

### NGINX
**O que é:**


**Papel no projeto:**


---

### PHP-FPM
**O que é:**


**Por que separado do NGINX:**


---

### MariaDB
**O que é:**


**Diferença para MySQL:**


---

### TLS/SSL
**O que é:**


**Por que usar:**


---

### Volumes Docker
**O que são:**


**Por que usar:**


---

### Docker Networks
**O que é:**
## 🤔 Perguntas Frequentes que Fiz

### Pergunta 1:
**P:** Qual a diferença entre o Makefile do Cub3D e do Inception?
**R:**
- **Cub3D:** Compila código C, linka bibliotecas, cria executável
- **Inception:** Orquestra Docker (build imagens, criar volumes, subir containers)
- **Cub3D:** Trabalha com .c → .o → executável
- **Inception:** Trabalha com Dockerfiles → imagens → containers

---

### Pergunta 2:
**P:** O que o Makefile do Inception deve fazer?
**R:**
```makefile
make all    # Build imagens + criar volumes + subir containers
make down   # Parar containers (sem remover volumes)
make clean  # Parar e remover containers
make fclean # Limpar TUDO (containers, volumes, imagens, networks)
make re     # fclean + all (rebuild completo)
```

---

### Pergunta 3:
**P:** Preciso usar `secrets/` ou posso usar só `.env`?
**R:**
- **Pode usar só `.env`!** O subject recomenda secrets mas não obriga
- Mais simples: um arquivo só ao invés de vários
- `.env` é muito usado na indústria para desenvolvimento
- **IMPORTANTE:** `.env` deve estar no `.gitignore` (credenciais no git = falha!)
- Use `.env.example` commitado como template

---

### Pergunta 4:
**P:** `until` loop infinito vs `for` com timeout - qual usar?
**R:**
```bash
# ❌ RUIM - Loop infinito (perigoso)
until mysqladmin ping --silent; do
  sleep 1
done

# ✅ BOM - Loop com timeout (seguro)
for i in {1..30}; do
  mysqladmin ping --silent && break
  sleep 1
done
```
- `until` = loop infinito (se MariaDB não subir, trava para sempre)
- `for` com limite = timeout definido (30 segundos, depois desiste)
- **Use sempre `for` com timeout!** É mais profissional e evita travamentos

---

### Pergunta 5:
**P:** O que é healthcheck e por que usar?
**R:**
- **Healthcheck:** Testa se serviço está FUNCIONANDO (não só iniciado)
- `depends_on` só garante ordem de inicialização
- `condition: service_healthy` garante que serviço está PRONTO
- Exemplo: MariaDB pode ter iniciado mas ainda não aceitar conexões
- Healthcheck evita erros de "connection refused" no WordPress

---

### Pergunta 6:
**P:** Por que NGINX usa volume `:ro` (read-only)?
**R:**
- Segurança! NGINX só precisa LER arquivos (CSS, JS, imagens)
- Não precisa ESCREVER nada
- Se houver invasão, atacante não consegue modificar arquivos via NGINX
- WordPress escreve nos volumes, NGINX apenas serve os arquivos

---

### Pergunta 7:
**P:**
**R:**

---

## 🔍 Recursos Úteis

### Documentação Oficial
- [ ] [Docker Docs](https://docs.docker.com/)
- [ ] [Docker Compose Docs](https://docs.docker.com/compose/)
- [ ] [NGINX Docs](https://nginx.org/en/docs/)
- [ ] [MariaDB Docs](https://mariadb.com/kb/en/documentation/)
- [ ] [WordPress Docs](https://wordpress.org/support/)

### Tutoriais Recomendados
-

### Vídeos que Assisti
-

---

## 🐛 Problemas Encontrados e Soluções

### Problema 1: Estrutura de pastas incorreta
**Descrição:**
Inicialmente não tinha a pasta `requirements/` que o subject exige. Pastas mariadb/, nginx/ e wordpress/ estavam direto em srcs/.

**Como resolvi:**
Criei pasta `srcs/requirements/` e movi as 3 pastas de serviços para dentro.

**O que aprendi:**
- Sempre ler o subject com atenção (mostra a estrutura exata)
- A estrutura é testada na avaliação!
- Organizar bem desde o início evita retrabalho

## 📊 Progresso Geral

```
[████████░░] 80%  - Entendendo os requisitos ✅
[██████████] 100% - Estrutura de pastas criada ✅
[██████████] 100% - docker-compose.yml completo ✅
[██████░░░░] 70%  - Dockerfile do MariaDB (em andamento)
[████░░░░░░] 40%  - Dockerfile do NGINX
[████░░░░░░] 40%  - Dockerfile do WordPress
[░░░░░░░░░░] 0%   - Volumes configurados (precisa Makefile criar pastas)
[██████████] 100% - Network configurada ✅
[░░░░░░░░░░] 0%   - TLS/SSL funcionando
[░░░░░░░░░░] 0%   - Testes e ajustes finais
```

**PROGRESSO GERAL: ~50%** 🎯

**O que está pronto:**
- ✅ Estrutura de pastas 100% correta
- ✅ .env.example e .env configurados
- ✅ .gitignore correto
- ✅ docker-compose.yml excelente (nota 9.5/10)
- ✅ Script init_db.sh do MariaDB
- ✅ Conceitos de Docker bem compreendidos

**O que falta:**
- ⏳ Terminar Dockerfiles (3 faltam)
- ⏳ Configurações em conf/ (NGINX SSL, PHP-FPM, MySQL)
- ⏳ Makefile adaptado para Docker
- ⏳ Testar tudo funcionando junto
---

### Problema 3:
**Descrição:**


**Como resolvi (ou tentei):**


**O que aprendi:**


---

## 📊 Progresso Geral

```
[    ] 0%  - Entendendo os requisitos
[    ] 10% - Estrutura de pastas criada
[    ] 20% - Dockerfile do NGINX
[    ] 30% - Dockerfile do MariaDB
[    ] 40% - Dockerfile do WordPress
[    ] 50% - docker-compose.yml básico
[    ] 60% - Volumes configurados
[    ] 70% - Network configurada
[    ] 80% - TLS/SSL funcionando
[    ] 90% - Testes e ajustes finais
[    ] 100% - Projeto obrigatório completo!
```

---

## 🎯 Como Usar Este Guia

1. **Antes de começar cada sessão:** Revise o que aprendeu na última vez
2. **Durante o trabalho:** Anote dúvidas, conceitos novos, comandos úteis
3. **Quando perguntar para o Copilot:** Contextualize mostrando este arquivo
4. **Ao resolver um problema:** Documente a solução aqui
5. **Ao aprender algo novo:** Adicione na seção de conceitos

---

## 💪 Lembretes Importantes

1. **Sempre entenda o código antes de usar** - Nunca copie e cole sem entender
2. **Peça revisão aos colegas** - IA pode errar, seus peers te ajudam
3. **Documente seu raciocínio** - Vai te ajudar na defesa do projeto
4. **Faça testes incrementais** - Não deixe para testar tudo no final
5. **Use IA para aprender, não para fazer por você** - O aprendizado é seu objetivo

---

## 📞 Quando Voltar a Conversar com o Copilot

Para continuarmos de onde paramos, me mostre:
1. Este arquivo atualizado
2. Qual parte específica você está trabalhando
3. O que você já tentou fazer
4. Suas dúvidas específicas

Assim posso te ajudar melhor sem repetir explicações! 🚀

---

**Última atualização:** 17/10/2025
