/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minishell.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: anpayot <anpayot@student.42lausanne.ch>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/28 00:00:00 by minishell         #+#    #+#             */
/*   Updated: 2025/08/06 12:38:37 by anpayot          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef MINISHELL_H
# define MINISHELL_H

/* ************************************************************************** */
/*                                  INCLUDES                                  */
/* ************************************************************************** */

# include "minishell_docs.h"
# include <stdio.h>
# include <stdlib.h>
# include <unistd.h>
# include <string.h>
# include <sys/types.h>
# include <sys/wait.h>
# include <sys/stat.h>
# include <fcntl.h>
# include <signal.h>
# include <errno.h>
# include <dirent.h>
# include <termios.h>
# include <readline/readline.h>
# include <readline/history.h>

/* ************************************************************************** */
/*                                 CONSTANTS                                 */
/* ************************************************************************** */

# define PROMPT "minishell$ "
# define MAX_CMD_LEN 1024
# define MAX_ARGS 128
# define MAX_ENV_VARS 1024

/* Exit codes */
# define EXIT_SUCCESS 0
# define EXIT_FAILURE 1
# define EXIT_MISUSE 2
# define EXIT_CANNOT_EXECUTE 126
# define EXIT_COMMAND_NOT_FOUND 127

/* Token types */
# define TOKEN_WORD 1
# define TOKEN_PIPE 2
# define TOKEN_REDIRECT_IN 3
# define TOKEN_REDIRECT_OUT 4
# define TOKEN_REDIRECT_APPEND 5
# define TOKEN_REDIRECT_HEREDOC 6
# define TOKEN_AND 7
# define TOKEN_OR 8
# define TOKEN_EOF 9

/* ************************************************************************** */
/*                                STRUCTURES                                 */
/* ************************************************************************** */

/**
 * @brief Token structure for lexical analysis
 */
typedef struct s_token
{
	int				type;
	char			*value;
	struct s_token	*next;
}	t_token;

/**
 * @brief Command structure
 */
typedef struct s_cmd
{
	char			**args;
	char			*input_file;
	char			*output_file;
	int				append_mode;
	struct s_cmd	*next;
}	t_cmd;

/**
 * @brief Shell data structure
 */
typedef struct s_shell
{
	char	**env;
	int		exit_status;
	int		should_exit;
	char	*input;
}	t_shell;

/* ************************************************************************** */
/*                               FUNCTION PROTOTYPES                         */
/* ************************************************************************** */

/* Main functions */
int		main(int argc, char **argv, char **envp);

/* Shell initialization */
int		init_shell(t_shell *shell, char **envp);
void	cleanup_shell(t_shell *shell);

/* Lexer functions */
t_token	*tokenize(char *input);
void	free_tokens(t_token *tokens);

/* Parser functions */
t_cmd	*parse_tokens(t_token *tokens);
void	free_commands(t_cmd *commands);

/* Executor functions */
int		execute_commands(t_cmd *commands, t_shell *shell);
int		is_builtin(char *cmd);
int		execute_builtin(t_cmd *cmd, t_shell *shell);
int		execute_external(t_cmd *cmd, t_shell *shell);

/* Pipe and redirection functions */
int		setup_pipes(t_cmd *commands);
int		handle_redirections(t_cmd *cmd);
int		redirect_input(char *filename);
int		redirect_output(char *filename, int append);
int		handle_heredoc(char *delimiter);

/* Variable expansion */
char	*expand_variables(char *str, t_shell *shell);
char	*expand_exit_status(char *str, int exit_status);

/* Path resolution */
char	*find_executable(char *cmd, char **env);
char	**get_path_dirs(char **env);

/* Quote handling */
char	*remove_quotes(char *str);
int		count_quotes(char *str, char quote_type);

/* Environment utilities */
int		env_size(char **env);
char	**copy_env(char **env);
char	**add_env_var(char **env, char *var);
char	**remove_env_var(char **env, char *name);

/* String utilities */
char	*ft_strdup(const char *s);
char	**ft_split(char const *s, char c);
void	ft_free_array(char **array);
char	*ft_getenv(const char *name, char **env);
void	ft_setenv(const char *name, const char *value, char ***env);
int		ft_strcmp(const char *s1, const char *s2);
char	*ft_strjoin(char const *s1, char const *s2);
int		ft_strlen(const char *s);
int		ft_isdigit(int c);
int		ft_isalpha(int c);
int		ft_isalnum(int c);
char	*ft_itoa(int n);
int		ft_atoi(const char *str);
char	*ft_strchr(const char *s, int c);
int		ft_strncmp(const char *s1, const char *s2, size_t n);
void	*ft_memcpy(void *dst, const void *src, size_t n);

/* Process management */
pid_t	ft_fork(void);
int		wait_for_children(pid_t *pids, int count);

/* Shell loop functions */
void	shell_loop(t_shell *shell);

/* Error handling */
void	print_error(const char *message);
void	exit_error(const char *message, int exit_code);
void	print_command_error(char *cmd, char *message);
void	print_syntax_error(char *token);

#endif /* MINISHELL_H */
