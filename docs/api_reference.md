# 📚 API Reference Documentation

## 📋 Table of Contents

- [Overview](#overview)
- [Core Functions](#core-functions)
- [Initialization Functions](#initialization-functions)
- [Lexer Functions](#lexer-functions)
- [Parser Functions](#parser-functions)
- [Expander Functions](#expander-functions)
- [Executor Functions](#executor-functions)
- [Built-in Functions](#built-in-functions)
- [Utility Functions](#utility-functions)
- [Error Handling](#error-handling)
- [Function Index](#function-index)

---

## 🎯 Overview

This document provides comprehensive API documentation for all public functions in the Minishell project. Each function includes detailed parameter descriptions, return values, usage examples, and related functions.

### 🏷️ Function Categories

| Category | Purpose | File Pattern |
|----------|---------|--------------|
| **Init** | Shell initialization and setup | `srcs/init/*.c` |
| **Lexer** | Tokenization and lexical analysis | `srcs/lexer/*.c` |
| **Parser** | AST construction and syntax checking | `srcs/parser/*.c` |
| **Expander** | Variable and wildcard expansion | `srcs/expander/*.c` |
| **Executor** | Command execution and process management | `srcs/executor/*.c` |
| **Builtins** | Built-in command implementations | `srcs/builtins/*.c` |
| **Utils** | Utility and helper functions | `srcs/utils/*.c` |

---

## 🚀 Core Functions

### Main Entry Points

#### `main(int argc, char **argv, char **envp)`
- **Purpose**: Main entry point for the shell
- **Parameters**: 
  - `argc`: Argument count
  - `argv`: Argument vector
  - `envp`: Environment variables array
- **Returns**: Exit status code
- **Location**: `main.c`
- **Example**:
  ```c
  int main(int argc, char **argv, char **envp) {
      t_shell shell;
      init_shell(&shell, envp);
      return run_shell(&shell);
  }
  ```

#### `run_shell(t_shell *shell)`
- **Purpose**: Main shell execution loop
- **Parameters**: 
  - `shell`: Pointer to initialized shell structure
- **Returns**: Exit status code
- **Location**: `main.c`
- **Related**: `init_shell()`, `cleanup_shell()`

---

## 🔧 Initialization Functions

### Shell Setup

#### `init_shell(t_shell *shell, char **envp)`
- **Purpose**: Initialize shell data structure and components
- **Parameters**: 
  - `shell`: Pointer to shell structure to initialize
  - `envp`: Environment variables array
- **Returns**: 
  - `0`: Success
  - `-1`: Initialization failure
- **Location**: `srcs/init/init_shell.c`
- **Example**:
  ```c
  t_shell shell;
  if (init_shell(&shell, envp) < 0) {
      fprintf(stderr, "Failed to initialize shell\n");
      return 1;
  }
  ```
- **Related**: `cleanup_shell()`, `init_env()`

#### `init_env(t_shell *shell, char **envp)`
- **Purpose**: Initialize environment variables and PATH
- **Parameters**:
  - `shell`: Pointer to shell structure  
  - `envp`: Environment variables array
- **Returns**: 
  - `0`: Success
  - `-1`: Environment initialization failure
- **Location**: `srcs/init/init_env.c`
- **Example**:
  ```c
  if (init_env(&shell, envp) < 0) {
      cleanup_shell(&shell);
      return -1;
  }
  ```
- **Related**: `get_env_var()`, `set_env_var()`

#### `init_signals(void)`
- **Purpose**: Setup signal handlers for shell operation
- **Parameters**: None
- **Returns**: 
  - `0`: Success
  - `-1`: Signal setup failure
- **Location**: `srcs/signals/signal_handler.c`
- **Example**:
  ```c
  if (init_signals() < 0) {
      fprintf(stderr, "Warning: Signal setup failed\n");
  }
  ```
- **Related**: `restore_signals()`, `handle_sigint()`

---

## 🔤 Lexer Functions

### Tokenization

#### `tokenize(const char *input)`
- **Purpose**: Convert input string into linked list of tokens
- **Parameters**: 
  - `input`: Raw command string to tokenize
- **Returns**: 
  - `t_token *`: Pointer to first token in list
  - `NULL`: Tokenization failure or empty input
- **Location**: `srcs/lexer/tokenizer.c`
- **Example**:
  ```c
  char *input = "echo \"Hello World\" | grep Hello";
  t_token *tokens = tokenize(input);
  if (!tokens) {
      fprintf(stderr, "Tokenization failed\n");
      return -1;
  }
  ```
- **Related**: `free_tokens()`, `validate_tokens()`

#### `create_token(t_token_type type, const char *value)`
- **Purpose**: Create a new token with specified type and value
- **Parameters**:
  - `type`: Token type from `t_token_type` enum
  - `value`: String value of the token
- **Returns**: 
  - `t_token *`: Pointer to new token
  - `NULL`: Memory allocation failure
- **Location**: `srcs/lexer/tokenizer.c`
- **Example**:
  ```c
  t_token *word_token = create_token(TOKEN_WORD, "echo");
  t_token *pipe_token = create_token(TOKEN_PIPE, "|");
  ```
- **Related**: `free_token()`, `token_append()`

#### `validate_tokens(t_token *tokens)`
- **Purpose**: Validate token sequence for syntax errors
- **Parameters**:
  - `tokens`: Linked list of tokens to validate
- **Returns**: 
  - `0`: Valid token sequence
  - `-1`: Syntax error detected
- **Location**: `srcs/lexer/token_validation.c`
- **Example**:
  ```c
  if (validate_tokens(tokens) < 0) {
      fprintf(stderr, "Syntax error in command\n");
      free_tokens(tokens);
      return -1;
  }
  ```
- **Related**: `tokenize()`, `check_syntax()`

### Token Utilities

#### `token_append(t_token **head, t_token *new_token)`
- **Purpose**: Append token to end of token list
- **Parameters**:
  - `head`: Pointer to pointer to first token
  - `new_token`: Token to append
- **Returns**: None
- **Location**: `srcs/lexer/token_utils.c`
- **Example**:
  ```c
  t_token *tokens = NULL;
  t_token *word = create_token(TOKEN_WORD, "ls");
  token_append(&tokens, word);
  ```
- **Related**: `create_token()`, `free_tokens()`

#### `free_tokens(t_token *tokens)`
- **Purpose**: Free entire linked list of tokens
- **Parameters**:
  - `tokens`: First token in list to free
- **Returns**: None
- **Location**: `srcs/lexer/token_utils.c`
- **Example**:
  ```c
  t_token *tokens = tokenize(input);
  // ... use tokens ...
  free_tokens(tokens);
  ```
- **Related**: `free_token()`, `tokenize()`

---

## 🌳 Parser Functions

### AST Construction

#### `parse_tokens(t_token *tokens)`
- **Purpose**: Build Abstract Syntax Tree from token list
- **Parameters**:
  - `tokens`: List of validated tokens to parse
- **Returns**: 
  - `t_ast_node *`: Root node of constructed AST
  - `NULL`: Parsing failure
- **Location**: `srcs/parser/parser.c`
- **Example**:
  ```c
  t_token *tokens = tokenize(input);
  if (validate_tokens(tokens) == 0) {
      t_ast_node *ast = parse_tokens(tokens);
      if (ast) {
          execute_ast(shell, ast);
          free_ast(ast);
      }
  }
  ```
- **Related**: `free_ast()`, `validate_tokens()`

#### `create_ast_node(t_node_type type)`
- **Purpose**: Create new AST node of specified type
- **Parameters**:
  - `type`: Node type from `t_node_type` enum
- **Returns**: 
  - `t_ast_node *`: Pointer to new node
  - `NULL`: Memory allocation failure
- **Location**: `srcs/parser/ast_builder.c`
- **Example**:
  ```c
  t_ast_node *cmd_node = create_ast_node(NODE_COMMAND);
  if (cmd_node) {
      cmd_node->args = parse_arguments(tokens);
  }
  ```
- **Related**: `free_ast_node()`, `parse_tokens()`

#### `check_syntax(t_token *tokens)`
- **Purpose**: Perform comprehensive syntax validation
- **Parameters**:
  - `tokens`: Token list to check
- **Returns**: 
  - `0`: Valid syntax
  - `SYNTAX_ERROR_*`: Specific syntax error code
- **Location**: `srcs/parser/syntax_check.c`
- **Example**:
  ```c
  int syntax_result = check_syntax(tokens);
  if (syntax_result != 0) {
      print_syntax_error(syntax_result);
      return -1;
  }
  ```
- **Related**: `validate_tokens()`, `print_syntax_error()`

### AST Utilities

#### `free_ast(t_ast_node *node)`
- **Purpose**: Recursively free AST and all children
- **Parameters**:
  - `node`: Root node to free
- **Returns**: None
- **Location**: `srcs/parser/ast_builder.c`
- **Example**:
  ```c
  t_ast_node *ast = parse_tokens(tokens);
  execute_ast(shell, ast);
  free_ast(ast);  // Cleanup
  ```
- **Related**: `create_ast_node()`, `parse_tokens()`

---

## 🔄 Expander Functions

### Variable Expansion

#### `expand_variables(t_shell *shell, const char *str)`
- **Purpose**: Expand environment variables in string
- **Parameters**:
  - `shell`: Shell context with environment
  - `str`: String containing variables to expand
- **Returns**: 
  - `char *`: Newly allocated expanded string
  - `NULL`: Expansion failure
- **Location**: `srcs/expander/variable_expansion.c`
- **Example**:
  ```c
  char *input = "echo $HOME/Documents";
  char *expanded = expand_variables(shell, input);
  // expanded might be: "echo /Users/john/Documents"
  free(expanded);
  ```
- **Related**: `get_env_var()`, `expand_dollar()`

#### `expand_dollar(t_shell *shell, const char **str)`
- **Purpose**: Expand single `$VAR` or `${VAR}` expression
- **Parameters**:
  - `shell`: Shell context
  - `str`: Pointer to string position at `$`
- **Returns**: 
  - `char *`: Expanded variable value
  - `NULL`: Variable not found or error
- **Location**: `srcs/expander/variable_expansion.c`
- **Example**:
  ```c
  const char *pos = "$USER";
  char *value = expand_dollar(shell, &pos);
  // value might be: "john"
  ```
- **Related**: `expand_variables()`, `get_env_var()`

### Quote Processing

#### `remove_quotes(const char *str)`
- **Purpose**: Remove quotes and process escape sequences
- **Parameters**:
  - `str`: String with quotes to process
- **Returns**: 
  - `char *`: Newly allocated string without quotes
  - `NULL`: Processing failure
- **Location**: `srcs/expander/quote_removal.c`
- **Example**:
  ```c
  char *quoted = "\"Hello World\"";
  char *unquoted = remove_quotes(quoted);
  // unquoted is: "Hello World"
  free(unquoted);
  ```
- **Related**: `process_quotes()`, `expand_variables()`

### Wildcard Expansion

#### `expand_wildcards(const char *pattern)`
- **Purpose**: Expand wildcard patterns to matching filenames
- **Parameters**:
  - `pattern`: Pattern with `*` wildcards
- **Returns**: 
  - `char **`: NULL-terminated array of matching files
  - `NULL`: No matches or error
- **Location**: `srcs/expander/wildcard_expansion.c`
- **Example**:
  ```c
  char **matches = expand_wildcards("*.c");
  if (matches) {
      for (int i = 0; matches[i]; i++) {
          printf("%s\n", matches[i]);
      }
      free_string_array(matches);
  }
  ```
- **Related**: `match_pattern()`, `free_string_array()`

---

## ⚡ Executor Functions

### Command Execution

#### `execute_ast(t_shell *shell, t_ast_node *ast)`
- **Purpose**: Execute parsed and expanded AST
- **Parameters**:
  - `shell`: Shell context
  - `ast`: AST to execute
- **Returns**: 
  - `0`: Successful execution
  - `>0`: Command exit status
  - `-1`: Execution failure
- **Location**: `srcs/executor/executor.c`
- **Example**:
  ```c
  t_ast_node *ast = parse_tokens(tokens);
  int status = execute_ast(shell, ast);
  shell->exit_status = status;
  ```
- **Related**: `execute_command()`, `execute_pipeline()`

#### `execute_command(t_shell *shell, t_ast_node *cmd)`
- **Purpose**: Execute single command node
- **Parameters**:
  - `shell`: Shell context
  - `cmd`: Command node to execute
- **Returns**: Exit status of command
- **Location**: `srcs/executor/command_executor.c`
- **Example**:
  ```c
  if (cmd->type == NODE_COMMAND) {
      int status = execute_command(shell, cmd);
      return status;
  }
  ```
- **Related**: `is_builtin()`, `execute_external()`

#### `execute_pipeline(t_shell *shell, t_ast_node *pipeline)`
- **Purpose**: Execute pipeline of commands connected by pipes
- **Parameters**:
  - `shell`: Shell context
  - `pipeline`: Pipeline node to execute
- **Returns**: Exit status of last command
- **Location**: `srcs/executor/pipe_handler.c`
- **Example**:
  ```c
  if (ast->type == NODE_PIPELINE) {
      int status = execute_pipeline(shell, ast);
      return status;
  }
  ```
- **Related**: `setup_pipes()`, `wait_pipeline()`

### Process Management

#### `fork_and_exec(t_shell *shell, char **args)`
- **Purpose**: Fork process and execute external command
- **Parameters**:
  - `shell`: Shell context
  - `args`: NULL-terminated argument array
- **Returns**: 
  - `pid_t`: Child process ID
  - `-1`: Fork or exec failure
- **Location**: `srcs/executor/process_manager.c`
- **Example**:
  ```c
  char *args[] = {"ls", "-la", NULL};
  pid_t pid = fork_and_exec(shell, args);
  if (pid > 0) {
      int status;
      waitpid(pid, &status, 0);
  }
  ```
- **Related**: `wait_processes()`, `find_executable()`

#### `wait_processes(pid_t *pids, int count)`
- **Purpose**: Wait for multiple processes to complete
- **Parameters**:
  - `pids`: Array of process IDs to wait for
  - `count`: Number of processes
- **Returns**: Exit status of last process
- **Location**: `srcs/executor/process_manager.c`
- **Example**:
  ```c
  pid_t pids[3] = {pid1, pid2, pid3};
  int status = wait_processes(pids, 3);
  ```
- **Related**: `fork_and_exec()`, `execute_pipeline()`

---

## 🏠 Built-in Functions

### Command Implementations

#### `builtin_echo(char **args)`
- **Purpose**: Implementation of echo built-in command
- **Parameters**:
  - `args`: NULL-terminated argument array
- **Returns**: 
  - `0`: Success
  - `1`: Error
- **Location**: `srcs/builtins/builtin_echo.c`
- **Example**:
  ```c
  char *args[] = {"echo", "-n", "Hello", NULL};
  int status = builtin_echo(args);
  ```
- **Features**: Supports `-n` flag, escape sequences
- **Related**: `is_builtin()`, `execute_builtin()`

#### `builtin_cd(t_shell *shell, char **args)`
- **Purpose**: Implementation of cd built-in command
- **Parameters**:
  - `shell`: Shell context for environment updates
  - `args`: NULL-terminated argument array
- **Returns**: 
  - `0`: Success
  - `1`: Directory change failed
- **Location**: `srcs/builtins/builtin_cd.c`
- **Example**:
  ```c
  char *args[] = {"cd", "/home/user", NULL};
  int status = builtin_cd(shell, args);
  ```
- **Features**: Updates `PWD` and `OLDPWD` variables
- **Related**: `builtin_pwd()`, `update_env()`

#### `builtin_export(t_shell *shell, char **args)`
- **Purpose**: Implementation of export built-in command
- **Parameters**:
  - `shell`: Shell context for environment
  - `args`: NULL-terminated argument array
- **Returns**: 
  - `0`: Success
  - `1`: Invalid variable name/value
- **Location**: `srcs/builtins/builtin_export.c`
- **Example**:
  ```c
  char *args[] = {"export", "MY_VAR=value", NULL};
  int status = builtin_export(shell, args);
  ```
- **Features**: Validates variable names, handles assignments
- **Related**: `builtin_unset()`, `set_env_var()`

### Built-in Utilities

#### `is_builtin(const char *command)`
- **Purpose**: Check if command is a shell built-in
- **Parameters**:
  - `command`: Command name to check
- **Returns**: 
  - `true`: Command is built-in
  - `false`: Command is external
- **Location**: `srcs/builtins/builtin_utils.c`
- **Example**:
  ```c
  if (is_builtin("cd")) {
      execute_builtin(shell, args);
  } else {
      execute_external(shell, args);
  }
  ```
- **Related**: `execute_builtin()`, `get_builtin_function()`

---

## 🛠️ Utility Functions

### Memory Management

#### `safe_malloc(size_t size)`
- **Purpose**: Safe memory allocation with error checking
- **Parameters**:
  - `size`: Number of bytes to allocate
- **Returns**: 
  - `void *`: Pointer to allocated memory
  - `NULL`: Allocation failure
- **Location**: `srcs/utils/memory_utils.c`
- **Example**:
  ```c
  char *buffer = safe_malloc(256);
  if (!buffer) {
      fprintf(stderr, "Memory allocation failed\n");
      return -1;
  }
  ```
- **Related**: `safe_free()`, `safe_realloc()`

#### `safe_free(void **ptr)`
- **Purpose**: Safe memory deallocation with pointer nullification
- **Parameters**:
  - `ptr`: Pointer to pointer to free
- **Returns**: None
- **Location**: `srcs/utils/memory_utils.c`
- **Example**:
  ```c
  char *str = safe_malloc(100);
  // ... use str ...
  safe_free((void **)&str);  // str is now NULL
  ```
- **Related**: `safe_malloc()`, `cleanup_shell()`

### String Utilities

#### `safe_strdup(const char *str)`
- **Purpose**: Safe string duplication with error checking
- **Parameters**:
  - `str`: String to duplicate
- **Returns**: 
  - `char *`: Newly allocated copy of string
  - `NULL`: Allocation failure or NULL input
- **Location**: `srcs/utils/string_utils.c`
- **Example**:
  ```c
  char *copy = safe_strdup("Hello World");
  if (copy) {
      printf("Copy: %s\n", copy);
      free(copy);
  }
  ```
- **Related**: `safe_malloc()`, `string_join()`

#### `split_string(const char *str, char delimiter)`
- **Purpose**: Split string by delimiter into array
- **Parameters**:
  - `str`: String to split
  - `delimiter`: Character to split on
- **Returns**: 
  - `char **`: NULL-terminated array of strings
  - `NULL`: Split failure
- **Location**: `srcs/utils/string_utils.c`
- **Example**:
  ```c
  char **parts = split_string("one:two:three", ':');
  if (parts) {
      for (int i = 0; parts[i]; i++) {
          printf("Part %d: %s\n", i, parts[i]);
      }
      free_string_array(parts);
  }
  ```
- **Related**: `free_string_array()`, `string_join()`

### Environment Utilities

#### `get_env_var(t_shell *shell, const char *name)`
- **Purpose**: Get environment variable value
- **Parameters**:
  - `shell`: Shell context
  - `name`: Variable name to look up
- **Returns**: 
  - `char *`: Variable value (not owned)
  - `NULL`: Variable not found
- **Location**: `srcs/utils/env_utils.c`
- **Example**:
  ```c
  char *home = get_env_var(shell, "HOME");
  if (home) {
      printf("Home directory: %s\n", home);
  }
  ```
- **Related**: `set_env_var()`, `unset_env_var()`

#### `set_env_var(t_shell *shell, const char *name, const char *value)`
- **Purpose**: Set or update environment variable
- **Parameters**:
  - `shell`: Shell context
  - `name`: Variable name
  - `value`: Variable value
- **Returns**: 
  - `0`: Success
  - `-1`: Setting failed
- **Location**: `srcs/utils/env_utils.c`
- **Example**:
  ```c
  if (set_env_var(shell, "MY_VAR", "my_value") == 0) {
      printf("Variable set successfully\n");
  }
  ```
- **Related**: `get_env_var()`, `builtin_export()`

---

## ⚠️ Error Handling

### Error Functions

#### `print_error(const char *function, const char *message)`
- **Purpose**: Print formatted error message
- **Parameters**:
  - `function`: Function name where error occurred
  - `message`: Error description
- **Returns**: None
- **Location**: `srcs/utils/error_handler.c`
- **Example**:
  ```c
  if (fork() == -1) {
      print_error("fork_and_exec", "Failed to fork process");
      return -1;
  }
  ```
- **Related**: `print_syntax_error()`, `cleanup_on_error()`

#### `cleanup_on_error(t_shell *shell)`
- **Purpose**: Perform cleanup when error occurs
- **Parameters**:
  - `shell`: Shell context to clean up
- **Returns**: None
- **Location**: `srcs/utils/error_handler.c`
- **Example**:
  ```c
  if (init_shell(&shell, envp) < 0) {
      cleanup_on_error(&shell);
      return 1;
  }
  ```
- **Related**: `cleanup_shell()`, `print_error()`

---

## 📇 Function Index

### Quick Reference

| Function | Category | Returns | Purpose |
|----------|----------|---------|---------|
| `main` | Core | `int` | Main entry point |
| `init_shell` | Init | `int` | Initialize shell |
| `tokenize` | Lexer | `t_token *` | Create token list |
| `parse_tokens` | Parser | `t_ast_node *` | Build AST |
| `expand_variables` | Expander | `char *` | Expand variables |
| `execute_ast` | Executor | `int` | Execute commands |
| `builtin_echo` | Builtin | `int` | Echo command |
| `safe_malloc` | Utils | `void *` | Safe allocation |

### Error Codes

| Code | Meaning | Context |
|------|---------|---------|
| `0` | Success | All functions |
| `-1` | General failure | System functions |
| `1` | Command failure | Built-ins, execution |
| `2` | Syntax error | Parser, lexer |
| `126` | Permission denied | Execution |
| `127` | Command not found | Execution |

---

*This API reference provides complete documentation for all public functions in the Minishell project. For implementation details, see the source code and architecture documentation.*
  - `tokens`: Token list to check
- **Returns**: Syntax validation result
- **Location**: `srcs/parser/syntax_check.c`

### Expansion Functions

#### `expand_variables(t_ast_node *node, t_shell *shell)`
- **Purpose**: Expand environment variables in AST
- **Parameters**:
  - `node`: AST node to expand
  - `shell`: Shell context for variable lookup
- **Returns**: Expanded AST node
- **Location**: `srcs/expander/variable_expansion.c`

#### `remove_quotes(char *str)`
- **Purpose**: Remove quotes from string while preserving escapes
- **Parameters**:
  - `str`: String to process
- **Returns**: Processed string
- **Location**: `srcs/expander/quote_removal.c`

### Execution Functions

#### `execute_ast(t_ast_node *ast, t_shell *shell)`
- **Purpose**: Execute AST commands
- **Parameters**:
  - `ast`: AST to execute
  - `shell`: Shell context
- **Returns**: Execution status
- **Location**: `srcs/executor/executor.c`

#### `handle_pipes(t_ast_node *left, t_ast_node *right, t_shell *shell)`
- **Purpose**: Handle pipeline execution
- **Parameters**:
  - `left`: Left side of pipe
  - `right`: Right side of pipe
  - `shell`: Shell context
- **Returns**: Pipeline execution status
- **Location**: `srcs/executor/pipe_handler.c`

### Built-in Functions

#### `builtin_echo(char **args)`
- **Purpose**: Implement echo command
- **Parameters**: 
  - `args`: Command arguments
- **Returns**: Command exit status
- **Location**: `srcs/builtins/builtin_echo.c`

#### `builtin_cd(char **args, t_shell *shell)`
- **Purpose**: Implement cd command
- **Parameters**:
  - `args`: Command arguments
  - `shell`: Shell context for PWD update
- **Returns**: Command exit status
- **Location**: `srcs/builtins/builtin_cd.c`

#### `builtin_pwd(void)`
- **Purpose**: Implement pwd command
- **Returns**: Command exit status
- **Location**: `srcs/builtins/builtin_pwd.c`

#### `builtin_export(char **args, t_shell *shell)`
- **Purpose**: Implement export command
- **Parameters**:
  - `args`: Variable assignments
  - `shell`: Shell context for environment
- **Returns**: Command exit status
- **Location**: `srcs/builtins/builtin_export.c`

#### `builtin_unset(char **args, t_shell *shell)`
- **Purpose**: Implement unset command
- **Parameters**:
  - `args`: Variables to unset
  - `shell`: Shell context
- **Returns**: Command exit status
- **Location**: `srcs/builtins/builtin_unset.c`

#### `builtin_env(t_shell *shell)`
- **Purpose**: Implement env command
- **Parameters**:
  - `shell`: Shell context for environment
- **Returns**: Command exit status
- **Location**: `srcs/builtins/builtin_env.c`

#### `builtin_exit(char **args, t_shell *shell)`
- **Purpose**: Implement exit command
- **Parameters**:
  - `args`: Exit code argument
  - `shell`: Shell context
- **Returns**: Does not return (exits)
- **Location**: `srcs/builtins/builtin_exit.c`

### Signal Functions

#### `setup_signals(void)`
- **Purpose**: Setup signal handlers
- **Location**: `srcs/signals/signal_handler.c`

#### `handle_sigint(int sig)`
- **Purpose**: Handle SIGINT (Ctrl+C)
- **Parameters**:
  - `sig`: Signal number
- **Location**: `srcs/signals/signal_handler.c`

### Redirection Functions

#### `handle_input_redirect(char *filename)`
- **Purpose**: Setup input redirection
- **Parameters**:
  - `filename`: Input file name
- **Returns**: File descriptor
- **Location**: `srcs/redirections/input_redirect.c`

#### `handle_output_redirect(char *filename, int append)`
- **Purpose**: Setup output redirection
- **Parameters**:
  - `filename`: Output file name
  - `append`: Append mode flag
- **Returns**: File descriptor
- **Location**: `srcs/redirections/output_redirect.c`

### Utility Functions

#### `ft_malloc(size_t size)`
- **Purpose**: Safe memory allocation with error checking
- **Parameters**:
  - `size`: Bytes to allocate
- **Returns**: Allocated memory pointer
- **Location**: `srcs/utils/memory_utils.c`

#### `ft_free_array(char **array)`
- **Purpose**: Free array of strings
- **Parameters**:
  - `array`: Array to free
- **Location**: `srcs/utils/memory_utils.c`

#### `ft_strjoin_free(char *s1, char *s2)`
- **Purpose**: Join strings and free originals
- **Parameters**:
  - `s1`: First string
  - `s2`: Second string
- **Returns**: Joined string
- **Location**: `srcs/utils/string_utils.c`

#### `print_error(char *message, char *context)`
- **Purpose**: Print formatted error message
- **Parameters**:
  - `message`: Error message
  - `context`: Error context
- **Location**: `srcs/utils/error_handler.c`

## Constants and Macros

### Token Types
```c
#define TOKEN_WORD          1
#define TOKEN_PIPE          2
#define TOKEN_REDIRECT_IN   3
#define TOKEN_REDIRECT_OUT  4
#define TOKEN_REDIRECT_APPEND 5
#define TOKEN_HEREDOC       6
#define TOKEN_AND           7
#define TOKEN_OR            8
```

### Exit Status Codes
```c
#define SUCCESS             0
#define ERROR               1
#define SYNTAX_ERROR        2
#define COMMAND_NOT_FOUND   127
#define PERMISSION_DENIED   126
```

### Buffer Sizes
```c
#define MAX_PATH_LEN        1024
#define MAX_INPUT_LEN       4096
#define MAX_ARGS            1024
```
