#ifndef MINISHELL_DOC_H
# define MINISHELL_DOC_H

# include <stddef.h>

/* ************************************************************************** */
/*                           FUNCTION DOCUMENTATION                          */
/* ************************************************************************** */

/*
 * This file contains detailed documentation for all functions declared
 * in minishell.h. Keep minishell.h clean and refer to this file for
 * implementation details and function specifications.
 */

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

/* ************************************************************************** */
/*                           STRING UTILITY FUNCTIONS                        */
/* ************************************************************************** */

/**
 * @defgroup str_utils String Utility Functions
 * @brief Basic string manipulation and utility functions
 * @{
 */

/**
 * @brief Outputs a string to standard output
 * @param str The string to output (null-terminated)
 * @return void
 * @note Does nothing if str is NULL
 * @note Uses write() system call for output
 * @warning No bounds checking - assumes str is null-terminated
 * @see ft_putchar, ft_putendl
 * @since 1.0
 * @author anpayot
 */
void ft_putstr(char *str);

/**
 * @brief Calculates the length of a string
 * @param str The string to measure (null-terminated)
 * @return The length of the string in bytes
 * @retval 0 If str is NULL
 * @note Does not count the null terminator
 * @note Time complexity: O(n) where n is the length of the string
 * @warning Function behavior is undefined if str is not null-terminated
 * @see strlen(3)
 * @since 1.0
 * @author anpayot
 */
size_t ft_strlen(const char *str);

/**
 * @brief Creates a duplicate of a string
 * @param str The string to duplicate (null-terminated)
 * @return A pointer to the newly allocated duplicate string
 * @retval NULL If str is NULL or memory allocation fails
 * @note The caller is responsible for freeing the returned string
 * @note Uses malloc() for memory allocation
 * @note Time complexity: O(n) where n is the length of the string
 * @warning Memory allocation failure returns NULL
 * @warning Caller must free the returned pointer to avoid memory leaks
 * @see ft_strlen, malloc(3), free(3), strdup(3)
 * @since 1.0
 * @author anpayot
 */
char *ft_strdup(const char *str);

/**
 * @brief Concatenates two strings into a new string
 * @param s1 The first string to concatenate
 * @param s2 The second string to concatenate  
 * @return A pointer to the newly allocated concatenated string
 * @retval NULL If either parameter is NULL or memory allocation fails
 * @note The caller is responsible for freeing the returned string
 * @note Result string is null-terminated
 * @note Time complexity: O(n+m) where n and m are the lengths of s1 and s2
 * @warning Memory allocation failure returns NULL
 * @warning Caller must free the returned pointer to avoid memory leaks
 * @see ft_strlen, malloc(3), free(3), strcat(3)
 * @since 1.0
 * @author anpayot
 */
char *ft_strjoin(char const *s1, char const *s2);

/** @} */ // end of str_utils group

#endif /* MINISHELL_DOC_H */
