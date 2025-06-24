# Code Examples

This page provides practical examples of using Minishell functions and understanding the codebase.

## Basic Usage Examples

### 1. Tokenization Example

```c
#include "minishell.h"

int main()
{
    char *input = "echo \"Hello World\" | grep Hello";
    t_token *tokens;
    
    // Tokenize the input
    tokens = tokenize(input);
    
    // Process tokens
    while (tokens)
    {
        printf("Token: %s, Type: %d\n", tokens->value, tokens->type);
        tokens = tokens->next;
    }
    
    return 0;
}
```

### 2. Environment Variable Example

```c
#include "minishell.h"

void demo_env_expansion()
{
    t_shell shell;
    char *input = "echo $HOME";
    
    // Initialize shell
    init_shell(&shell, environ);
    
    // Expand variables
    char *expanded = expand_variables(input, &shell);
    printf("Expanded: %s\n", expanded);
    
    free(expanded);
}
```

### 3. Built-in Command Example

```c
#include "minishell.h"

int execute_builtin_example()
{
    char *args[] = {"echo", "-n", "Hello", "World", NULL};
    
    // Execute echo built-in
    int status = builtin_echo(args);
    
    return status;
}
```

## Advanced Examples

### 4. Pipeline Execution

```c
#include "minishell.h"

void demo_pipeline()
{
    t_shell shell;
    t_ast_node *left, *right;
    
    // Create AST nodes for "ls | grep .c"
    left = create_command_node("ls");
    right = create_command_node("grep", ".c");
    
    // Execute pipeline
    handle_pipes(left, right, &shell);
}
```

### 5. Signal Handling Setup

```c
#include "minishell.h"

void setup_shell_signals()
{
    // Setup signal handlers
    setup_signals();
    
    printf("Signal handlers configured\n");
    printf("Press Ctrl+C to test SIGINT handling\n");
}
```

### 6. Memory Management Pattern

```c
#include "minishell.h"

void safe_memory_example()
{
    char **args = NULL;
    t_token *tokens = NULL;
    
    // Safe allocation
    args = ft_malloc(sizeof(char*) * 10);
    if (!args)
    {
        print_error("malloc failed", "args allocation");
        return;
    }
    
    // Use the allocated memory
    args[0] = ft_strdup("command");
    args[1] = NULL;
    
    // Clean up
    ft_free_array(args);
    free_tokens(tokens);
}
```

## Error Handling Examples

### 7. Proper Error Handling

```c
#include "minishell.h"

int robust_function_example(char *input)
{
    t_token *tokens = NULL;
    t_ast_node *ast = NULL;
    int result = SUCCESS;
    
    // Validate input
    if (!input || !*input)
    {
        print_error("invalid input", "empty string");
        return ERROR;
    }
    
    // Tokenize with error checking
    tokens = tokenize(input);
    if (!tokens)
    {
        print_error("tokenization failed", input);
        return ERROR;
    }
    
    // Parse with cleanup on failure
    ast = parse_tokens(tokens);
    if (!ast)
    {
        print_error("parsing failed", "syntax error");
        free_tokens(tokens);
        return SYNTAX_ERROR;
    }
    
    // Execute and cleanup
    result = execute_ast(ast, &g_shell);
    
    // Always cleanup
    free_tokens(tokens);
    free_ast(ast);
    
    return result;
}
```

### 8. File Descriptor Management

```c
#include "minishell.h"

int redirection_example(char *filename)
{
    int fd = -1;
    int saved_stdout = -1;
    
    // Save original stdout
    saved_stdout = dup(STDOUT_FILENO);
    if (saved_stdout == -1)
    {
        perror("dup");
        return ERROR;
    }
    
    // Open output file
    fd = handle_output_redirect(filename, 0);
    if (fd == -1)
    {
        close(saved_stdout);
        return ERROR;
    }
    
    // Use redirection
    printf("This goes to file\n");
    
    // Restore stdout
    dup2(saved_stdout, STDOUT_FILENO);
    close(saved_stdout);
    close(fd);
    
    return SUCCESS;
}
```

## Testing Examples

### 9. Unit Test Example

```c
#include "minishell.h"
#include <assert.h>

void test_tokenizer()
{
    t_token *tokens;
    
    // Test simple command
    tokens = tokenize("echo hello");
    assert(tokens != NULL);
    assert(strcmp(tokens->value, "echo") == 0);
    assert(tokens->type == TOKEN_WORD);
    
    // Test pipe
    free_tokens(tokens);
    tokens = tokenize("ls | grep test");
    
    // Count tokens
    int count = 0;
    t_token *current = tokens;
    while (current)
    {
        count++;
        current = current->next;
    }
    assert(count == 4); // ls, |, grep, test
    
    free_tokens(tokens);
    printf("✓ Tokenizer tests passed\n");
}
```

### 10. Integration Test Example

```c
#include "minishell.h"

int integration_test()
{
    t_shell shell;
    char *test_commands[] = {
        "echo test",
        "pwd",
        "export TEST_VAR=value",
        "echo $TEST_VAR",
        NULL
    };
    
    init_shell(&shell, environ);
    
    for (int i = 0; test_commands[i]; i++)
    {
        printf("Testing: %s\n", test_commands[i]);
        
        t_token *tokens = tokenize(test_commands[i]);
        t_ast_node *ast = parse_tokens(tokens);
        int result = execute_ast(ast, &shell);
        
        printf("Result: %d\n", result);
        
        free_tokens(tokens);
        free_ast(ast);
    }
    
    cleanup_shell(&shell);
    return SUCCESS;
}
```

## Best Practices

### Memory Management
- Always check malloc return values
- Free memory in reverse order of allocation
- Use cleanup functions for complex structures
- Set pointers to NULL after freeing

### Error Handling
- Check all system call return values
- Provide meaningful error messages
- Clean up resources on error paths
- Use consistent error codes

### Code Organization
- Keep functions under 25 lines (42 Norm)
- Use descriptive variable names
- Separate concerns into different modules
- Document complex algorithms

### Testing
- Write unit tests for individual functions
- Test edge cases and error conditions
- Use integration tests for workflows
- Validate with external tools (valgrind, etc.)
