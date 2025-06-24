# API Reference

## Core Functions

### Initialization Functions

#### `init_shell(t_shell *shell, char **envp)`
- **Purpose**: Initialize shell data structure
- **Parameters**: 
  - `shell`: Pointer to shell structure
  - `envp`: Environment variables array
- **Returns**: Success status
- **Location**: `srcs/init/init_shell.c`

#### `init_env(t_shell *shell, char **envp)`
- **Purpose**: Initialize environment variables
- **Parameters**:
  - `shell`: Pointer to shell structure  
  - `envp`: Environment variables array
- **Returns**: Success status
- **Location**: `srcs/init/init_env.c`

### Lexer Functions

#### `tokenize(char *input)`
- **Purpose**: Convert input string into tokens
- **Parameters**: 
  - `input`: Raw command string
- **Returns**: Linked list of tokens
- **Location**: `srcs/lexer/tokenizer.c`

#### `validate_tokens(t_token *tokens)`
- **Purpose**: Validate token sequence for syntax errors
- **Parameters**:
  - `tokens`: Token list to validate
- **Returns**: Validation result
- **Location**: `srcs/lexer/token_validation.c`

### Parser Functions

#### `parse_tokens(t_token *tokens)`
- **Purpose**: Build AST from token list
- **Parameters**:
  - `tokens`: List of tokens to parse
- **Returns**: Root node of AST
- **Location**: `srcs/parser/parser.c`

#### `check_syntax(t_token *tokens)`
- **Purpose**: Perform syntax validation
- **Parameters**:
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
