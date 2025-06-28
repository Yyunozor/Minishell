# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: anpayot <anpayot@student.42lausanne.ch>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/24 13:42:56 by anpayot           #+#    #+#              #
#    Updated: 2025/06/28 19:14:03 by anpayot          ###   ########.fr        #
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
INC_DIR = includes
OBJ_DIR = objs
TEST_DIR = tests

# OS Detection
UNAME_S := $(shell uname -s)
UNAME_M := $(shell uname -m)

# Readline configuration (OS-specific)
ifeq ($(UNAME_S),Darwin)
	# macOS (Homebrew)
	READLINE_INC = /usr/local/opt/readline/include
	READLINE_LIB = /usr/local/opt/readline/lib
	# Check for Apple Silicon
	ifeq ($(UNAME_M),arm64)
		READLINE_INC = /opt/homebrew/opt/readline/include
		READLINE_LIB = /opt/homebrew/opt/readline/lib
	endif
	LDFLAGS = -L$(READLINE_LIB) -lreadline
	PKG_MANAGER = brew
else ifeq ($(UNAME_S),Linux)
	# Linux (Ubuntu/Debian and Arch)
	READLINE_INC = /usr/include/readline
	READLINE_LIB = /usr/lib
	LDFLAGS = -lreadline -lhistory
	# Detect package manager
	ifeq ($(shell which apt-get 2>/dev/null),)
		ifeq ($(shell which pacman 2>/dev/null),)
			PKG_MANAGER = unknown
		else
			PKG_MANAGER = pacman
		endif
	else
		PKG_MANAGER = apt
	endif
else
	# Fallback for other Unix systems
	READLINE_INC = /usr/include
	READLINE_LIB = /usr/lib
	LDFLAGS = -lreadline
	PKG_MANAGER = unknown
endif

# Source files
MAIN_SRC = main.c

# All source files
SRCS = $(MAIN_SRC)

# Object files
OBJS = $(SRCS:%.c=$(OBJ_DIR)/%.o)

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

# Memory leak check (cross-platform)
leaks: $(NAME)
	@echo "$(BLUE)Checking for memory leaks...$(RESET)"
ifeq ($(UNAME_S),Darwin)
	@echo "$(YELLOW)Using leaks (macOS)...$(RESET)"
	@leaks -atExit -- ./$(NAME) || echo "$(YELLOW)Run manually: leaks -atExit -- ./$(NAME)$(RESET)"
else
	@echo "$(YELLOW)Using valgrind (Linux)...$(RESET)"
	@valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes \
		--suppressions=readline.supp ./$(NAME) 2>/dev/null || \
		valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(NAME)
endif

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

# Install dependencies (cross-platform)
install:
	@echo "$(BLUE)Installing dependencies for $(UNAME_S)...$(RESET)"
ifeq ($(PKG_MANAGER),brew)
	@echo "$(YELLOW)Using Homebrew (macOS)...$(RESET)"
	@brew install readline || echo "$(RED)Failed to install readline$(RESET)"
else ifeq ($(PKG_MANAGER),apt)
	@echo "$(YELLOW)Using APT (Ubuntu/Debian)...$(RESET)"
	@sudo apt-get update
	@sudo apt-get install -y libreadline-dev build-essential valgrind || echo "$(RED)Failed to install packages$(RESET)"
else ifeq ($(PKG_MANAGER),pacman)
	@echo "$(YELLOW)Using Pacman (Arch Linux)...$(RESET)"
	@sudo pacman -S --noconfirm readline base-devel valgrind || echo "$(RED)Failed to install packages$(RESET)"
else
	@echo "$(RED)Unknown package manager. Please install readline manually.$(RESET)"
	@echo "$(CYAN)Required packages:$(RESET)"
	@echo "  - readline development libraries"
	@echo "  - C compiler (gcc/clang)"
	@echo "  - make"
	@echo "  - valgrind (optional)"
endif
	@echo "$(GREEN)✓ Dependencies installation completed!$(RESET)"

# Setup development environment
setup: install
	@echo "$(BLUE)Setting up development environment...$(RESET)"
	@mkdir -p $(OBJ_DIR) $(TEST_DIR)
	@echo "$(GREEN)✓ Development environment ready!$(RESET)"

# Cross-platform setup (comprehensive)
setup-full:
	@echo "$(BLUE)Running comprehensive cross-platform setup...$(RESET)"
	@./scripts/cross_platform_setup.sh

# Run the shell
run: $(NAME)
	@echo "$(CYAN)Starting $(NAME)...$(RESET)"
	@./$(NAME)

# Generate documentation
docs:
	@echo "$(BLUE)Generating documentation...$(RESET)"
	@doxygen Doxyfile 2>/dev/null || echo "$(YELLOW)Doxygen not found, skipping...$(RESET)"

# Open documentation in browser
docs-open:
	@./scripts/docs.sh open

# Serve documentation with HTTP server
docs-serve:
	@./scripts/docs.sh serve

# Clean documentation
docs-clean:
	@echo "$(BLUE)Cleaning documentation...$(RESET)"
	@rm -rf docs/html docs/latex

