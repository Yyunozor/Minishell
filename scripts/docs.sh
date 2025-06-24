#!/bin/bash

# Documentation generation and viewer script for Minishell
# Usage: ./scripts/docs.sh [command]
# Commands: generate, open, clean, serve

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project paths
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCS_DIR="${PROJECT_ROOT}/docs"
HTML_DIR="${DOCS_DIR}/html"

# Functions
print_usage() {
    echo "Usage: $0 [command]"
    echo "Commands:"
    echo "  generate  - Generate documentation"
    echo "  open      - Open documentation in browser"
    echo "  clean     - Clean generated documentation"
    echo "  serve     - Start local HTTP server for documentation"
    echo "  help      - Show this help"
}

generate_docs() {
    echo -e "${BLUE}Generating documentation...${NC}"
    
    cd "${PROJECT_ROOT}"
    
    # Check if Doxygen is installed
    if ! command -v doxygen &> /dev/null; then
        echo -e "${RED}Error: Doxygen is not installed${NC}"
        echo "Install it with: brew install doxygen"
        exit 1
    fi
    
    # Generate documentation
    doxygen Doxyfile
    
    if [ -f "${HTML_DIR}/index.html" ]; then
        echo -e "${GREEN}✓ Documentation generated successfully!${NC}"
        echo -e "${YELLOW}Location: ${HTML_DIR}/index.html${NC}"
    else
        echo -e "${RED}✗ Documentation generation failed${NC}"
        exit 1
    fi
}

open_docs() {
    if [ ! -f "${HTML_DIR}/index.html" ]; then
        echo -e "${YELLOW}Documentation not found. Generating...${NC}"
        generate_docs
    fi
    
    echo -e "${BLUE}Opening documentation in browser...${NC}"
    
    # Detect OS and open browser accordingly
    case "$(uname -s)" in
        Darwin*)    open "${HTML_DIR}/index.html" ;;
        Linux*)     xdg-open "${HTML_DIR}/index.html" ;;
        CYGWIN*)    cygstart "${HTML_DIR}/index.html" ;;
        MINGW*)     start "${HTML_DIR}/index.html" ;;
        *)          echo -e "${YELLOW}Please open ${HTML_DIR}/index.html manually${NC}" ;;
    esac
}

clean_docs() {
    echo -e "${BLUE}Cleaning documentation...${NC}"
    
    if [ -d "${HTML_DIR}" ]; then
        rm -rf "${HTML_DIR}"
        echo -e "${GREEN}✓ HTML documentation cleaned${NC}"
    fi
    
    if [ -d "${DOCS_DIR}/latex" ]; then
        rm -rf "${DOCS_DIR}/latex"
        echo -e "${GREEN}✓ LaTeX documentation cleaned${NC}"
    fi
    
    echo -e "${GREEN}✓ Documentation cleanup complete${NC}"
}

serve_docs() {
    if [ ! -f "${HTML_DIR}/index.html" ]; then
        echo -e "${YELLOW}Documentation not found. Generating...${NC}"
        generate_docs
    fi
    
    echo -e "${BLUE}Starting HTTP server for documentation...${NC}"
    echo -e "${YELLOW}Server will be available at: http://localhost:8080${NC}"
    echo -e "${YELLOW}Press Ctrl+C to stop the server${NC}"
    
    cd "${HTML_DIR}"
    
    # Try different HTTP servers based on availability
    if command -v python3 &> /dev/null; then
        python3 -m http.server 8080
    elif command -v python &> /dev/null; then
        python -m SimpleHTTPServer 8080
    elif command -v ruby &> /dev/null; then
        ruby -run -e httpd . -p 8080
    elif command -v php &> /dev/null; then
        php -S localhost:8080
    else
        echo -e "${RED}Error: No suitable HTTP server found${NC}"
        echo "Install Python, Ruby, or PHP to use this feature"
        exit 1
    fi
}

# Main script logic
case "${1:-help}" in
    generate|gen)
        generate_docs
        ;;
    open)
        open_docs
        ;;
    clean)
        clean_docs
        ;;
    serve)
        serve_docs
        ;;
    help|--help|-h)
        print_usage
        ;;
    *)
        echo -e "${RED}Error: Unknown command '${1}'${NC}"
        print_usage
        exit 1
        ;;
esac
