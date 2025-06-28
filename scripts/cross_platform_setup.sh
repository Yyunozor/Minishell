#!/bin/bash

# Cross-platform setup script for Minishell
# Supports macOS, Ubuntu/Debian, and Arch Linux

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Detect OS
OS=$(uname -s)
ARCH=$(uname -m)

echo -e "${CYAN}🚀 Minishell Cross-Platform Setup${NC}"
echo -e "${BLUE}Detected OS: ${GREEN}$OS${NC}"
echo -e "${BLUE}Architecture: ${GREEN}$ARCH${NC}"
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install packages on macOS
install_macos() {
    echo -e "${YELLOW}Setting up for macOS...${NC}"
    
    # Check if Homebrew is installed
    if ! command_exists brew; then
        echo -e "${YELLOW}Installing Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo -e "${GREEN}✓ Homebrew already installed${NC}"
    fi
    
    # Install readline
    echo -e "${YELLOW}Installing readline...${NC}"
    brew install readline || echo -e "${RED}Failed to install readline${NC}"
    
    # Install additional tools
    echo -e "${YELLOW}Installing development tools...${NC}"
    brew install make || echo -e "${YELLOW}make already installed${NC}"
    
    echo -e "${GREEN}✓ macOS setup completed!${NC}"
}

# Function to install packages on Ubuntu/Debian
install_ubuntu() {
    echo -e "${YELLOW}Setting up for Ubuntu/Debian...${NC}"
    
    # Update package list
    echo -e "${YELLOW}Updating package list...${NC}"
    sudo apt-get update
    
    # Install required packages
    echo -e "${YELLOW}Installing required packages...${NC}"
    sudo apt-get install -y \
        build-essential \
        libreadline-dev \
        valgrind \
        make \
        gcc \
        git \
        curl || echo -e "${RED}Some packages failed to install${NC}"
    
    echo -e "${GREEN}✓ Ubuntu/Debian setup completed!${NC}"
}

# Function to install packages on Arch Linux
install_arch() {
    echo -e "${YELLOW}Setting up for Arch Linux...${NC}"
    
    # Update package database
    echo -e "${YELLOW}Updating package database...${NC}"
    sudo pacman -Sy
    
    # Install required packages
    echo -e "${YELLOW}Installing required packages...${NC}"
    sudo pacman -S --noconfirm \
        base-devel \
        readline \
        valgrind \
        make \
        gcc \
        git \
        curl || echo -e "${RED}Some packages failed to install${NC}"
    
    echo -e "${GREEN}✓ Arch Linux setup completed!${NC}"
}

# Function to setup development environment
setup_dev_env() {
    echo -e "${YELLOW}Setting up development environment...${NC}"
    
    # Create necessary directories
    mkdir -p objs tests
    
    # Set up git hooks (if .git exists)
    if [ -d ".git" ]; then
        echo -e "${YELLOW}Setting up git hooks...${NC}"
        # Create pre-commit hook for norm checking
        cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
# Pre-commit hook for 42 norm checking
if command -v norminette >/dev/null 2>&1; then
    echo "Checking 42 norm compliance..."
    norminette srcs/ includes/ | grep -E "(Error|Warning)"
    if [ $? -eq 0 ]; then
        echo "❌ Norm errors found! Commit aborted."
        exit 1
    else
        echo "✅ Norm check passed!"
    fi
fi
EOF
        chmod +x .git/hooks/pre-commit
        echo -e "${GREEN}✓ Git hooks configured${NC}"
    fi
    
    echo -e "${GREEN}✓ Development environment setup completed!${NC}"
}

# Function to test the setup
test_setup() {
    echo -e "${YELLOW}Testing setup...${NC}"
    
    # Test compiler
    if command_exists gcc; then
        echo -e "${GREEN}✓ GCC found: $(gcc --version | head -n1)${NC}"
    else
        echo -e "${RED}✗ GCC not found${NC}"
    fi
    
    # Test make
    if command_exists make; then
        echo -e "${GREEN}✓ Make found: $(make --version | head -n1)${NC}"
    else
        echo -e "${RED}✗ Make not found${NC}"
    fi
    
    # Test readline (OS-specific)
    case "$OS" in
        "Darwin")
            if [ "$ARCH" = "arm64" ]; then
                READLINE_PATH="/opt/homebrew/opt/readline/include/readline/readline.h"
            else
                READLINE_PATH="/usr/local/opt/readline/include/readline/readline.h"
            fi
            ;;
        "Linux")
            READLINE_PATH="/usr/include/readline/readline.h"
            ;;
    esac
    
    if [ -f "$READLINE_PATH" ]; then
        echo -e "${GREEN}✓ Readline found at: $READLINE_PATH${NC}"
    else
        echo -e "${RED}✗ Readline not found at: $READLINE_PATH${NC}"
    fi
    
    # Test valgrind (Linux only)
    if [ "$OS" = "Linux" ]; then
        if command_exists valgrind; then
            echo -e "${GREEN}✓ Valgrind found: $(valgrind --version)${NC}"
        else
            echo -e "${YELLOW}⚠ Valgrind not found (optional)${NC}"
        fi
    fi
    
    echo -e "${GREEN}✓ Setup test completed!${NC}"
}

# Main installation logic
case "$OS" in
    "Darwin")
        install_macos
        ;;
    "Linux")
        # Detect Linux distribution
        if command_exists apt-get; then
            install_ubuntu
        elif command_exists pacman; then
            install_arch
        else
            echo -e "${RED}Unsupported Linux distribution${NC}"
            echo -e "${YELLOW}Please install the following packages manually:${NC}"
            echo -e "  - build-essential/base-devel"
            echo -e "  - libreadline-dev/readline"
            echo -e "  - valgrind"
            echo -e "  - make"
            echo -e "  - gcc"
            exit 1
        fi
        ;;
    *)
        echo -e "${RED}Unsupported operating system: $OS${NC}"
        exit 1
        ;;
esac

# Setup development environment
setup_dev_env

# Test the setup
test_setup

echo ""
echo -e "${CYAN}🎉 Setup completed successfully!${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo -e "  1. Run '${GREEN}make${NC}' to build the project"
echo -e "  2. Run '${GREEN}make test-env${NC}' to verify your environment"
echo -e "  3. Run '${GREEN}make help${NC}' to see all available commands"
echo -e "  4. Run '${GREEN}./minishell${NC}' to start your shell"
echo ""
echo -e "${BLUE}Happy coding! 🚀${NC}"
