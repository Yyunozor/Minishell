# 📚 Référence API

## 🎯 Vue d'ensemble

Ce document présente les fonctions principales du projet Minishell, organisées par module.

## 🚀 Fonctions principales

### Initialisation (`srcs/init/`)

#### `init_shell(t_shell *shell, char **envp)`
- **Rôle** : Initialise la structure du shell
- **Paramètres** : 
  - `shell` : Pointeur vers la structure shell
  - `envp` : Variables d'environnement
- **Retour** : 0 en cas de succès, -1 en cas d'erreur

#### `init_env(t_shell *shell, char **envp)`
- **Rôle** : Copie et initialise l'environnement
- **Paramètres** : 
  - `shell` : Structure shell
  - `envp` : Variables d'environnement système
- **Retour** : 0 en cas de succès, -1 en cas d'erreur

### Lexer (`srcs/lexer/`)

#### `tokenize(char *input)`
- **Rôle** : Transforme l'entrée en tokens
- **Paramètres** : 
  - `input` : Chaîne d'entrée utilisateur
- **Retour** : Liste chaînée de tokens ou NULL

#### `create_token(t_token_type type, char *value)`
- **Rôle** : Crée un nouveau token
- **Paramètres** : 
  - `type` : Type du token
  - `value` : Valeur du token
- **Retour** : Pointeur vers le token créé

#### `free_tokens(t_token *tokens)`
- **Rôle** : Libère une liste de tokens
- **Paramètres** : 
  - `tokens` : Liste de tokens à libérer
- **Retour** : void

### Parser (`srcs/parser/`)

#### `parse(t_token *tokens)`
- **Rôle** : Construit un AST à partir des tokens
- **Paramètres** : 
  - `tokens` : Liste de tokens à parser
- **Retour** : Racine de l'AST ou NULL

#### `create_ast_node(t_node_type type)`
- **Rôle** : Crée un nœud AST
- **Paramètres** : 
  - `type` : Type du nœud
- **Retour** : Pointeur vers le nœud créé

#### `free_ast(t_ast_node *node)`
- **Rôle** : Libère un AST
- **Paramètres** : 
  - `node` : Racine de l'AST à libérer
- **Retour** : void

### Expander (`srcs/expander/`)

#### `expand_variables(t_shell *shell, char *str)`
- **Rôle** : Expanse les variables d'environnement
- **Paramètres** : 
  - `shell` : Structure shell
  - `str` : Chaîne à expander
- **Retour** : Chaîne expansée ou NULL

#### `remove_quotes(char *str)`
- **Rôle** : Supprime les guillemets de protection
- **Paramètres** : 
  - `str` : Chaîne avec guillemets
- **Retour** : Chaîne sans guillemets

### Executor (`srcs/executor/`)

#### `execute_ast(t_shell *shell, t_ast_node *node)`
- **Rôle** : Exécute un AST
- **Paramètres** : 
  - `shell` : Structure shell
  - `node` : Nœud AST à exécuter
- **Retour** : Code de retour de l'exécution

#### `execute_command(t_shell *shell, t_cmd *cmd)`
- **Rôle** : Exécute une commande simple
- **Paramètres** : 
  - `shell` : Structure shell
  - `cmd` : Commande à exécuter
- **Retour** : Code de retour de la commande

#### `execute_pipeline(t_shell *shell, t_cmd *commands)`
- **Rôle** : Exécute un pipeline de commandes
- **Paramètres** : 
  - `shell` : Structure shell
  - `commands` : Liste de commandes
- **Retour** : Code de retour du pipeline

### Builtins (`srcs/builtins/`)

#### `builtin_echo(t_shell *shell, char **args)`
- **Rôle** : Implémente la commande echo
- **Paramètres** : 
  - `shell` : Structure shell
  - `args` : Arguments de la commande
- **Retour** : 0 en cas de succès

#### `builtin_cd(t_shell *shell, char **args)`
- **Rôle** : Implémente la commande cd
- **Paramètres** : 
  - `shell` : Structure shell
  - `args` : Arguments de la commande
- **Retour** : 0 en cas de succès, 1 en cas d'erreur

