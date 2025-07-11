#ifndef MINISHELL_DOC_H
# define MINISHELL_DOC_H

/* ************************************************************************** */
/*                           FUNCTION DOCUMENTATION                          */
/* ************************************************************************** */

/*
 * This file contains detailed documentation for all functions declared
 * in minishell.h. Keep minishell.h clean and refer to this file for
 * implementation details and function specifications.
 */

/* ************************************************************************** */
/*                               MAIN FUNCTIONS                              */
/* ************************************************************************** */

/**
 * @brief Main entry point of the minishell program
 * 
 * Initializes the shell, sets up signal handling, and starts the main loop.
 * Handles command line arguments and environment setup.
 * 
 * @param argc Number of command line arguments
 * @param argv Array of command line argument strings
 * @param envp Array of environment variable strings
 * @return EXIT_SUCCESS on normal termination, EXIT_FAILURE on error
 * 
 * @example
 * ./minishell
 * ./minishell -c "echo hello"  // (bonus feature)
 */
int main(int argc, char **argv, char **envp);

/* ************************************************************************** */
/*                          SHELL INITIALIZATION                             */
/* ************************************************************************** */

/**
 * @brief Initialize the shell data structure
 * 
 * Sets up the shell environment by:
 * - Copying environment variables
 * - Initializing shell state variables
 * - Setting up default values
 * - Allocating necessary memory
 * 
 * @param shell Pointer to shell structure to initialize
 * @param envp Array of environment variables from main()
 * @return 0 on success, -1 on failure (memory allocation error)
 * 
 * @note Must be called before any other shell operations
 * @note On failure, no cleanup is needed as allocation failed
 * 
 * @example
 * t_shell shell;
 * if (init_shell(&shell, envp) < 0) {
 *     fprintf(stderr, "Failed to initialize shell\n");
 *     return EXIT_FAILURE;
 * }
 */
int init_shell(t_shell *shell, char **envp);

/**
 * @brief Clean up and free all shell resources
 * 
 * Frees all allocated memory including:
 * - Environment variables copy
 * - Current input string
 * - Any other dynamically allocated data
 * 
 * @param shell Pointer to shell structure to clean up
 * 
 * @note Safe to call multiple times
 * @note Should be called before program termination
 * @note Sets freed pointers to NULL to prevent double-free
 * 
 * @example
 * cleanup_shell(&shell);
 */
void cleanup_shell(t_shell *shell);

/* ************************************************************************** */
/*                             LEXER FUNCTIONS                               */
/* ************************************************************************** */

/**
 * @brief Tokenize input string into linked list of tokens
 * 
 * Parses the input string and creates tokens for:
 * - Words (commands, arguments, filenames)
 * - Operators (|, <, >, <<, >>, &&, ||)
 * - Special characters and quotes
 * 
 * @param input Input string to tokenize (from readline)
 * @return Pointer to first token in linked list, NULL on error
 * 
 * @note Handles quotes, escaping, and whitespace properly
 * @note Returns NULL for empty input or allocation failure
 * @note Caller responsible for freeing with free_tokens()
 * 
 * @example
 * t_token *tokens = tokenize("echo 'hello world' | grep hello");
 * if (!tokens) {
 *     // Handle error
 * }
 */
t_token *tokenize(char *input);

/**
 * @brief Free entire token linked list
 * 
 * Recursively frees all tokens in the list including:
 * - Token value strings
 * - Token structures themselves
 * 
 * @param tokens Pointer to first token in list
 * 
 * @note Safe to call with NULL pointer
 * @note Frees entire chain of tokens
 * 
 * @example
 * free_tokens(tokens);
 * tokens = NULL;  // Good practice
 */
void free_tokens(t_token *tokens);

/* ************************************************************************** */
/*                            PARSER FUNCTIONS                               */
/* ************************************************************************** */

/**
 * @brief Parse tokens into command structure
 * 
 * Converts token list into executable command structure by:
 * - Grouping tokens into commands
 * - Identifying redirections
 * - Building argument arrays
 * - Setting up pipe connections
 * 
 * @param tokens Linked list of tokens from tokenize()
 * @return Pointer to first command, NULL on parse error
 * 
 * @note Handles complex pipelines and redirections
 * @note Validates syntax and reports errors
 * @note Caller responsible for freeing with free_commands()
 * 
 * @example
 * t_cmd *commands = parse_tokens(tokens);
 * if (!commands) {
 *     // Handle parse error
 * }
 */
t_cmd *parse_tokens(t_token *tokens);

/**
 * @brief Free entire command linked list
 * 
 * Recursively frees all commands including:
 * - Argument arrays
 * - File names for redirections
 * - Command structures themselves
 * 
 * @param commands Pointer to first command in list
 * 
 * @note Safe to call with NULL pointer
 * @note Frees entire pipeline chain
 * 
 * @example
 * free_commands(commands);
 * commands = NULL;
 */
