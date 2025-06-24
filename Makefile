# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: anpayot <anpayot@student.42lausanne.ch>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/24 13:42:56 by anpayot           #+#    #+#              #
#    Updated: 2025/06/24 13:51:35 by anpayot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Program name
NAME = minishell

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -Werror -std=c99
DFLAGS = -g3 -fsanitize=address
INCLUDES = -I$(INC_DIR) -I$(READLINE_INC)

# Directories
SRC_DIR = srcs
INC_DIR = Includes
OBJ_DIR = objs
TEST_DIR = tests

# Readline configuration
READLINE_INC = /usr/local/opt/readline/include
READLINE_LIB = /usr/local/opt/readline/lib
LDFLAGS = -L$(READLINE_LIB) -lreadline

# Source files
MAIN_SRC = main.c

INIT_SRC = init/init_shell.c \
           init/init_env.c

LEXER_SRC = lexer/tokenizer.c \
            lexer/token_utils.c \
            lexer/token_validation.c

PARSER_SRC = parser/parser.c \
             parser/syntax_check.c \
             parser/ast_builder.c \
             parser/command_parser.c

EXPANDER_SRC = expander/variable_expansion.c \
               expander/quote_removal.c \
               expander/wildcard_expansion.c

EXECUTOR_SRC = executor/executor.c \
               executor/pipe_handler.c \
               executor/process_manager.c \
               executor/command_executor.c

BUILTINS_SRC = builtins/builtin_echo.c \
               builtins/builtin_cd.c \
               builtins/builtin_pwd.c \
               builtins/builtin_export.c \
               builtins/builtin_unset.c \
               builtins/builtin_env.c \
               builtins/builtin_exit.c \
               builtins/builtin_utils.c

REDIRECTIONS_SRC = redirections/input_redirect.c \
                   redirections/output_redirect.c \
                   redirections/here_document.c

SIGNALS_SRC = signals/signal_handler.c \
              signals/signal_utils.c

UTILS_SRC = utils/memory_utils.c \
            utils/string_utils.c \
            utils/error_handler.c \
            utils/env_utils.c \
            utils/path_utils.c

BONUS_SRC = bonus/wildcards.c \
            bonus/heredoc.c \
            bonus/logical_operators.c

# All source files
SRCS = $(MAIN_SRC) $(INIT_SRC) $(LEXER_SRC) $(PARSER_SRC) $(EXPANDER_SRC) \
       $(EXECUTOR_SRC) $(BUILTINS_SRC) $(REDIRECTIONS_SRC) $(SIGNALS_SRC) \
       $(UTILS_SRC)

# Bonus source files
BONUS_SRCS = $(SRCS) $(BONUS_SRC)

# Object files
OBJS = $(SRCS:%.c=$(OBJ_DIR)/%.o)
BONUS_OBJS = $(BONUS_SRCS:%.c=$(OBJ_DIR)/%.o)