# Show help
help:
	@echo "$(CYAN)Minishell Makefile Help$(RESET)"
	@echo "$(WHITE)Available targets:$(RESET)"
	@echo ""
	@echo "$(YELLOW)Build Targets:$(RESET)"
	@echo "  $(GREEN)all$(RESET)      - Build the main executable"
	@echo "  $(GREEN)bonus$(RESET)    - Build with bonus features"
	@echo "  $(GREEN)debug$(RESET)    - Build with debug flags"
	@echo "  $(GREEN)sanitize$(RESET) - Build with address sanitizer"
	@echo "  $(GREEN)clean$(RESET)    - Remove object files"
	@echo "  $(GREEN)fclean$(RESET)   - Remove all generated files"
	@echo "  $(GREEN)re$(RESET)       - Rebuild everything"
	@echo ""
	@echo "$(YELLOW)Testing & Quality:$(RESET)"
	@echo "  $(GREEN)test$(RESET)     - Compile and run tests"
	@echo "  $(GREEN)norm$(RESET)     - Check 42 norm compliance"
	@echo "  $(GREEN)leaks$(RESET)    - Check for memory leaks (cross-platform)"
	@echo ""
	@echo "$(YELLOW)Environment & Setup:$(RESET)"
	@echo "  $(GREEN)install$(RESET)  - Install dependencies (cross-platform)"
	@echo "  $(GREEN)setup$(RESET)    - Setup development environment"
	@echo "  $(GREEN)setup-full$(RESET) - Comprehensive cross-platform setup"
	@echo "  $(GREEN)system-info$(RESET) - Show system information"
	@echo "  $(GREEN)test-env$(RESET) - Test compilation environment"
	@echo ""
	@echo "$(YELLOW)Documentation:$(RESET)"
	@echo "  $(GREEN)docs$(RESET)     - Generate documentation"
	@echo "  $(GREEN)docs-open$(RESET) - Open documentation in browser"
	@echo "  $(GREEN)docs-serve$(RESET) - Serve documentation with HTTP server"
	@echo "  $(GREEN)docs-clean$(RESET) - Clean documentation"
	@echo ""
	@echo "$(YELLOW)Development:$(RESET)"
	@echo "  $(GREEN)run$(RESET)      - Build and run the shell"
	@echo "  $(GREEN)stats$(RESET)    - Show project statistics"
	@echo "  $(GREEN)rebuild-lexer$(RESET)   - Force rebuild lexer module"
	@echo "  $(GREEN)rebuild-parser$(RESET)  - Force rebuild parser module"
	@echo "  $(GREEN)rebuild-executor$(RESET) - Force rebuild executor module"
	@echo "  $(GREEN)help$(RESET)     - Show this help message"
	@echo ""
	@echo "$(CYAN)Supported Systems: macOS, Ubuntu/Debian, Arch Linux$(RESET)"

# Show system information
system-info:
	@echo "$(CYAN)System Information$(RESET)"
	@echo "$(WHITE)OS: $(GREEN)$(UNAME_S)$(RESET)"
	@echo "$(WHITE)Architecture: $(GREEN)$(UNAME_M)$(RESET)"
	@echo "$(WHITE)Package Manager: $(GREEN)$(PKG_MANAGER)$(RESET)"
	@echo "$(WHITE)Readline Include: $(GREEN)$(READLINE_INC)$(RESET)"
	@echo "$(WHITE)Readline Library: $(GREEN)$(READLINE_LIB)$(RESET)"
	@echo "$(WHITE)Compiler: $(GREEN)$(CC)$(RESET)"
	@echo "$(WHITE)Flags: $(GREEN)$(CFLAGS)$(RESET)"
	@echo "$(WHITE)LDFLAGS: $(GREEN)$(LDFLAGS)$(RESET)"

# Test compilation environment
test-env:
	@echo "$(BLUE)Testing compilation environment...$(RESET)"
	@echo "$(YELLOW)Checking compiler...$(RESET)"
	@$(CC) --version > /dev/null 2>&1 && echo "$(GREEN)✓ $(CC) found$(RESET)" || echo "$(RED)✗ $(CC) not found$(RESET)"
	@echo "$(YELLOW)Checking readline headers...$(RESET)"
	@test -f $(READLINE_INC)/readline/readline.h && echo "$(GREEN)✓ readline.h found$(RESET)" || echo "$(RED)✗ readline.h not found at $(READLINE_INC)/readline/$(RESET)"
	@echo "$(YELLOW)Checking make...$(RESET)"
	@make --version > /dev/null 2>&1 && echo "$(GREEN)✓ make found$(RESET)" || echo "$(RED)✗ make not found$(RESET)"
ifeq ($(UNAME_S),Linux)
	@echo "$(YELLOW)Checking valgrind...$(RESET)"
	@valgrind --version > /dev/null 2>&1 && echo "$(GREEN)✓ valgrind found$(RESET)" || echo "$(YELLOW)⚠ valgrind not found (optional)$(RESET)"
endif
	@echo "$(GREEN)✓ Environment test completed!$(RESET)"

# Print project statistics
stats:
	@echo "$(CYAN)Project Statistics$(RESET)"
	@echo "$(WHITE)Source files: $(GREEN)$(words $(SRCS))$(RESET)"
	@echo "$(WHITE)Lines of code: $(GREEN)$(shell find $(SRC_DIR) -name '*.c' | xargs wc -l | tail -1 | awk '{print $$1}')$(RESET)"
	@echo "$(WHITE)Header files: $(GREEN)$(shell find $(INC_DIR) -name '*.h' | wc -l)$(RESET)"
	@echo "$(WHITE)Test files: $(GREEN)$(words $(TEST_SRCS))$(RESET)"
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
.PHONY: all bonus debug sanitize test norm leaks clean fclean re install setup setup-full run docs docs-open docs-serve docs-clean help stats system-info test-env rebuild-lexer rebuild-parser rebuild-executor

# Silent mode
.SILENT: