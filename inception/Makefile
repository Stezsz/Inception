# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: strodrig <strodrig@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/17 11:34:51 by strodrig          #+#    #+#              #
#    Updated: 2025/10/20 00:00:00 by strodrig         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Project name
NAME		= inception

# Docker Compose file
COMPOSE		= srcs/docker-compose.yml

# Data directories
DATA_DIR	= /home/strodrig/data
MARIADB_DIR	= $(DATA_DIR)/mariadb
WP_DIR		= $(DATA_DIR)/wordpress

# Colors
GREEN		= \033[92;5;118m
YELLOW		= \033[93;5;226m
RED			= \033[91m
GRAY		= \033[33;2;37m
RESET		= \033[0m
CURSIVE		= \033[33;3m

# Default target
all: setup up

# Create data directories
setup:
	@printf "$(CURSIVE)$(GRAY)Creating data directories...$(RESET)\n"
	@mkdir -p $(MARIADB_DIR)
	@mkdir -p $(WP_DIR)
	@printf "$(GREEN)✓ Data directories created$(RESET)\n"

# Build and start containers
up: setup
	@printf "$(CURSIVE)$(GRAY)Building and starting containers...$(RESET)\n"
	@docker-compose -f $(COMPOSE) up -d --build
	@printf "$(GREEN)✓ Containers are running$(RESET)\n"

# Start containers (without building)
start:
	@printf "$(CURSIVE)$(GRAY)Starting containers...$(RESET)\n"
	@docker-compose -f $(COMPOSE) start
	@printf "$(GREEN)✓ Containers started$(RESET)\n"

# Stop containers
stop:
	@printf "$(CURSIVE)$(GRAY)Stopping containers...$(RESET)\n"
	@docker-compose -f $(COMPOSE) stop
	@printf "$(YELLOW)✓ Containers stopped$(RESET)\n"

# Restart containers
restart: stop start
	@printf "$(GREEN)✓ Containers restarted$(RESET)\n"

# Stop and remove containers
down:
	@printf "$(CURSIVE)$(GRAY)Stopping and removing containers...$(RESET)\n"
	@docker-compose -f $(COMPOSE) down
	@printf "$(YELLOW)✓ Containers removed$(RESET)\n"

# Show container status
status:
	@docker-compose -f $(COMPOSE) ps

# Show logs
logs:
	@docker-compose -f $(COMPOSE) logs -f

# Clean everything (containers, volumes, images)
clean: down
	@printf "$(CURSIVE)$(GRAY)Removing volumes and images...$(RESET)\n"
	@docker-compose -f $(COMPOSE) down -v --rmi all
	@printf "$(YELLOW)✓ Docker cleanup complete$(RESET)\n"

# Full clean (including data directories)
fclean: clean
	@printf "$(CURSIVE)$(GRAY)Removing data directories...$(RESET)\n"
	@sudo rm -rf $(DATA_DIR)
	@printf "$(RED)✓ Full cleanup complete$(RESET)\n"

# Rebuild everything from scratch
re: fclean all
	@printf "$(GREEN)✓ Project rebuilt successfully$(RESET)\n"

# Show help
help:
	@echo "$(GREEN)Inception Makefile Commands:$(RESET)"
	@echo "  $(YELLOW)make$(RESET) or $(YELLOW)make all$(RESET)     - Setup and start all containers"
	@echo "  $(YELLOW)make up$(RESET)              - Build and start containers"
	@echo "  $(YELLOW)make start$(RESET)           - Start stopped containers"
	@echo "  $(YELLOW)make stop$(RESET)            - Stop running containers"
	@echo "  $(YELLOW)make restart$(RESET)         - Restart containers"
	@echo "  $(YELLOW)make down$(RESET)            - Stop and remove containers"
	@echo "  $(YELLOW)make status$(RESET)          - Show container status"
	@echo "  $(YELLOW)make logs$(RESET)            - Show and follow container logs"
	@echo "  $(YELLOW)make clean$(RESET)           - Remove containers, volumes and images"
	@echo "  $(YELLOW)make fclean$(RESET)          - Full cleanup including data directories"
	@echo "  $(YELLOW)make re$(RESET)              - Rebuild everything from scratch"

.PHONY: all setup up start stop restart down status logs clean fclean re help
