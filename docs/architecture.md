# Architecture Documentation

## System Overview

Minishell follows a modular architecture with clear separation of concerns:

```
Input → Lexer → Parser → Expander → Executor → Output
```

## Core Components

### 1. Lexical Analysis (Lexer)
- **Location**: `srcs/lexer/`
- **Purpose**: Tokenizes input string into meaningful tokens
- **Files**:
  - `tokenizer.c`: Main tokenization logic
  - `token_utils.c`: Token manipulation utilities
  - `token_validation.c`: Token validation

### 2. Parsing (Parser)
- **Location**: `srcs/parser/`
- **Purpose**: Builds Abstract Syntax Tree (AST) from tokens
- **Files**:
  - `parser.c`: Main parsing logic
  - `syntax_check.c`: Syntax validation
  - `ast_builder.c`: AST construction
  - `command_parser.c`: Command-specific parsing

### 3. Expansion (Expander)
- **Location**: `srcs/expander/`
- **Purpose**: Expands variables and performs quote removal
- **Files**:
  - `variable_expansion.c`: Environment variable expansion
  - `quote_removal.c`: Quote processing
  - `wildcard_expansion.c`: Wildcard pattern matching

### 4. Execution (Executor)
- **Location**: `srcs/executor/`
- **Purpose**: Executes parsed commands
- **Files**:
  - `executor.c`: Main execution logic
  - `pipe_handler.c`: Pipeline management
  - `process_manager.c`: Process control

### 5. Built-in Commands
- **Location**: `srcs/builtins/`
- **Purpose**: Implementation of shell built-in commands
- **Commands**: `echo`, `cd`, `pwd`, `export`, `unset`, `env`, `exit`

### 6. Signal Handling
- **Location**: `srcs/signals/`
- **Purpose**: Handle system signals (SIGINT, SIGQUIT, etc.)

### 7. I/O Redirections
- **Location**: `srcs/redirections/`
- **Purpose**: Handle input/output redirections
- **Files**:
  - `input_redirect.c`: Input redirection (`<`, `<<`)
  - `output_redirect.c`: Output redirection (`>`, `>>`)

## Data Structures

### Token Structure
```c
typedef struct s_token {
    char        *value;
    int         type;
    int         position;
    struct s_token *next;
} t_token;
```

### AST Node Structure
```c
typedef struct s_ast_node {
    int                 type;
    char               *value;
    struct s_ast_node  *left;
    struct s_ast_node  *right;
    struct s_ast_node  *parent;
} t_ast_node;
```

### Shell Data Structure
```c
typedef struct s_shell {
    char        **envp;
    t_token     *tokens;
    t_ast_node  *ast;
    int         exit_status;
    pid_t       last_pid;
} t_shell;
```

## Process Flow

1. **Input Reading**: User input is read using readline
2. **Tokenization**: Input is broken down into tokens
3. **Parsing**: Tokens are organized into an AST
4. **Expansion**: Variables and wildcards are expanded
5. **Execution**: Commands are executed with proper I/O handling
6. **Cleanup**: Memory is freed and resources are released

## Memory Management

- All dynamically allocated memory is tracked
- Each allocation has a corresponding deallocation
- Memory leaks are detected using Valgrind
- Error conditions properly clean up partial allocations

## Error Handling

- All system calls are checked for errors
- Proper error messages are displayed
- Shell continues execution after non-fatal errors
- Exit codes are properly propagated
