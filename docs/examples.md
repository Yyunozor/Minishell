# 💡 Code Examples & Patterns

## 📋 Table of Contents

- [Overview](#overview)
- [Basic Usage Examples](#basic-usage-examples)
- [Advanced Implementation Patterns](#advanced-implementation-patterns)
- [Testing Patterns](#testing-patterns)
- [Best Practices](#best-practices)
- [Common Pitfalls](#common-pitfalls)
- [Performance Optimization](#performance-optimization)
- [Debug Techniques](#debug-techniques)

---

## 🎯 Overview

This document provides practical examples of using Minishell functions, implementing common patterns, and following best practices. Each example includes complete code, explanations, and related concepts.

### 🎯 Learning Goals

- **Understand Core APIs**: How to use each component effectively
- **Master Patterns**: Common implementation and testing patterns
- **Avoid Pitfalls**: Learn from common mistakes
- **Optimize Performance**: Write efficient shell code
- **Debug Effectively**: Techniques for troubleshooting

---

## 🚀 Basic Usage Examples

### 1. Complete Shell Initialization

```c
#include "minishell.h"

int main(int argc, char **argv, char **envp)
{
    t_shell shell;
    int     status;
    
    // Initialize shell with comprehensive error handling
    if (init_shell(&shell, envp) < 0) {
        fprintf(stderr, "minishell: initialization failed\n");
        return (EXIT_FAILURE);
    }
    
    // Setup signal handlers
    if (init_signals() < 0) {
        fprintf(stderr, "minishell: warning: signal setup failed\n");
    }
    
    // Main shell loop
    status = run_shell(&shell);
    
    // Cleanup resources
    cleanup_shell(&shell);
    
    return (status);
}
```

**Key Points:**
- Always check return values for initialization functions
- Setup signals after shell initialization
- Proper cleanup prevents memory leaks
- Return appropriate exit codes

### 2. Tokenization with Error Handling

```c
#include "minishell.h"

int tokenize_input_example(const char *input)
{
    t_token *tokens;
    t_token *current;
    
    // Validate input
    if (!input || !*input) {
        printf("Empty input\n");
        return (0);
    }
    
    // Tokenize input string
    tokens = tokenize(input);
    if (!tokens) {
        fprintf(stderr, "Tokenization failed\n");
        return (-1);
    }
    
    // Validate token sequence
    if (validate_tokens(tokens) < 0) {
        fprintf(stderr, "Syntax error in command\n");
        free_tokens(tokens);
        return (-1);
    }
    
    // Process tokens
    current = tokens;
    while (current) {
        printf("Token: '%s' (Type: %d)\n", 
               current->value, current->type);
        current = current->next;
    }
    
    // Cleanup
    free_tokens(tokens);
    return (0);
}

// Usage example
int main(void)
{
    char *examples[] = {
        "echo \"Hello World\"",
        "ls -la | grep \".c\"",
        "cat < input.txt > output.txt",
        "export VAR=value && echo $VAR",
        NULL
    };
    
    for (int i = 0; examples[i]; i++) {
        printf("\nInput: %s\n", examples[i]);
        tokenize_input_example(examples[i]);
    }
    
    return (0);
}
```

**Output:**
```
Input: echo "Hello World"
Token: 'echo' (Type: 0)
Token: '"Hello World"' (Type: 0)

Input: ls -la | grep ".c"
Token: 'ls' (Type: 0)
Token: '-la' (Type: 0)
Token: '|' (Type: 1)
Token: 'grep' (Type: 0)
Token: '".c"' (Type: 0)
```

### 3. Environment Variable Expansion

```c
#include "minishell.h"

void demo_variable_expansion(t_shell *shell)
{
    char *test_strings[] = {
        "echo $HOME",
        "cd $HOME/Documents",
        "export PATH=$PATH:/new/path",
        "echo \"User: $USER, Home: $HOME\"",
        "echo $UNDEFINED_VAR",
        "echo ${HOME}/subdir",
        NULL
    };
    
    printf("=== Variable Expansion Demo ===\n");
    
    for (int i = 0; test_strings[i]; i++) {
        char *original = test_strings[i];
        char *expanded = expand_variables(shell, original);
        
        printf("Original:  %s\n", original);
        printf("Expanded:  %s\n", expanded ? expanded : "(null)");
        printf("---\n");
        
        if (expanded) {
            free(expanded);
        }
    }
}

// Advanced expansion with error handling
char *safe_expand_variables(t_shell *shell, const char *str)
{
    char *result;
    
    if (!shell || !str) {
        return (NULL);
    }
    
    result = expand_variables(shell, str);
    if (!result) {
        // Fallback: return copy of original string
        result = safe_strdup(str);
    }
    
    return (result);
}
```

### 4. AST Construction and Execution

```c
#include "minishell.h"

int parse_and_execute_example(t_shell *shell, const char *input)
{
    t_token     *tokens;
    t_ast_node  *ast;
    int         status;
    
    // Step 1: Tokenize
    tokens = tokenize(input);
    if (!tokens) {
        fprintf(stderr, "Tokenization failed\n");
        return (-1);
    }
    
    // Step 2: Validate syntax
    if (validate_tokens(tokens) < 0) {
        fprintf(stderr, "Syntax error\n");
        free_tokens(tokens);
        return (-1);
    }
    
    // Step 3: Parse into AST
    ast = parse_tokens(tokens);
    free_tokens(tokens);  // Tokens no longer needed
    
    if (!ast) {
        fprintf(stderr, "Parsing failed\n");
        return (-1);
    }
    
    // Step 4: Execute AST
    status = execute_ast(shell, ast);
    
    // Step 5: Cleanup
    free_ast(ast);
    
    return (status);
}

// Example of AST node creation
t_ast_node *create_simple_command(char **args)
{
    t_ast_node *node;
    
    node = create_ast_node(NODE_COMMAND);
    if (!node) {
        return (NULL);
    }
    
    // Copy arguments
    node->args = copy_string_array(args);
    if (!node->args) {
        free_ast_node(node);
        return (NULL);
    }
    
    return (node);
}
```

---

## 🔧 Advanced Implementation Patterns

### 1. Pipeline Execution Pattern

```c
#include "minishell.h"

// Complete pipeline execution with proper error handling
int execute_pipeline_pattern(t_shell *shell, t_ast_node *pipeline)
{
    t_pipeline_data data;
    int             status;
    
    // Initialize pipeline data
    if (init_pipeline_data(&data, pipeline) < 0) {
        return (-1);
    }
    
    // Setup pipes
    if (setup_pipeline_pipes(&data) < 0) {
        cleanup_pipeline_data(&data);
        return (-1);
    }
    
    // Execute each command in pipeline
    for (int i = 0; i < data.cmd_count; i++) {
        status = execute_pipeline_command(shell, &data, i);
        if (status < 0) {
            cleanup_pipeline_data(&data);
            return (-1);
        }
    }
    
    // Wait for all processes and get final status
    status = wait_pipeline_processes(&data);
    
    // Cleanup
    cleanup_pipeline_data(&data);
    
    return (status);
}

// Pipeline data structure
typedef struct s_pipeline_data {
    t_ast_node  **commands;       // Array of command nodes
    int         cmd_count;        // Number of commands
    int         **pipes;          // Pipe file descriptors
    int         pipe_count;       // Number of pipes
    pid_t       *pids;           // Process IDs
    int         saved_stdin;      // Original stdin
    int         saved_stdout;     // Original stdout
} t_pipeline_data;

// Initialize pipeline data
int init_pipeline_data(t_pipeline_data *data, t_ast_node *pipeline)
{
    // Count commands in pipeline
    data->cmd_count = count_pipeline_commands(pipeline);
    data->pipe_count = data->cmd_count - 1;
    
    // Allocate arrays
    data->commands = malloc(sizeof(t_ast_node *) * data->cmd_count);
    data->pids = malloc(sizeof(pid_t) * data->cmd_count);
    
    if (data->pipe_count > 0) {
        data->pipes = malloc(sizeof(int *) * data->pipe_count);
        for (int i = 0; i < data->pipe_count; i++) {
            data->pipes[i] = malloc(sizeof(int) * 2);
        }
    }
    
    // Save original file descriptors
    data->saved_stdin = dup(STDIN_FILENO);
    data->saved_stdout = dup(STDOUT_FILENO);
    
    // Extract commands from pipeline AST
    extract_pipeline_commands(pipeline, data->commands);
    
    return (0);
}
```

### 2. Memory-Safe String Operations

```c
#include "minishell.h"

// Safe string joining with proper memory management
char *safe_string_join(const char *s1, const char *s2, const char *separator)
{
    char *result;
    size_t len1, len2, sep_len, total_len;
    
    if (!s1 || !s2) {
        return (NULL);
    }
    
    len1 = strlen(s1);
    len2 = strlen(s2);
    sep_len = separator ? strlen(separator) : 0;
    total_len = len1 + len2 + sep_len + 1;
    
    result = safe_malloc(total_len);
    if (!result) {
        return (NULL);
    }
    
    strcpy(result, s1);
    if (separator) {
        strcat(result, separator);
    }
    strcat(result, s2);
    
    return (result);
}

// Dynamic string builder pattern
typedef struct s_string_builder {
    char    *buffer;
    size_t  length;
    size_t  capacity;
} t_string_builder;

t_string_builder *create_string_builder(size_t initial_capacity)
{
    t_string_builder *sb;
    
    sb = safe_malloc(sizeof(t_string_builder));
    if (!sb) {
        return (NULL);
    }
    
    sb->capacity = initial_capacity > 0 ? initial_capacity : 256;
    sb->buffer = safe_malloc(sb->capacity);
    if (!sb->buffer) {
        free(sb);
        return (NULL);
    }
    
    sb->buffer[0] = '\0';
    sb->length = 0;
    
    return (sb);
}

int append_to_string_builder(t_string_builder *sb, const char *str)
{
    size_t str_len = strlen(str);
    size_t new_length = sb->length + str_len;
    
    // Resize buffer if necessary
    if (new_length >= sb->capacity) {
        size_t new_capacity = sb->capacity * 2;
        while (new_capacity <= new_length) {
            new_capacity *= 2;
        }
        
        char *new_buffer = safe_realloc(sb->buffer, new_capacity);
        if (!new_buffer) {
            return (-1);
        }
        
        sb->buffer = new_buffer;
        sb->capacity = new_capacity;
    }
    
    // Append string
    strcat(sb->buffer, str);
    sb->length = new_length;
    
    return (0);
}
```

### 3. Error Recovery Pattern

```c
#include "minishell.h"

// Robust command execution with error recovery
int execute_command_with_recovery(t_shell *shell, t_ast_node *cmd)
{
    t_execution_context ctx;
    int status;
    
    // Save current state
    if (save_execution_context(&ctx, shell) < 0) {
        return (-1);
    }
    
    // Execute command
    status = execute_command(shell, cmd);
    
    // Handle different types of errors
    if (status < 0) {
        switch (errno) {
            case ENOENT:
                fprintf(stderr, "minishell: %s: command not found\n", 
                        cmd->args[0]);
                status = 127;
                break;
            case EACCES:
                fprintf(stderr, "minishell: %s: permission denied\n", 
                        cmd->args[0]);
                status = 126;
                break;
            case ENOMEM:
                fprintf(stderr, "minishell: out of memory\n");
                restore_execution_context(&ctx, shell);
                return (-1);
            default:
                fprintf(stderr, "minishell: execution failed\n");
                status = 1;
                break;
        }
    }
    
    // Update shell state
    shell->exit_status = status;
    
    // Cleanup context
    cleanup_execution_context(&ctx);
    
    return (status);
}

// Execution context for error recovery
typedef struct s_execution_context {
    int     saved_stdin;
    int     saved_stdout;
    int     saved_stderr;
    char    *saved_pwd;
    int     exit_status;
} t_execution_context;
```

---

## 🧪 Testing Patterns

### 1. Unit Test Framework

```c
#include "minishell.h"
#include <assert.h>

// Simple test framework
typedef struct s_test_case {
    const char  *name;
    int         (*test_func)(void);
} t_test_case;

// Test result tracking
typedef struct s_test_results {
    int passed;
    int failed;
    int total;
} t_test_results;

// Test tokenization function
int test_tokenization(void)
{
    t_token *tokens;
    const char *input = "echo hello world";
    
    // Test basic tokenization
    tokens = tokenize(input);
    assert(tokens != NULL);
    assert(strcmp(tokens->value, "echo") == 0);
    assert(tokens->type == TOKEN_WORD);
    
    // Test token count
    int count = count_tokens(tokens);
    assert(count == 3);
    
    free_tokens(tokens);
    
    // Test empty input
    tokens = tokenize("");
    assert(tokens == NULL);
    
    // Test NULL input
    tokens = tokenize(NULL);
    assert(tokens == NULL);
    
    printf("✅ Tokenization tests passed\n");
    return (1);
}

// Test environment variable expansion
int test_variable_expansion(void)
{
    t_shell shell;
    char *result;
    
    // Setup test environment
    char *test_env[] = {"HOME=/home/test", "USER=testuser", NULL};
    init_shell(&shell, test_env);
    
    // Test simple variable expansion
    result = expand_variables(&shell, "echo $HOME");
    assert(result != NULL);
    assert(strcmp(result, "echo /home/test") == 0);
    free(result);
    
    // Test undefined variable
    result = expand_variables(&shell, "echo $UNDEFINED");
    assert(result != NULL);
    assert(strcmp(result, "echo ") == 0);
    free(result);
    
    // Test complex expansion
    result = expand_variables(&shell, "$USER lives in $HOME");
    assert(result != NULL);
    assert(strcmp(result, "testuser lives in /home/test") == 0);
    free(result);
    
    cleanup_shell(&shell);
    
    printf("✅ Variable expansion tests passed\n");
    return (1);
}

// Run test suite
void run_test_suite(t_test_case *tests, size_t count)
{
    t_test_results results = {0, 0, 0};
    
    printf("🧪 Running %zu tests...\n", count);
    
    for (size_t i = 0; i < count; i++) {
        printf("Running %s... ", tests[i].name);
        fflush(stdout);
        
        if (tests[i].test_func()) {
            results.passed++;
            printf("PASS\n");
        } else {
            results.failed++;
            printf("FAIL\n");
        }
        results.total++;
    }
    
    printf("\n📊 Test Results:\n");
    printf("  Passed: %d/%d\n", results.passed, results.total);
    printf("  Failed: %d/%d\n", results.failed, results.total);
    printf("  Success Rate: %.1f%%\n", 
           (double)results.passed / results.total * 100);
}

// Main test runner
int main(void)
{
    t_test_case tests[] = {
        {"Tokenization", test_tokenization},
        {"Variable Expansion", test_variable_expansion},
        {"AST Construction", test_ast_construction},
        {"Command Execution", test_command_execution},
        {"Memory Management", test_memory_management}
    };
    
    run_test_suite(tests, sizeof(tests) / sizeof(tests[0]));
    
    return (0);
}
```

### 2. Integration Testing

```c
#include "minishell.h"

// Integration test: full command processing
int test_full_command_processing(void)
{
    t_shell shell;
    char *test_env[] = {"PATH=/bin:/usr/bin", "HOME=/tmp", NULL};
    int status;
    
    // Initialize shell
    if (init_shell(&shell, test_env) < 0) {
        return (0);
    }
    
    // Test commands
    const char *commands[] = {
        "echo hello",
        "pwd",
        "cd /tmp",
        "export TEST=value",
        "echo $TEST",
        NULL
    };
    
    for (int i = 0; commands[i]; i++) {
        printf("Testing: %s\n", commands[i]);
        status = parse_and_execute_example(&shell, commands[i]);
        if (status < 0) {
            printf("❌ Command failed: %s\n", commands[i]);
            cleanup_shell(&shell);
            return (0);
        }
    }
    
    cleanup_shell(&shell);
    printf("✅ Full command processing tests passed\n");
    return (1);
}

// Performance test
int test_performance(void)
{
    clock_t start, end;
    double cpu_time_used;
    
    start = clock();
    
    // Run many iterations
    for (int i = 0; i < 1000; i++) {
        t_token *tokens = tokenize("echo hello world");
        if (tokens) {
            free_tokens(tokens);
        }
    }
    
    end = clock();
    cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
    
    printf("⏱️  1000 tokenizations took %f seconds\n", cpu_time_used);
    
    // Performance threshold (adjust as needed)
    if (cpu_time_used > 1.0) {
        printf("❌ Performance test failed (too slow)\n");
        return (0);
    }
    
    printf("✅ Performance test passed\n");
    return (1);
}
```

---

## 📋 Best Practices

### 1. Memory Management Best Practices

```c
// Always check malloc return values
char *safe_allocate_and_copy(const char *src)
{
    char *dest;
    size_t len;
    
    if (!src) {
        return (NULL);
    }
    
    len = strlen(src) + 1;
    dest = malloc(len);
    if (!dest) {
        // Log error, don't exit
        fprintf(stderr, "Memory allocation failed\n");
        return (NULL);
    }
    
    memcpy(dest, src, len);
    return (dest);
}

// Use cleanup functions consistently
void cleanup_command_data(t_command_data *data)
{
    if (!data) {
        return;
    }
    
    if (data->args) {
        free_string_array(data->args);
        data->args = NULL;
    }
    
    if (data->input_file) {
        free(data->input_file);
        data->input_file = NULL;
    }
    
    if (data->output_file) {
        free(data->output_file);
        data->output_file = NULL;
    }
    
    // Clear the structure
    memset(data, 0, sizeof(t_command_data));
}

// RAII-style resource management
typedef struct s_resource_guard {
    void (*cleanup_func)(void *);
    void *resource;
} t_resource_guard;

void resource_guard_cleanup(t_resource_guard *guard)
{
    if (guard && guard->resource && guard->cleanup_func) {
        guard->cleanup_func(guard->resource);
        guard->resource = NULL;
    }
}

#define RESOURCE_GUARD(resource, cleanup_func) \
    t_resource_guard guard = {cleanup_func, resource}; \
    __attribute__((cleanup(resource_guard_cleanup)))
```

### 2. Error Handling Best Practices

```c
// Use consistent error codes
#define SUCCESS         0
#define ERROR_GENERAL  -1
#define ERROR_MEMORY   -2
#define ERROR_SYNTAX   -3
#define ERROR_SYSTEM   -4

// Detailed error reporting
typedef struct s_error_info {
    int         code;
    const char  *function;
    const char  *message;
    int         line;
} t_error_info;

int set_last_error(int code, const char *func, const char *msg, int line)
{
    // Store error information for later retrieval
    static t_error_info last_error;
    
    last_error.code = code;
    last_error.function = func;
    last_error.message = msg;
    last_error.line = line;
    
    return (code);
}

#define SET_ERROR(code, msg) \
    set_last_error(code, __func__, msg, __LINE__)

// Example usage
int parse_command_with_error_handling(const char *input, t_ast_node **result)
{
    t_token *tokens;
    
    if (!input) {
        return SET_ERROR(ERROR_GENERAL, "Invalid input");
    }
    
    tokens = tokenize(input);
    if (!tokens) {
        return SET_ERROR(ERROR_SYNTAX, "Tokenization failed");
    }
    
    *result = parse_tokens(tokens);
    free_tokens(tokens);
    
    if (!*result) {
        return SET_ERROR(ERROR_SYNTAX, "Parsing failed");
    }
    
    return (SUCCESS);
}
```

---

## ⚠️ Common Pitfalls

### 1. Memory Leaks

```c
// ❌ WRONG: Memory leak
char *process_input_wrong(const char *input)
{
    t_token *tokens = tokenize(input);
    t_ast_node *ast = parse_tokens(tokens);
    
    // Missing cleanup!
    if (!ast) {
        return NULL;  // tokens leaked
    }
    
    char *result = execute_and_get_output(ast);
    return result;  // ast and tokens leaked
}

// ✅ CORRECT: Proper cleanup
char *process_input_correct(const char *input)
{
    t_token *tokens = NULL;
    t_ast_node *ast = NULL;
    char *result = NULL;
    
    tokens = tokenize(input);
    if (!tokens) {
        goto cleanup;
    }
    
    ast = parse_tokens(tokens);
    if (!ast) {
        goto cleanup;
    }
    
    result = execute_and_get_output(ast);
    
cleanup:
    if (tokens) {
        free_tokens(tokens);
    }
    if (ast) {
        free_ast(ast);
    }
    
    return result;
}
```

### 2. Signal Handling Issues

```c
// ❌ WRONG: Signal handling
void wrong_signal_handler(int sig)
{
    printf("Received signal %d\n", sig);  // Not signal-safe
    exit(1);  // Abrupt exit
}

// ✅ CORRECT: Signal handling
volatile sig_atomic_t g_signal_received = 0;

void correct_signal_handler(int sig)
{
    g_signal_received = sig;  // Signal-safe
}

// Check signal in main loop
int main_loop(t_shell *shell)
{
    while (shell->running) {
        // Check for signals
        if (g_signal_received) {
            handle_signal_gracefully(g_signal_received);
            g_signal_received = 0;
        }
        
        // Normal processing
        process_command(shell);
    }
    
    return (shell->exit_status);
}
```

---

## 🚀 Performance Optimization

### 1. String Operations Optimization

```c
// Efficient string concatenation for multiple strings
char *join_strings_efficient(char **strings, const char *separator)
{
    size_t total_len = 0;
    size_t sep_len = separator ? strlen(separator) : 0;
    size_t count = 0;
    char *result, *ptr;
    
    // Calculate total length in one pass
    for (int i = 0; strings[i]; i++) {
        total_len += strlen(strings[i]);
        if (i > 0) {
            total_len += sep_len;
        }
        count++;
    }
    
    result = malloc(total_len + 1);
    if (!result) {
        return NULL;
    }
    
    // Copy strings efficiently
    ptr = result;
    for (int i = 0; strings[i]; i++) {
        size_t len = strlen(strings[i]);
        memcpy(ptr, strings[i], len);
        ptr += len;
        
        if (i < count - 1 && separator) {
            memcpy(ptr, separator, sep_len);
            ptr += sep_len;
        }
    }
    *ptr = '\0';
    
    return result;
}

// Memory pool for frequent allocations
typedef struct s_memory_pool {
    char    *buffer;
    size_t  size;
    size_t  used;
} t_memory_pool;

t_memory_pool *create_memory_pool(size_t size)
{
    t_memory_pool *pool = malloc(sizeof(t_memory_pool));
    if (!pool) {
        return NULL;
    }
    
    pool->buffer = malloc(size);
    if (!pool->buffer) {
        free(pool);
        return NULL;
    }
    
    pool->size = size;
    pool->used = 0;
    
    return pool;
}

void *pool_alloc(t_memory_pool *pool, size_t size)
{
    if (pool->used + size > pool->size) {
        return NULL;  // Pool exhausted
    }
    
    void *ptr = pool->buffer + pool->used;
    pool->used += size;
    
    return ptr;
}
```

---

## 🔍 Debug Techniques

### 1. Debug Logging

```c
#ifdef DEBUG
#define DEBUG_PRINT(fmt, ...) \
    fprintf(stderr, "[DEBUG] %s:%d: " fmt "\n", __func__, __LINE__, ##__VA_ARGS__)
#else
#define DEBUG_PRINT(fmt, ...)
#endif

// Debug AST printing
void print_ast_debug(t_ast_node *node, int depth)
{
    if (!node) {
        return;
    }
    
    for (int i = 0; i < depth; i++) {
        printf("  ");
    }
    
    printf("Node type: %d\n", node->type);
    
    if (node->args) {
        for (int i = 0; node->args[i]; i++) {
            for (int j = 0; j < depth + 1; j++) {
                printf("  ");
            }
            printf("Arg[%d]: %s\n", i, node->args[i]);
        }
    }
    
    if (node->left) {
        print_ast_debug(node->left, depth + 1);
    }
    if (node->right) {
        print_ast_debug(node->right, depth + 1);
    }
}

// Memory usage tracking
#ifdef DEBUG
static size_t total_allocated = 0;
static int allocation_count = 0;

void *debug_malloc(size_t size, const char *file, int line)
{
    void *ptr = malloc(size);
    if (ptr) {
        total_allocated += size;
        allocation_count++;
        fprintf(stderr, "[MALLOC] %s:%d: %zu bytes (total: %zu)\n", 
                file, line, size, total_allocated);
    }
    return ptr;
}

#define malloc(size) debug_malloc(size, __FILE__, __LINE__)
#endif
```

---

*This comprehensive examples guide demonstrates practical patterns for building a robust, efficient, and maintainable shell implementation.*

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