# Test files
TEST_SRCS = $(wildcard $(TEST_DIR)/*.c)
TEST_OBJS = $(TEST_SRCS:%.c=$(OBJ_DIR)/%.o)
TEST_NAME = test_runner

# Colors for output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
MAGENTA = \033[0;35m
CYAN = \033[0;36m
WHITE = \033[0;37m
RESET = \033[0m

# Progress tracking
TOTAL_SRCS = $(words $(SRCS))
COMPILED = 0

# Default target
all: $(NAME)

# Main executable
$(NAME): $(OBJS)
	@echo "$(CYAN)Linking $(NAME)...$(RESET)"
	@$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $(NAME)
	@echo "$(GREEN)✓ $(NAME) compiled successfully!$(RESET)"

# Bonus target
bonus: $(BONUS_OBJS)
	@echo "$(CYAN)Linking $(NAME) with bonus features...$(RESET)"
	@$(CC) $(CFLAGS) $(BONUS_OBJS) $(LDFLAGS) -o $(NAME)
	@echo "$(GREEN)✓ $(NAME) with bonus compiled successfully!$(RESET)"

# Object file compilation
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	@$(eval COMPILED=$(shell echo $$(($(COMPILED)+1))))
	@echo "$(YELLOW)[$(COMPILED)/$(TOTAL_SRCS)] Compiling $<...$(RESET)"
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

# Debug build
debug: CFLAGS += $(DFLAGS)
debug: clean $(NAME)
	@echo "$(MAGENTA)✓ Debug build completed!$(RESET)"

# Sanitize build
sanitize: CFLAGS += -fsanitize=address -g3
sanitize: clean $(NAME)
	@echo "$(MAGENTA)✓ Sanitized build completed!$(RESET)"

# Test compilation
test: $(TEST_OBJS) $(filter-out $(OBJ_DIR)/main.o, $(OBJS))
	@echo "$(CYAN)Compiling tests...$(RESET)"
	@$(CC) $(CFLAGS) $(INCLUDES) $^ $(LDFLAGS) -o $(TEST_NAME)
	@echo "$(GREEN)✓ Tests compiled successfully!$(RESET)"
	@echo "$(BLUE)Running tests...$(RESET)"
	@./$(TEST_NAME)

# Norm check
norm:
	@echo "$(BLUE)Checking norm compliance...$(RESET)"
	@norminette $(SRC_DIR) $(INC_DIR) | grep -E "(Error|Warning)" && \
		echo "$(RED)✗ Norm errors found!$(RESET)" || \
		echo "$(GREEN)✓ Norm check passed!$(RESET)"

# Memory leak check
leaks: $(NAME)
	@echo "$(BLUE)Checking for memory leaks...$(RESET)"
	@valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes \
		--suppressions=readline.supp ./$(NAME)

# Clean object files
clean:
	@echo "$(RED)Cleaning object files...$(RESET)"
	@rm -rf $(OBJ_DIR)
	@echo "$(GREEN)✓ Object files cleaned!$(RESET)"

# Clean everything
fclean: clean
	@echo "$(RED)Cleaning executable...$(RESET)"
	@rm -f $(NAME) $(TEST_NAME)
	@echo "$(GREEN)✓ Everything cleaned!$(RESET)"

# Rebuild
re: fclean all

# Install dependencies (macOS)
install:
	@echo "$(BLUE)Installing dependencies...$(RESET)"
	@brew install readline
	@echo "$(GREEN)✓ Dependencies installed!$(RESET)"

# Setup development environment
setup: install
	@echo "$(BLUE)Setting up development environment...$(RESET)"
	@mkdir -p $(OBJ_DIR) $(TEST_DIR)
	@echo "$(GREEN)✓ Development environment ready!$(RESET)"

# Run the shell
run: $(NAME)
	@echo "$(CYAN)Starting $(NAME)...$(RESET)"
	@./$(NAME)

# Generate documentation
docs:
	@echo "$(BLUE)Generating documentation...$(RESET)"
	@doxygen Doxyfile 2>/dev/null || echo "$(YELLOW)Doxygen not found, skipping...$(RESET)"

# Show help
help:
	@echo "$(CYAN)Minishell Makefile Help$(RESET)"
	@echo "$(WHITE)Available targets:$(RESET)"
	@echo "  $(GREEN)all$(RESET)      - Build the main executable"
	@echo "  $(GREEN)bonus$(RESET)    - Build with bonus features"
	@echo "  $(GREEN)debug$(RESET)    - Build with debug flags"
	@echo "  $(GREEN)sanitize$(RESET) - Build with address sanitizer"
	@echo "  $(GREEN)test$(RESET)     - Compile and run tests"
	@echo "  $(GREEN)norm$(RESET)     - Check 42 norm compliance"
	@echo "  $(GREEN)leaks$(RESET)    - Check for memory leaks"
	@echo "  $(GREEN)clean$(RESET)    - Remove object files"
	@echo "  $(GREEN)fclean$(RESET)   - Remove all generated files"
	@echo "  $(GREEN)re$(RESET)       - Rebuild everything"
	@echo "  $(GREEN)install$(RESET)  - Install dependencies"
	@echo "  $(GREEN)setup$(RESET)    - Setup development environment"
	@echo "  $(GREEN)run$(RESET)      - Build and run the shell"
	@echo "  $(GREEN)docs$(RESET)     - Generate documentation"
	@echo "  $(GREEN)help$(RESET)     - Show this help message"

# Print project statistics
stats:
	@echo "$(CYAN)Project Statistics$(RESET)"
	@echo "$(WHITE)Source files: $(GREEN)$(words $(SRCS))$(RESET)"
	@echo "$(WHITE)Lines of code: $(GREEN)$(shell find $(SRC_DIR) -name '*.c' | xargs wc -l | tail -1 | awk '{print $$1}')$(RESET)"
	@echo "$(WHITE)Header files: $(GREEN)$(shell find $(INC_DIR) -name '*.h' | wc -l)$(RESET)"
	@echo "$(WHITE)Test files: $(GREEN)$(words $(TEST_SRCS))$(RESET)"

# Force rebuild of specific modules
rebuild-lexer:
	@rm -f $(OBJ_DIR)/lexer/*.o
	@make $(NAME)

rebuild-parser:
	@rm -f $(OBJ_DIR)/parser/*.o
	@make $(NAME)

rebuild-executor:
	@rm -f $(OBJ_DIR)/executor/*.o
	@make $(NAME)

# Phony targets
.PHONY: all bonus debug sanitize test norm leaks clean fclean re install setup run docs help stats rebuild-lexer rebuild-parser rebuild-executor

# Silent mode
.SILENT: