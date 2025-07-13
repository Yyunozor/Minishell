/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: anpayot <anpayot@student.42lausanne.ch>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/28 00:00:00 by minishell         #+#    #+#             */
/*   Updated: 2025/07/13 17:21:23 by anpayot          ###   ########.fr       */
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
	printf("Minishell - A basic shell implementation\n");
	printf("This is a skeleton implementation.\n");
	printf("To exit, press Ctrl+C\n");
	while (1)
	{
		printf("minishell$ ");
		sleep(1);
	}
	return (0);
}
