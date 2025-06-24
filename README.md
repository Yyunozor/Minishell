# 🐚 Minishell

[![42 School](https://img.shields.io/badge/42-School-000000?style=flat&logo=42&logoColor=white)](https://42.fr)
[![Language](https://img.shields.io/badge/Language-C-blue.svg)](https://en.wikipedia.org/wiki/C_(programming_language))
[![Norm](https://img.shields.io/badge/Norm-42-brightgreen.svg)](https://github.com/42School/norminette)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A minimal UNIX-like shell implementation in C, designed to understand the fundamentals of process creation, signal handling, and command interpretation. This project recreates essential shell functionalities while maintaining clean, modular code architecture.

## 🎯 Project Goals

This implementation focuses on:

- **Understanding system calls**: Deep dive into `fork`, `execve`, `wait`, and signal handling
- **Process management**: Creating child processes and managing their lifecycle  
- **Command parsing**: Tokenization, syntax analysis, and building command structures
- **I/O redirection**: Implementing file descriptors manipulation for `<`, `>`, `>>`, `<<`
- **Inter-process communication**: Connecting processes through pipes `|`
- **Environment handling**: Variable expansion and built-in command implementation

## ✨ Features

### Core Functionality

- ✅ **Command Execution**: Execute system commands with arguments
- ✅ **Built-in Commands**: `echo`, `cd`, `pwd`, `export`, `unset`, `env`, `exit`
- ✅ **Pipes**: Chain multiple commands with `|` operator
- ✅ **Redirections**: Input `<`, output `>`, append `>>`, here-document `<<`
- ✅ **Quote Handling**: Single `'` and double `"` quotes with proper escaping
- ✅ **Variable Expansion**: Environment variables with `$VAR` syntax
- ✅ **Signal Management**: Handle `Ctrl+C`, `Ctrl+\`, `Ctrl+D` appropriately

### Bonus Features

- 🔥 **Logical Operators**: `&&` (AND) and `||` (OR) for conditional execution
- 🔥 **Wildcards**: Filename expansion with `*` globbing
- 🔥 **Subshells**: Command substitution and grouping

## 📋 Requirements

- POSIX-compliant system (Linux or macOS)
- GCC or Clang compiler with C99 support
- Make build system
- GNU Readline library (for command history and editing)

## 🚀 Quick Start

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Yyunozor/minishell.git
   cd minishell
   ```

2. **Build the project**

   ```bash
   make
   ```

   This compiles both the custom `libft` library and the `minishell` executable.

3. **Run the shell**

   ```bash
   ./minishell
   ```

### Build Commands

```bash
make clean   # Remove object files
make fclean  # Remove object files and executables
make re      # Clean rebuild (fclean + make)
make bonus   # Build with bonus features
```

## 💡 Usage Examples

Launch the shell and try these commands:

```bash
minishell$ echo "Hello, World!"
Hello, World!

minishell$ ls -la | grep minishell
-rwxr-xr-x  1 user  staff  45678 Jun 24 12:00 minishell

minishell$ export MY_VAR="test"
minishell$ echo $MY_VAR
test

minishell$ cat < input.txt | sort > output.txt

minishell$ cd .. && pwd
/Users/yyuno/Developer/42/Cursus

minishell$ exit
```

### Built-in Commands

| Command | Description | Example |
|---------|-------------|---------|
| `echo` | Display text with optional `-n` flag | `echo -n "Hello"` |
| `cd` | Change directory | `cd /path/to/dir` |
| `pwd` | Print working directory | `pwd` |
| `export` | Set environment variables | `export PATH=$PATH:/bin` |
| `unset` | Remove environment variables | `unset MY_VAR` |
| `env` | Display environment variables | `env` |
| `exit` | Exit the shell | `exit 0` |

## 📁 Project Architecture

```text
minishell/
├── includes/                    # Public headers
│   └── minishell.h             # Main header with structures and prototypes
├── libft/                      # Custom C library
│   ├── includes/
│   │   └── ft_libft.h         # Libft function prototypes
│   └── srcs/
│       ├── ft_strutils.c      # String manipulation utilities
│       └── ft_memutils.c      # Memory management utilities
├── srcs/                       # Shell implementation
│   ├── main.c                 # Entry point and main loop
│   ├── lexer/                 # Tokenization phase
│   │   ├── lexer.c           # Token identification and creation
│   │   └── lexer.h           # Lexer structures and functions
│   ├── parser/                # Syntax analysis phase
│   │   ├── parser.c          # AST construction from tokens
│   │   └── parser.h          # Parser structures and functions
│   ├── expander/              # Variable and quote processing
│   │   ├── expander.c        # Environment variable expansion
│   │   └── expander.h        # Expansion utilities
│   ├── executor/              # Command execution engine
│   │   ├── executor.c        # Process creation and management
│   │   └── executor.h        # Execution structures
│   ├── redirections/          # I/O redirection handling
│   │   ├── redirect.c        # File descriptor manipulation
│   │   └── redirect.h        # Redirection utilities
│   ├── builtins/              # Built-in command implementations
│   │   ├── cd.c              # Change directory command
│   │   ├── echo.c            # Echo command with -n option
│   │   ├── env.c             # Environment display
│   │   ├── exit.c            # Shell termination
│   │   ├── export.c          # Variable export to environment
│   │   ├── pwd.c             # Print working directory
│   │   └── unset.c           # Remove environment variables
│   ├── signals/               # Signal handling
│   │   ├── signals.c         # SIGINT, SIGQUIT management
│   │   └── signals.h         # Signal handler prototypes
│   └── bonus/                 # Optional advanced features
│       ├── logical_ops.c     # && and || operators
│       └── globbing.c        # Wildcard expansion
├── tests/                     # Testing framework
│   ├── mandatory/            # Core functionality tests
│   ├── bonus/                # Bonus feature tests
│   └── run_tests.sh          # Automated test runner
├── scripts/                   # Build and utility scripts
│   ├── build.sh              # Custom build script
│   └── clean.sh              # Cleanup script
├── docs/                      # Documentation
│   └── design.md             # Architecture and design decisions
├── .github/                   # GitHub workflows
│   └── workflows/
│       └── ci.yml            # Continuous integration
├── Makefile                   # Build configuration
├── README.md                  # This file
└── .gitignore                 # Git ignore patterns
```

## 🔄 Development Workflow

This project follows a **Feature-Branch Git workflow** for collaborative development:

### Branch Structure

- **`main`**: Production-ready, stable code only
- **`dev/username`**: Personal development branches
- **`feature/description`**: Specific feature implementations

### Workflow Steps

1. **Sync with main branch**

   ```bash
   git checkout main
   git pull origin main
   ```

2. **Create feature branch**

   ```bash
   git checkout -b feature/lexer-implementation
   ```

3. **Develop and commit changes**

   ```bash
   git add .
   git commit -m "feat(lexer): implement token recognition for pipes and redirections"
   ```

4. **Push and create pull request**

   ```bash
   git push -u origin feature/lexer-implementation
   gh pr create --title "Implement lexer token recognition" --body "Detailed description"
   ```

5. **Code review and merge**
   - Review process via GitHub PR
   - Squash and merge to keep history clean
   - Delete feature branch after merge

### Commit Message Convention

```text
type(scope): description

Examples:
feat(parser): add AST node creation for pipe commands
fix(executor): resolve memory leak in child process cleanup
docs(readme): update installation instructions
test(builtins): add comprehensive tests for export command
```

## 🧪 Testing

### Running Tests

Execute the complete test suite:

```bash
./tests/run_tests.sh
```

Run tests with bonus features:

```bash
./tests/run_tests.sh --bonus
```

### Manual Testing

Test individual components:

```bash
# Test basic commands
echo "ls -la" | ./minishell

# Test pipes and redirections
echo "ls | grep minishell > output.txt" | ./minishell

# Test built-ins
echo -e "export TEST=value\necho \$TEST\nexit" | ./minishell
```

## 📚 Technical Implementation

### Key Components

1. **Lexical Analysis**: Tokenizes input into meaningful units (commands, operators, arguments)
2. **Parsing**: Builds an Abstract Syntax Tree (AST) from tokens
3. **Expansion**: Handles variable substitution and quote removal
4. **Execution Engine**: Manages process creation, pipes, and I/O redirection
5. **Signal Handling**: Properly manages shell signals in interactive mode

### Memory Management

- All heap allocations are properly freed
- No memory leaks in normal operation
- Valgrind-clean implementation
- Custom error handling with cleanup

### Error Handling

```c
// Example error handling pattern
if (!(ast = parse_tokens(tokens)))
{
    cleanup_tokens(tokens);
    return (error_exit("Parse error", 2));
}
```

## 📝 42 School Compliance

### Norm Requirements

- ✅ Maximum 25 lines per function
- ✅ Maximum 80 characters per line
- ✅ Maximum 5 functions per file
- ✅ Forbidden functions properly handled
- ✅ No global variables (except for signal handling)

### Allowed Functions

```c
// System calls
fork, execve, wait, waitpid, wait3, wait4
exit, getcwd, chdir, stat, lstat, fstat
open, close, read, write, dup, dup2, pipe

// Memory management
malloc, free

// String/IO functions
printf, perror, strerror
access, isatty, ttyname, ttyslot, ioctl, getenv, tcsetattr, tcgetattr, tgetent, tgetflag, tgetnum, tgetstr, tgoto, tputs

// Signal handling
signal, sigaction, sigemptyset, sigaddset, kill

// Terminal control
rl_clear_history, rl_on_new_line, rl_replace_line, rl_redisplay
add_history, readline
```

## 🤝 Contributing

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Commit** your changes: `git commit -m 'feat: add amazing feature'`
4. **Push** to the branch: `git push origin feature/amazing-feature`
5. **Open** a Pull Request with detailed description

### Code Style Guidelines

- Follow 42 Norm strictly
- Use clear, descriptive variable names
- Comment complex algorithms
- Write modular, testable functions
- Update tests for new features

## 📄 License

Distributed under the MIT License. See [LICENSE](LICENSE) for details.

## 🎓 Learning Outcomes

This project teaches essential systems programming concepts:

- **Process Management**: Understanding Unix process model
- **Inter-Process Communication**: Pipes, file descriptors, and redirection
- **Signal Handling**: Proper signal management in interactive applications
- **Memory Management**: Manual memory allocation and cleanup
- **String Processing**: Parsing and tokenization techniques
- **Software Architecture**: Modular design and separation of concerns

---

Made with ❤️ for 42 School