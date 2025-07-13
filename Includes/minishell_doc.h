/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minishell_doc.h                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: anpayot <anpayot@student.42lausanne.ch>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/07/13 00:00:00 by anpayot           #+#    #+#             */
/*   Updated: 2025/07/13 17:21:23 by anpayot          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

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
