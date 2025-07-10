# 💡 Exemples d'utilisation

## 🎯 Exemples de base

### Commandes simples
```bash
minishell$ echo "Hello World"
Hello World

minishell$ pwd
/Users/username/minishell

minishell$ ls -la
total 128
drwxr-xr-x  15 user  staff    480 Nov 15 10:30 .
drwxr-xr-x   3 user  staff     96 Nov 15 10:20 ..
-rw-r--r--   1 user  staff   1024 Nov 15 10:30 Makefile
-rwxr-xr-x   1 user  staff  50432 Nov 15 10:30 minishell
```

### Variables d'environnement
```bash
minishell$ export MY_VAR="Hello 42"
minishell$ echo $MY_VAR
Hello 42

minishell$ echo $HOME
/Users/username

minishell$ export PATH="/usr/local/bin:$PATH"
minishell$ echo $PATH
/usr/local/bin:/usr/bin:/bin
```

### Redirections
```bash
# Redirection de sortie
minishell$ echo "Hello" > output.txt
minishell$ cat output.txt
Hello

# Redirection d'entrée
minishell$ sort < names.txt

# Redirection en append
minishell$ echo "World" >> output.txt
minishell$ cat output.txt
Hello
World
```

### Pipes
```bash
# Pipe simple
minishell$ ls -la | grep minishell
-rwxr-xr-x  1 user  staff  50432 Nov 15 10:30 minishell

# Pipe multiple
minishell$ ls -la | grep ".c" | wc -l
15

# Pipe avec redirection
minishell$ ls | grep ".txt" > text_files.txt
```

## 🏗️ Exemples d'implémentation

### Initialisation du shell
```c
#include "minishell.h"

int main(int argc, char **argv, char **envp)
{
    t_shell shell;
    
    // Initialisation
    if (init_shell(&shell, envp) < 0)
        return (EXIT_FAILURE);
    
    // Boucle principale
    while (shell.running)
    {
        shell.input = readline("minishell$ ");
        if (!shell.input)
            break;
        
        add_history(shell.input);
        process_input(&shell);
        free(shell.input);
    }
    
    cleanup_shell(&shell);
    return (shell.exit_status);
}
```

### Gestion des tokens
```c
t_token *create_token(t_token_type type, char *value)
{
    t_token *token;
    
    token = malloc(sizeof(t_token));
    if (!token)
        return (NULL);
    
    token->type = type;
    token->value = ft_strdup(value);
    if (!token->value)
    {
        free(token);
        return (NULL);
    }
    
    token->next = NULL;
    return (token);
}

void free_tokens(t_token *tokens)
{
    t_token *tmp;
    
    while (tokens)
    {
        tmp = tokens;
        tokens = tokens->next;
        free(tmp->value);
        free(tmp);
    }
}
```

### Exécution de commandes
```c
int execute_command(t_shell *shell, t_cmd *cmd)
{
    pid_t pid;
    int status;
    
    // Vérifier si c'est une commande intégrée
    if (is_builtin(cmd->args[0]))
        return (execute_builtin(shell, cmd));
    
    // Exécuter commande externe
    pid = fork();
    if (pid == 0)
    {
        // Processus enfant
        setup_redirections(cmd);
        execve(get_command_path(cmd->args[0]), cmd->args, shell->envp);
        exit(127); // Commande non trouvée
    }
    else if (pid > 0)
    {
        // Processus parent
        waitpid(pid, &status, 0);
        return (WEXITSTATUS(status));
    }
    
    return (-1); // Erreur fork
}
```

### Gestion des pipes
```c
int execute_pipeline(t_shell *shell, t_cmd *commands)
{
    int pipefd[2];
    pid_t pid;
    int prev_fd = -1;
    
    while (commands)
    {
        if (commands->next)
        {
            if (pipe(pipefd) == -1)
                return (-1);
        }
        
        pid = fork();
        if (pid == 0)
        {
            // Processus enfant
            if (prev_fd != -1)
            {
                dup2(prev_fd, STDIN_FILENO);
                close(prev_fd);
            }
            
            if (commands->next)
            {
                dup2(pipefd[1], STDOUT_FILENO);
                close(pipefd[0]);
                close(pipefd[1]);
            }
            
            execute_command(shell, commands);
            exit(0);
        }
        
        if (prev_fd != -1)
            close(prev_fd);
        
        if (commands->next)
        {
            close(pipefd[1]);
            prev_fd = pipefd[0];
        }
        
        commands = commands->next;
    }
    
    return (0);
}
```

## 🔧 Bonnes pratiques

### Gestion mémoire
```c
// Toujours vérifier malloc
char *safe_strdup(const char *str)
{
    char *dup;
    
    if (!str)
        return (NULL);
    
    dup = ft_strdup(str);
    if (!dup)
        ft_error("malloc failed");
    
    return (dup);
}

// Nettoyage systématique
void cleanup_shell(t_shell *shell)
{
    if (shell->tokens)
        free_tokens(shell->tokens);
    if (shell->ast)
        free_ast(shell->ast);
    if (shell->envp)
        free_env(shell->envp);
    if (shell->input)
        free(shell->input);
}
```

### Gestion d'erreurs
```c
int ft_error(const char *msg)
{
    ft_putstr_fd("minishell: ", STDERR_FILENO);
    ft_putstr_fd(msg, STDERR_FILENO);
    ft_putstr_fd("\n", STDERR_FILENO);
    return (-1);
}

// Utilisation
if (!(data = malloc(sizeof(t_data))))
    return (ft_error("malloc failed"));
```

### Tests unitaires
```c
// Test de tokenisation
void test_tokenizer(void)
{
    t_token *tokens;
    
    tokens = tokenize("echo 'hello world'");
    assert(tokens != NULL);
    assert(tokens->type == TOKEN_WORD);
    assert(strcmp(tokens->value, "echo") == 0);
    assert(tokens->next->type == TOKEN_WORD);
    assert(strcmp(tokens->next->value, "hello world") == 0);
    
    free_tokens(tokens);
    printf("✅ Test tokenizer: PASSED\n");
}
```

## 🚀 Cas d'usage avancés

### Commandes avec bonus
```bash
# Substitution de commande
minishell$ echo "Date: $(date)"
Date: Wed Nov 15 10:30:45 CET 2023

# Opérateurs logiques
minishell$ true && echo "Success"
Success

minishell$ false || echo "Failed"
Failed

# Wildcards
minishell$ echo *.c
main.c parser.c lexer.c

# Here-document
minishell$ cat << EOF
> Hello
> World
> EOF
Hello
World
```

### Cas d'erreur
```bash
# Commande non trouvée
minishell$ nonexistent_command
minishell: nonexistent_command: command not found

# Erreur de syntaxe
minishell$ echo |
minishell: syntax error near unexpected token `|'

# Redirection vers fichier inaccessible
minishell$ echo "test" > /root/file
minishell: /root/file: Permission denied
```