void free_commands(t_cmd *commands);

/* ************************************************************************** */
/*                           EXECUTOR FUNCTIONS                              */
/* ************************************************************************** */

/**
 * @brief Execute parsed commands
 * 
 * Executes the command pipeline by:
 * - Setting up pipes between commands
 * - Handling redirections
 * - Forking processes for external commands
 * - Executing built-in commands directly
 * - Managing process cleanup
 * 
 * @param commands Linked list of commands to execute
 * @param shell Shell context for environment and state
 * @return Exit status of last command in pipeline
 * 
 * @note Updates shell->exit_status
 * @note Handles both built-ins and external commands
 * @note Manages pipe setup and cleanup
 * 
 * @example
 * int status = execute_commands(commands, &shell);
 * printf("Last command exited with: %d\n", status);
 */
int execute_commands(t_cmd *commands, t_shell *shell);

/* ************************************************************************** */
/*                           BUILT-IN COMMANDS                               */
/* ************************************************************************** */

/**
 * @brief Execute echo command with options
 * 
 * Implements bash-compatible echo:
 * - Prints arguments separated by spaces
 * - Supports -n flag (no trailing newline)
 * - Handles escape sequences in arguments
 * 
 * @param args Array of arguments (args[0] is "echo")
 * @return 0 on success, 1 on error
 * 
 * @example
 * echo hello world     -> "hello world\n"
 * echo -n hello        -> "hello" (no newline)
 */
int builtin_echo(char **args);

/**
 * @brief Change current directory
 * 
 * Implements bash-compatible cd:
 * - Changes to specified directory
 * - Updates PWD and OLDPWD environment variables
 * - Handles special cases: ~, -, no arguments
 * 
 * @param args Array of arguments (args[0] is "cd")
 * @param shell Shell context for environment access
 * @return 0 on success, 1 on error
 * 
 * @example
 * cd /tmp      -> changes to /tmp
 * cd           -> changes to $HOME
 * cd -         -> changes to $OLDPWD
 */
int builtin_cd(char **args, t_shell *shell);

/**
 * @brief Print current working directory
 * 
 * Prints the absolute path of current directory to stdout.
 * 
 * @return 0 on success, 1 on error
 * 
 * @example
 * pwd -> "/Users/username/project\n"
 */
int builtin_pwd(void);

/**
 * @brief Export environment variables
 * 
 * Implements bash-compatible export:
 * - Sets environment variables
 * - Displays all exported variables when no args
 * - Validates variable names
 * 
 * @param args Array of arguments (args[0] is "export")
 * @param shell Shell context for environment modification
 * @return 0 on success, 1 on error
 * 
 * @example
 * export VAR=value     -> sets VAR to value
 * export              -> lists all exported variables
 */
int builtin_export(char **args, t_shell *shell);

/**
 * @brief Unset environment variables
 * 
 * Removes specified environment variables from shell environment.
 * 
 * @param args Array of arguments (args[0] is "unset")
 * @param shell Shell context for environment modification
 * @return 0 on success, 1 on error
 * 
 * @example
 * unset VAR           -> removes VAR from environment
 * unset VAR1 VAR2     -> removes multiple variables
 */
int builtin_unset(char **args, t_shell *shell);

/**
 * @brief Display environment variables
 * 
 * Prints all environment variables to stdout in "NAME=value" format.
 * 
 * @param shell Shell context for environment access
 * @return 0 on success, 1 on error
 * 
 * @example
 * env -> "PATH=/usr/bin\nHOME=/Users/username\n..."
 */
int builtin_env(t_shell *shell);

/**
 * @brief Exit the shell with optional status code
 * 
 * Terminates the shell with specified exit code:
 * - Validates numeric argument
 * - Sets shell->should_exit flag
 * - Updates exit status
 * 
 * @param args Array of arguments (args[0] is "exit")
 * @param shell Shell context for state modification
 * @return Exit status (0-255)
 * 
 * @example
 * exit         -> exits with status 0
 * exit 42      -> exits with status 42
 * exit abc     -> error: numeric argument required
 */
int builtin_exit(char **args, t_shell *shell);

/* ************************************************************************** */
/*                            SIGNAL HANDLING                                */
/* ************************************************************************** */

/**
 * @brief Set up signal handlers for shell
 * 
 * Configures signal handling for:
 * - SIGINT (Ctrl+C): Display new prompt
 * - SIGQUIT (Ctrl+\): Ignore in interactive mode
 * - Other signals as needed
 * 
 * @note Should be called once during shell initialization
 * @note Behavior differs between interactive and non-interactive mode
 * 
 * @example
 * setup_signals();  // Call once at startup
 */
void setup_signals(void);

/**
 * @brief Handle incoming signals
 * 
 * Signal handler function that responds to:
 * - SIGINT: Print newline and redisplay prompt
 * - SIGQUIT: Ignore or handle based on context
 * 
 * @param signum Signal number received
 * 
 * @note Async-signal-safe implementation required
 * @note Updates global state for signal communication
 * 
 * @example
 * // Automatically called by signal() system
 * // when signals are received
 */
