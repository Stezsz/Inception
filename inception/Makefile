# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: strodrig <strodrig@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/17 11:34:51 by strodrig          #+#    #+#              #
#    Updated: 2025/10/17 11:34:51 by strodrig         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = cub3d

CC = cc
CFLAGS = -Wall -Wextra -Werror
RM = rm -f

FILES =

SRC = $(addprefix $(SRC_DIR)/, $(FILES:=.c))
OBJ = $(addprefix $(OBJDIR)/, $(subst /,_,$(FILES:=.o)))

#Colors:
GREEN		=	\033[92;5;118m
YELLOW		=	\033[93;5;226m
GRAY		=	\033[33;2;37m
RESET		=	\033[0m
CURSIVE		=	\033[33;3m


all: $(NAME)

clean:
	@$(RM) $(OBJ)
	@printf "$(CURSIVE)$(GRAY)	- Removing object files ... $(RESET)\n"
	@printf "$(YELLOW)    - Object files removed.$(RESET)\n"
	@$(MAKE) -C $(LIBFT_DIR) clean
	@$(MAKE) -C $(MLX_DIR) clean
	@rm -rf $(OBJDIR)

fclean: clean
	@ $(RM) $(NAME)
	@printf "$(CURSIVE)$(GRAY)	- Removing $(NAME)... $(RESET)\n"
	@printf "$(YELLOW)    - Executable removed.$(RESET)\n"
	@$(MAKE) -C $(LIBFT_DIR) fclean

re: fclean all
	@printf "$(CURSIVE)$(GRAY)	- Rebuilding project... $(RESET)\n"
	@printf "$(GREEN)    - Project rebuilt successfully.$(RESET)\n"

.PHONY: all clean fclean re