#### `builtin_pwd(t_shell *shell, char **args)`
- **Rôle** : Implémente la commande pwd
- **Paramètres** : 
  - `shell` : Structure shell
  - `args` : Arguments (ignorés)
- **Retour** : 0 en cas de succès

#### `builtin_export(t_shell *shell, char **args)`
- **Rôle** : Implémente la commande export
- **Paramètres** : 
  - `shell` : Structure shell
  - `args` : Variables à exporter
- **Retour** : 0 en cas de succès

#### `builtin_unset(t_shell *shell, char **args)`
- **Rôle** : Implémente la commande unset
- **Paramètres** : 
  - `shell` : Structure shell
  - `args` : Variables à supprimer
- **Retour** : 0 en cas de succès

#### `builtin_env(t_shell *shell, char **args)`
- **Rôle** : Implémente la commande env
- **Paramètres** : 
  - `shell` : Structure shell
  - `args` : Arguments (ignorés)
- **Retour** : 0 en cas de succès

#### `builtin_exit(t_shell *shell, char **args)`
- **Rôle** : Implémente la commande exit
- **Paramètres** : 
  - `shell` : Structure shell
  - `args` : Code de sortie optionnel
- **Retour** : N/A (termine le shell)

### Signals (`srcs/signals/`)

#### `setup_signals(void)`
- **Rôle** : Configure les gestionnaires de signaux
- **Retour** : 0 en cas de succès, -1 en cas d'erreur

#### `handle_sigint(int sig)`
- **Rôle** : Gestionnaire pour SIGINT (Ctrl+C)
- **Paramètres** : 
  - `sig` : Numéro du signal
- **Retour** : void

### Utils (`srcs/utils/`)

#### `ft_strdup(const char *str)`
- **Rôle** : Duplique une chaîne
- **Paramètres** : 
  - `str` : Chaîne à dupliquer
- **Retour** : Nouvelle chaîne ou NULL

#### `ft_strlen(const char *str)`
- **Rôle** : Calcule la longueur d'une chaîne
- **Paramètres** : 
  - `str` : Chaîne à mesurer
- **Retour** : Longueur de la chaîne

#### `ft_split(char const *s, char c)`
- **Rôle** : Découpe une chaîne selon un délimiteur
- **Paramètres** : 
  - `s` : Chaîne à découper
  - `c` : Délimiteur
- **Retour** : Tableau de chaînes ou NULL

#### `ft_error(const char *msg)`
- **Rôle** : Affiche un message d'erreur
- **Paramètres** : 
  - `msg` : Message d'erreur
- **Retour** : -1 (pour faciliter le retour d'erreur)

#### `cleanup_shell(t_shell *shell)`
- **Rôle** : Nettoie toutes les ressources du shell
- **Paramètres** : 
  - `shell` : Structure shell à nettoyer
- **Retour** : void

## 📊 Structures de données

### `t_shell`
```c
typedef struct s_shell {
    char    **envp;          // Variables d'environnement
    char    *input;          // Entrée utilisateur actuelle
    t_token *tokens;         // Liste des tokens
    t_ast_node *ast;         // Arbre syntaxique
    int     exit_status;     // Code de sortie
    int     running;         // État du shell
} t_shell;
```

### `t_token`
```c
typedef struct s_token {
    t_token_type type;       // Type du token
    char        *value;      // Valeur du token
    struct s_token *next;    // Token suivant
} t_token;
```

### `t_ast_node`
```c
typedef struct s_ast_node {
    t_node_type type;        // Type du nœud
    char        **args;      // Arguments
    char        *input_file; // Fichier d'entrée
    char        *output_file;// Fichier de sortie
    int         append;      // Mode append
    struct s_ast_node *left; // Enfant gauche
    struct s_ast_node *right;// Enfant droit
} t_ast_node;
```

## 🔧 Codes de retour

### Codes de succès
- **0** : Succès
- **1** : Erreur générale
- **2** : Erreur de syntaxe
- **126** : Commande non exécutable
- **127** : Commande non trouvée
- **128+n** : Signal n reçu

### Gestion des erreurs
- Toujours vérifier les valeurs de retour
- Libérer les ressources en cas d'erreur
- Afficher des messages d'erreur explicites
- Maintenir l'état du shell cohérent
