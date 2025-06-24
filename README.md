# 🐚 Minishell

[![42 School](https://img.shields.io/badge/42-School-000000?style=flat&logo=42&logoColor=white)](https://42.fr/)
[![C](https://img.shields.io/badge/C-00599C?style=flat&logo=c&logoColor=white)](https://en.wikipedia.org/wiki/C_(programming_language))
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A robust shell implementation in C that recreates the core functionality of bash. This project demonstrates systems programming concepts including process management, file descriptors, signal handling, and command parsing.

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Git Workflow](#git-workflow-for-collaboration)
- [Development Guidelines](#development-guidelines)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Resources](#resources)

## 🎯 Project Overview

Minishell is a simplified shell interpreter that provides a command-line interface similar to bash. It handles command execution, environment variables, redirections, pipes, and built-in commands while maintaining compatibility with POSIX standards.

### Learning Objectives

- Process creation and management (`fork`, `execve`, `wait`)
- File descriptor manipulation and I/O redirection
- Signal handling and process control
- Memory management and error handling
- Parsing and lexical analysis
- Inter-process communication via pipes

## ⭐ Features

### Core Functionality

- ✅ Command execution with PATH resolution
- ✅ Built-in commands implementation
- ✅ Environment variable handling
- ✅ Input/Output redirections
- ✅ Pipeline execution
- ✅ Signal handling
- ✅ Quote parsing and escaping
- ✅ Command history (with readline)

### Built-in Commands

| Command | Description | Example |
|---------|-------------|---------|
| `echo` | Display text with `-n` option | `echo -n "Hello"` |
| `cd` | Change directory (relative/absolute) | `cd /home/user` |
| `pwd` | Print working directory | `pwd` |
| `export` | Set environment variables | `export VAR=value` |
| `unset` | Unset environment variables | `unset VAR` |
| `env` | Display environment variables | `env` |
| `exit` | Exit shell with status code | `exit 0` |

### Advanced Features

- 🔄 Command substitution (`$(command)`)
- 🔗 Logical operators (`&&`, `||`)
- 📁 Wildcards (`*`) - *Bonus*
- 🔀 Here-document (`<<`) - *Bonus*
- 📊 Process substitution - *Bonus*

## 📁 Project Structure

```
Minishell/
├── 📄 Makefile                    # Build configuration
├── 📖 README.md                   # Project documentation
├── 🚫 .gitignore                  # Git ignore rules
├── 📂 Includes/
│   └── 🔧 minishell.h            # Main header file
├── 📂 srcs/                      # Source code directory
│   ├── 🚀 main.c                 # Entry point
│   ├── 📂 init/                  # Shell initialization
│   │   ├── init_shell.c          # Shell setup
│   │   └── init_env.c            # Environment setup
│   ├── 📂 lexer/                 # Lexical analysis
│   │   ├── tokenizer.c           # Token creation
│   │   └── token_utils.c         # Token utilities
│   ├── 📂 parser/                # Command parsing
│   │   ├── parser.c              # Main parsing logic
│   │   ├── syntax_check.c        # Syntax validation
│   │   └── ast_builder.c         # AST construction
│   ├── 📂 expander/              # Variable expansion
│   │   ├── variable_expansion.c  # $VAR expansion
│   │   └── quote_removal.c       # Quote processing
│   ├── 📂 executor/              # Command execution
│   │   ├── executor.c            # Main execution
│   │   ├── pipe_handler.c        # Pipeline execution
│   │   └── process_manager.c     # Process control
│   ├── 📂 builtins/              # Built-in commands
│   │   ├── builtin_echo.c        # echo command
│   │   ├── builtin_cd.c          # cd command
│   │   ├── builtin_pwd.c         # pwd command
│   │   ├── builtin_export.c      # export command
│   │   ├── builtin_unset.c       # unset command
│   │   ├── builtin_env.c         # env command
│   │   └── builtin_exit.c        # exit command
│   ├── 📂 redirections/          # I/O redirections
│   │   ├── input_redirect.c      # Input redirection
│   │   └── output_redirect.c     # Output redirection
│   ├── 📂 signals/               # Signal handling
│   │   └── signal_handler.c      # Signal management
│   ├── 📂 utils/                 # Utility functions
│   │   ├── memory_utils.c        # Memory management
│   │   ├── string_utils.c        # String operations
│   │   └── error_handler.c       # Error handling
│   └── 📂 bonus/                 # Bonus features
│       ├── wildcards.c           # Wildcard expansion
│       └── heredoc.c             # Here-document
├── 📂 tests/                     # Test files
│   ├── unit_tests/               # Unit tests
│   ├── integration_tests/        # Integration tests
│   └── test_runner.sh            # Test script
├── 📂 docs/                      # Documentation
│   ├── architecture.md           # System architecture
│   └── api_reference.md          # API documentation
└── 📂 scripts/                   # Utility scripts
    ├── setup.sh                  # Environment setup
    └── test_compliance.sh        # Compliance testing
```

## 🚀 Installation

### Prerequisites

```bash
# macOS
brew install readline

# Ubuntu/Debian
sudo apt-get install libreadline-dev

# Arch Linux
sudo pacman -S readline
```

### Build Process

```bash
# Clone the repository
git clone https://github.com/username/minishell.git
cd minishell

# Compile the project
make

# Run the shell
./minishell
```

### Compilation Options

```bash
make                # Standard build
make debug          # Debug build with -g flag
make sanitize       # Build with address sanitizer
make bonus          # Build with bonus features
make clean          # Remove object files
make fclean         # Remove all generated files
make re             # Rebuild everything
```

## 💻 Usage

### Basic Commands

```bash
$ ./minishell
minishell$ echo "Hello, World!"
Hello, World!

minishell$ pwd
/Users/username/minishell

minishell$ export MY_VAR="test"
minishell$ echo $MY_VAR
test

minishell$ ls -la | grep minishell
-rwxr-xr-x  1 user  staff  50432 Nov 15 10:30 minishell
```

### Advanced Usage

```bash
# Redirections
minishell$ echo "Hello" > output.txt
minishell$ cat < input.txt
minishell$ ls >> log.txt

# Pipes
minishell$ ls -la | grep ".c" | wc -l

# Environment variables
minishell$ export PATH="/usr/local/bin:$PATH"
minishell$ echo $USER

# Built-in commands
minishell$ cd /tmp
minishell$ pwd
/tmp
minishell$ cd -
minishell$ exit 0
```

## 🔄 Git Workflow for Collaboration

### Repository Setup

```bash
# Clone and setup
git clone <repository-url>
cd Minishell
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Add upstream (if forked)
git remote add upstream <original-repo-url>
```

### Feature Development Workflow

```bash
# 1. Create feature branch
git checkout -b feature/component-name
# Examples:
# git checkout -b feature/lexer-tokenization
# git checkout -b feature/pipe-execution
# git checkout -b fix/memory-leak-parser

# 2. Work on your feature
# Make changes, test, commit

# 3. Commit with conventional format
git add .
git commit -m "feat(lexer): implement token classification"
git commit -m "fix(parser): resolve memory leak in AST creation"
git commit -m "docs: update API documentation"

# 4. Push and create PR
git push origin feature/component-name
# Create PR on GitHub
```

### Daily Sync Routine

```bash
# Morning routine
git checkout main
git pull upstream main        # If using fork
git pull origin main         # If direct access
git checkout feature/your-branch
git rebase main              # or merge main

# Before pushing
make && make test            # Ensure it builds and passes tests
git push origin feature/your-branch
```

### Commit Convention

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Types:**

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code style/formatting
- `refactor`: Code refactoring
- `test`: Tests
- `chore`: Maintenance

**Examples:**

```bash
git commit -m "feat(executor): add pipeline execution support"
git commit -m "fix(signals): handle SIGINT during command execution"
git commit -m "refactor(parser): simplify AST node creation"
git commit -m "test(builtins): add comprehensive echo command tests"
```

### Advanced Git Operations

```bash
# Interactive rebase (clean up commits)
git rebase -i HEAD~3

# Squash commits
git reset --soft HEAD~3
git commit -m "feat(parser): complete parsing implementation"

# Cherry-pick specific commits
git cherry-pick <commit-hash>

# Resolve conflicts
git status
# Edit conflicted files
git add .
git rebase --continue

# Stash management
git stash push -m "WIP: working on lexer"
git stash list
git stash pop stash@{0}
```

### GitHub CLI Integration

```bash
# Install gh CLI
brew install gh              # macOS
sudo apt install gh         # Ubuntu

# Authenticate
gh auth login

# Create PR with template
gh pr create --title "feat: implement lexer" \
             --body "Implements tokenization with proper error handling"

# Review PRs
gh pr list
gh pr view 123
gh pr checkout 123
gh pr merge 123 --squash

# Issues management
gh issue create --title "Memory leak in parser" \
                --body "Valgrind shows leak in parse_command function"
gh issue list --assignee @me
```

## 🛠️ Development Guidelines

### Code Standards

- **42 Norm Compliance**: Strict adherence to 42 coding standards
- **Function Length**: Maximum 25 lines per function
- **File Organization**: Maximum 5 functions per file
- **Variable Naming**: Descriptive names, no single letters except counters
- **Memory Management**: Always free allocated memory, check for leaks

### Error Handling

```c
// Example error handling pattern
if (!(data = malloc(sizeof(t_data))))
{
    ft_putendl_fd("minishell: malloc error", STDERR_FILENO);
    return (ERROR);
}
```

### Memory Management Checklist

- [ ] All `malloc` calls have corresponding `free`
- [ ] Check return values of system calls
- [ ] Handle edge cases (empty input, invalid commands)
- [ ] Use `valgrind` for leak detection
- [ ] Implement proper cleanup on exit

### Testing Strategy

1. **Unit Tests**: Test individual functions
2. **Integration Tests**: Test component interactions
3. **Comparison Tests**: Compare output with bash
4. **Edge Case Tests**: Empty input, invalid syntax, large inputs
5. **Memory Tests**: Check for leaks and invalid access

## 🧪 Testing

### Manual Testing

```bash
# Basic functionality
./minishell
> echo "test"
> pwd
> cd /tmp
> env | grep USER
> export TEST=123
> echo $TEST
> ls | wc -l
> cat < /etc/passwd | head -5
> exit

# Edge cases
> echo ""
> cd
> cd /nonexistent
> export =value
> $INVALID_VAR
> ls |
> > output.txt
```

### Automated Testing

```bash
# Run test suite
make test

# Specific tests
./tests/test_runner.sh lexer
./tests/test_runner.sh parser
./tests/test_runner.sh executor

# Memory testing
make sanitize
valgrind --leak-check=full ./minishell
```

### Comparison with Bash

```bash
# Create test script
echo 'echo "Hello World"' > test_cmd.sh
echo 'ls | wc -l' >> test_cmd.sh

# Test with bash
bash < test_cmd.sh > bash_output.txt

# Test with minishell
./minishell < test_cmd.sh > minishell_output.txt

# Compare outputs
diff bash_output.txt minishell_output.txt
```

## 🐛 Troubleshooting

### Common Issues

**Compilation Errors:**

```bash
# Readline not found
brew install readline
export CPPFLAGS="-I/usr/local/opt/readline/include"
export LDFLAGS="-L/usr/local/opt/readline/lib"

# Permission denied
chmod +x minishell
```

**Runtime Issues:**

```bash
# Command not found
echo $PATH
export PATH="/usr/bin:/bin:$PATH"

# Segmentation fault
gdb ./minishell
(gdb) run
(gdb) bt
```

**Memory Leaks:**

```bash
valgrind --leak-check=full --show-leak-kinds=all ./minishell
```

### Debug Mode

```bash
make debug
gdb ./minishell
(gdb) set args
(gdb) break main
(gdb) run
(gdb) step
```

## 🤝 Contributing

### Code Review Checklist

- [ ] Code follows 42 Norm
- [ ] No memory leaks detected
- [ ] All tests pass
- [ ] Documentation updated
- [ ] Commit messages follow convention
- [ ] No debug code left in production

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed
- [ ] No memory leaks

## Checklist
- [ ] Code follows 42 Norm
- [ ] Self-review completed
- [ ] Documentation updated
```

## 📚 Resources

### Documentation

- [Bash Manual](https://www.gnu.org/software/bash/manual/bash.html)
- [POSIX Shell Specification](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html)
- [GNU Readline](https://tiswww.case.edu/php/chet/readline/rltop.html)

### System Programming

- [Advanced Programming in UNIX Environment](https://www.apuebook.com/)
- [The Linux Programming Interface](https://man7.org/tlpi/)
- [Beej's Guide to Unix IPC](https://beej.us/guide/bgipc/)

### 42 School Resources

- [42 Norm](https://github.com/42School/norminette)
- [42 Intra Projects](https://projects.intra.42.fr/)
- [42 Slack Community](https://42born2code.slack.com/)

### Tools & Debugging

- [Valgrind Documentation](https://valgrind.org/docs/manual/)
- [GDB Tutorial](https://www.gdbtutorial.com/)
- [Git Documentation](https://git-scm.com/doc)

---

## 👥 Authors

- **[Your Name]** - *Initial development* - [GitHub](https://github.com/yourusername)
- **[Teammate Name]** - *Core features* - [GitHub](https://github.com/teammate)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- 42 School for the project specifications
- The open-source community for tools and libraries
- Fellow students for collaboration and support

---

*Made with ❤️ at 42 School*
