/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: anpayot <anpayot@student.42lausanne.ch>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/28 00:00:00 by minishell         #+#    #+#             */
/*   Updated: 2025/06/28 17:16:23 by anpayot          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minishell.h"

/**
 * @brief Main entry point for the Minishell program
 * 
 * This is the main function that initializes the shell environment,
 * sets up signal handlers, and starts the main shell loop.
 * 
 * @param argc Argument count
 * @param argv Argument vector
 * @param envp Environment variables
 * @return int Exit status (0 for success, non-zero for error)
 */
int	main(int argc, char **argv, char **envp)
{
	(void)argc;
	(void)argv;
	(void)envp;

	// TODO: Initialize shell environment
	// TODO: Setup signal handlers
	// TODO: Start main shell loop
	
	printf("Minishell - A basic shell implementation\n");
	printf("This is a skeleton implementation.\n");
	printf("To exit, press Ctrl+C\n");
	
	// Simple shell loop for demonstration
	while (1)
	{
		printf("minishell$ ");
		// TODO: Add readline integration
		// TODO: Add command parsing
		// TODO: Add command execution
		sleep(1);
	}
	
	return (0);
}