void signal_handler(int signum);

/* ************************************************************************** */
/*                            UTILITY FUNCTIONS                              */
/* ************************************************************************** */

/**
 * @brief Duplicate a string (malloc-based copy)
 * 
 * Creates a new string that is a copy of the source string.
 * 
 * @param s Source string to duplicate
 * @return Pointer to new string, NULL on allocation failure
 * 
 * @note Caller responsible for freeing returned string
 * @note Returns NULL if input is NULL
 * 
 * @example
 * char *copy = ft_strdup("hello");
 * // Use copy...
 * free(copy);
 */
char *ft_strdup(const char *s);

/**
 * @brief Split string by delimiter character
 * 
 * Splits input string into array of strings using delimiter.
 * 
 * @param s String to split
 * @param c Delimiter character
 * @return NULL-terminated array of strings, NULL on error
 * 
 * @note Caller responsible for freeing array and all strings
 * @note Empty strings between delimiters are included
 * 
 * @example
 * char **words = ft_split("a:b:c", ':');
 * // words = {"a", "b", "c", NULL}
 * ft_free_array(words);
 */
char **ft_split(char const *s, char c);

/**
 * @brief Free array of strings
 * 
 * Frees all strings in array and the array itself.
 * 
 * @param array NULL-terminated array of strings
 * 
 * @note Safe to call with NULL pointer
 * @note Frees all non-NULL strings in array
 * 
 * @example
 * ft_free_array(env_copy);
 */
void ft_free_array(char **array);

/**
 * @brief Get environment variable value
 * 
 * Searches for environment variable by name.
 * 
 * @param name Variable name to search for
 * @param env Array of environment strings
 * @return Pointer to value part of variable, NULL if not found
 * 
 * @note Returns pointer into original env array (don't free)
 * @note Case sensitive search
 * 
 * @example
 * char *home = ft_getenv("HOME", shell->env);
 * if (home) printf("Home: %s\n", home);
 */
char *ft_getenv(const char *name, char **env);

/**
 * @brief Set environment variable
 * 
 * Sets or updates environment variable in shell environment.
 * 
 * @param name Variable name
 * @param value Variable value
 * @param env Pointer to environment array (may be reallocated)
 * 
 * @note May reallocate env array - update pointer
 * @note Creates new variable if not exists, updates if exists
 * 
 * @example
 * ft_setenv("NEW_VAR", "value", &shell->env);
 */
void ft_setenv(const char *name, const char *value, char ***env);

/**
 * @brief Compare two strings
 * 
 * Lexicographic comparison of two strings.
 * 
 * @param s1 First string
 * @param s2 Second string
 * @return 0 if equal, <0 if s1<s2, >0 if s1>s2
 * 
 * @example
 * if (ft_strcmp(cmd, "exit") == 0) {
 *     // Handle exit command
 * }
 */
int ft_strcmp(const char *s1, const char *s2);

/**
 * @brief Join two strings with allocation
 * 
 * Creates new string by concatenating s1 and s2.
 * 
 * @param s1 First string
 * @param s2 Second string
 * @return New concatenated string, NULL on error
 * 
 * @note Caller responsible for freeing result
 * @note Returns NULL if either input is NULL
 * 
 * @example
 * char *path = ft_strjoin("/usr/bin/", "ls");
 * // path = "/usr/bin/ls"
 * free(path);
 */
char *ft_strjoin(char const *s1, char const *s2);

/**
 * @brief Calculate string length
 * 
 * Returns number of characters in string (excluding null terminator).
 * 
 * @param s String to measure
 * @return Length of string, 0 if NULL
 * 
 * @example
 * int len = ft_strlen("hello");  // len = 5
 */
int ft_strlen(const char *s);

/* ************************************************************************** */
/*                            IMPLEMENTATION NOTES                           */
/* ************************************************************************** */

/*
 * MEMORY MANAGEMENT:
 * - All functions that allocate memory document who is responsible for freeing
 * - Use consistent error handling: return NULL/negative on allocation failure
 * - Always check return values of allocation functions
 * 
 * ERROR HANDLING:
 * - Functions return consistent error codes (0 success, negative/positive error)
 * - Built-ins follow bash conventions for exit codes
 * - Use perror() or custom error messages for user feedback
 * 
 * SIGNAL SAFETY:
 * - Signal handlers must be async-signal-safe
 * - Use volatile sig_atomic_t for signal communication variables
 * - Minimal work in signal handlers, defer complex operations
 * 
 * BASH COMPATIBILITY:
 * - Match bash behavior for edge cases and error conditions
 * - Follow bash exit codes and error messages where possible
 * - Test against real bash for verification
 */

#endif /* MINISHELL_DOC_H */
