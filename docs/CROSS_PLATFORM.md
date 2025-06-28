# 🌍 Cross-Platform Setup Guide

## Supported Platforms

Minishell is designed to work seamlessly across multiple operating systems:

- **🍎 macOS** (Intel & Apple Silicon)
- **🐧 Ubuntu/Debian Linux**
- **🔧 Arch Linux**

## Quick Setup

### Option 1: Automatic Setup (Recommended)

```bash
# Clone the repository
git clone <repository-url>
cd Minishell

# Run comprehensive setup
make setup-full
```

### Option 2: Manual Setup

#### macOS

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
make install

# Test environment
make test-env
```

#### Ubuntu/Debian

```bash
# Update package list
sudo apt-get update

# Install dependencies
make install

# Test environment
make test-env
```

#### Arch Linux

```bash
# Update package database
sudo pacman -Sy

# Install dependencies
make install

# Test environment
make test-env
```

## Environment Testing

After setup, verify your environment:

```bash
# Check system information
make system-info

# Test compilation environment
make test-env

# Build the project
make

# Run the shell
./minishell
```

## Platform-Specific Notes

### macOS

- **Intel Macs**: Uses `/usr/local/opt/readline`
- **Apple Silicon (M1/M2)**: Uses `/opt/homebrew/opt/readline`
- **Memory Testing**: Uses `leaks` command instead of `valgrind`

### Ubuntu/Debian

- **Package Manager**: `apt-get`
- **Required Packages**: `build-essential`, `libreadline-dev`, `valgrind`
- **Memory Testing**: Uses `valgrind`

### Arch Linux

- **Package Manager**: `pacman`
- **Required Packages**: `base-devel`, `readline`, `valgrind`
- **Memory Testing**: Uses `valgrind`

## Troubleshooting

### Common Issues

1. **Readline not found**
   ```bash
   # Check if readline is installed
   make test-env
   
   # Reinstall if needed
   make install
   ```

2. **Compiler errors**
   ```bash
   # Check system information
   make system-info
   
   # Verify environment
   make test-env
   ```

3. **Permission denied**
   ```bash
   # Make sure scripts are executable
   chmod +x scripts/*.sh
   ```

### Platform-Specific Troubleshooting

#### macOS

- **Homebrew issues**: Update Homebrew with `brew update`
- **Command Line Tools**: Install with `xcode-select --install`

#### Ubuntu/Debian

- **Package issues**: Run `sudo apt-get update` first
- **Build tools missing**: Install with `sudo apt-get install build-essential`

#### Arch Linux

- **Package conflicts**: Update system with `sudo pacman -Syu`
- **Base-devel missing**: Install with `sudo pacman -S base-devel`

## Development Workflow

1. **Setup** (one-time)
   ```bash
   make setup-full
   ```

2. **Daily Development**
   ```bash
   make            # Build
   make test       # Run tests
   make leaks      # Check memory leaks
   ```

3. **Before Commits**
   ```bash
   make norm       # Check 42 norm
   make test       # Run all tests
   ```

## CI/CD Considerations

For continuous integration across platforms:

```yaml
# Example GitHub Actions workflow
strategy:
  matrix:
    os: [ubuntu-latest, macos-latest]
    
steps:
  - uses: actions/checkout@v2
  - name: Setup environment
    run: make setup-full
  - name: Build project
    run: make
  - name: Run tests
    run: make test
```

## Getting Help

- **System Info**: `make system-info`
- **Environment Test**: `make test-env`
- **Full Help**: `make help`
- **Project Stats**: `make stats`

---

*Cross-platform compatibility ensures your shell works everywhere! 🌍*
