# 📋 Base de données Notion - Projet Minishell

## 🎯 Tableaux de tâches adaptés à notre documentation

### 📊 Format CSV pour import Notion

```csv
Name,Epic,Sprint,Description,Estimate (h),Dependencies,Priority,Assignee,Status,Due Date,Module,Files Affected
"Setup projet & infrastructure",Setup,Week 1,"Initialiser le dépôt Git, configurer .gitignore, créer structure projet selon notre architecture",4,,High,,To Do,2025-07-11,Core,"Makefile, .gitignore, structure folders"
"Créer headers & structures",Setup,Week 1,"Définir minishell.h avec toutes les structures (t_shell, t_token, t_ast_node) selon architecture.md",6,,High,,To Do,2025-07-12,Core,"includes/minishell.h"
"Implémenter libft de base",Setup,Week 1,"Créer fonctions utilitaires : ft_strlen, ft_strdup, ft_split, ft_strjoin, ft_putstr_fd",8,,High,,To Do,2025-07-13,Utils,"srcs/utils/*.c"
"Setup CI & tests",Setup,Week 1,"Configurer GitHub Actions pour build + norminette, créer structure tests/",4,Setup projet,Medium,,To Do,2025-07-14,Testing,"tests/, .github/"

"Implémenter init_shell()",Init,Week 2,"Créer fonction d'initialisation du shell avec copie environnement selon api_reference.md",6,Headers créés,High,,To Do,2025-07-18,Init,"srcs/init/init_shell.c"
"Implémenter init_env()",Init,Week 2,"Copier et initialiser variables d'environnement, gérer PATH",4,init_shell,High,,To Do,2025-07-19,Init,"srcs/init/init_env.c"
"Boucle principale main()",Init,Week 2,"Implémenter boucle readline + process_input + cleanup selon examples.md",8,init_env,High,,To Do,2025-07-20,Core,"srcs/main.c"
"Gestion signaux basique",Init,Week 2,"Implémenter SIGINT/SIGQUIT handlers pour boucle principale",6,Boucle main,High,,To Do,2025-07-21,Signals,"srcs/signals/signal_handler.c"

"Tokenizer de base",Lexer,Week 3,"Implémenter tokenize() qui split sur espaces/opérateurs selon architecture.md",8,Boucle main,High,,To Do,2025-07-25,Lexer,"srcs/lexer/tokenizer.c"
"Structures token",Lexer,Week 3,"Créer create_token(), free_tokens(), classify_token() selon api_reference.md",6,Tokenizer,High,,To Do,2025-07-26,Lexer,"srcs/lexer/token_utils.c"
"Validation syntaxique",Lexer,Week 3,"Implémenter validation des tokens pour détecter erreurs syntaxe",4,Structures token,Medium,,To Do,2025-07-27,Lexer,"srcs/lexer/token_validation.c"
"Tests lexer",Lexer,Week 3,"Créer tests unitaires pour tokenisation selon examples.md",4,Validation syntaxique,Medium,,To Do,2025-07-28,Testing,"tests/unit_tests/test_lexer.c"

"Parser core",Parser,Week 4,"Implémenter parse() qui construit AST depuis tokens selon architecture.md",10,Tests lexer,High,,To Do,2025-08-01,Parser,"srcs/parser/parser.c"
"AST builder",Parser,Week 4,"Créer create_ast_node(), free_ast() selon api_reference.md",6,Parser core,High,,To Do,2025-08-02,Parser,"srcs/parser/ast_builder.c"
"Syntax checker",Parser,Week 4,"Implémenter vérification syntaxe avancée (pipes, redirections)",6,AST builder,High,,To Do,2025-08-03,Parser,"srcs/parser/syntax_check.c"
"Intégration lexer→parser",Parser,Week 4,"Connecter tokenizer au parser dans process_input()",4,Syntax checker,High,,To Do,2025-08-04,Core,"srcs/main.c"
"Tests parser",Parser,Week 4,"Tests unitaires pour parsing selon examples.md",4,Intégration,Medium,,To Do,2025-08-05,Testing,"tests/unit_tests/test_parser.c"

"Expansion variables",Expander,Week 5,"Implémenter expand_variables() pour $VAR selon api_reference.md",8,Tests parser,High,,To Do,2025-08-08,Expander,"srcs/expander/variable_expansion.c"
"Gestion quotes",Expander,Week 5,"Implémenter remove_quotes() pour guillemets simples/doubles",6,Expansion variables,High,,To Do,2025-08-09,Expander,"srcs/expander/quote_removal.c"
"Expansion wildcards",Expander,Week 5,"Implémenter expand_wildcards() pour pattern * (bonus)",8,Gestion quotes,Low,,To Do,2025-08-10,Expander,"srcs/expander/wildcard_expansion.c"
"Intégration expander",Expander,Week 5,"Connecter expander avant exécution dans executor",4,Expansion de base,High,,To Do,2025-08-11,Core,"srcs/executor/executor.c"
"Tests expander",Expander,Week 5,"Tests pour expansion selon examples.md",4,Intégration expander,Medium,,To Do,2025-08-12,Testing,"tests/unit_tests/test_expander.c"

"Executor de base",Executor,Week 6,"Implémenter execute_command() avec fork/execve selon api_reference.md",10,Tests expander,High,,To Do,2025-08-15,Executor,"srcs/executor/executor.c"
"Gestion PATH",Executor,Week 6,"Implémenter get_command_path() pour résolution binaires",6,Executor de base,High,,To Do,2025-08-16,Executor,"srcs/executor/path_resolver.c"
"Process manager",Executor,Week 6,"Implémenter wait_processes(), gestion codes retour",6,Gestion PATH,High,,To Do,2025-08-17,Executor,"srcs/executor/process_manager.c"
"Pipeline executor",Executor,Week 6,"Implémenter execute_pipeline() avec pipes selon examples.md",12,Process manager,High,,To Do,2025-08-18,Executor,"srcs/executor/pipe_handler.c"
"Tests executor",Executor,Week 6,"Tests exécution commandes simples et pipes",6,Pipeline executor,Medium,,To Do,2025-08-19,Testing,"tests/unit_tests/test_executor.c"

"Built-in echo",Builtins,Week 7,"Implémenter builtin_echo() avec option -n selon api_reference.md",4,Tests executor,High,,To Do,2025-08-22,Builtins,"srcs/builtins/builtin_echo.c"
"Built-in cd",Builtins,Week 7,"Implémenter builtin_cd() avec gestion PWD/OLDPWD",6,builtin_echo,High,,To Do,2025-08-23,Builtins,"srcs/builtins/builtin_cd.c"
"Built-in pwd",Builtins,Week 7,"Implémenter builtin_pwd() simple",2,builtin_cd,High,,To Do,2025-08-24,Builtins,"srcs/builtins/builtin_pwd.c"
"Built-in export",Builtins,Week 7,"Implémenter builtin_export() avec validation variables",6,builtin_pwd,High,,To Do,2025-08-25,Builtins,"srcs/builtins/builtin_export.c"
"Built-in unset",Builtins,Week 7,"Implémenter builtin_unset() pour supprimer variables",4,builtin_export,High,,To Do,2025-08-26,Builtins,"srcs/builtins/builtin_unset.c"
"Built-in env",Builtins,Week 7,"Implémenter builtin_env() pour afficher environnement",2,builtin_unset,High,,To Do,2025-08-27,Builtins,"srcs/builtins/builtin_env.c"
"Built-in exit",Builtins,Week 7,"Implémenter builtin_exit() avec code retour",4,builtin_env,High,,To Do,2025-08-28,Builtins,"srcs/builtins/builtin_exit.c"
"Dispatcher builtins",Builtins,Week 7,"Créer is_builtin(), execute_builtin() selon architecture.md",4,Tous builtins,High,,To Do,2025-08-29,Builtins,"srcs/builtins/builtin_dispatcher.c"
"Tests builtins",Builtins,Week 7,"Tests unitaires pour tous les builtins",6,Dispatcher,Medium,,To Do,2025-08-30,Testing,"tests/unit_tests/test_builtins.c"

"Redirection input (<)",Redirections,Week 8,"Implémenter redirection stdin depuis fichier",6,Tests builtins,High,,To Do,2025-09-05,Redirections,"srcs/redirections/input_redirect.c"
"Redirection output (>)",Redirections,Week 8,"Implémenter redirection stdout vers fichier",6,Redirection input,High,,To Do,2025-09-06,Redirections,"srcs/redirections/output_redirect.c"
"Redirection append (>>)",Redirections,Week 8,"Implémenter redirection append vers fichier",4,Redirection output,High,,To Do,2025-09-07,Redirections,"srcs/redirections/append_redirect.c"
"Here-document (<<)",Redirections,Week 8,"Implémenter here-document avec délimiteur",8,Redirection append,High,,To Do,2025-09-08,Redirections,"srcs/redirections/heredoc.c"
"Intégration redirections",Redirections,Week 8,"Connecter redirections à l'executor",4,Here-document,High,,To Do,2025-09-09,Redirections,"srcs/executor/redirect_handler.c"
"Tests redirections",Redirections,Week 8,"Tests pour toutes les redirections selon examples.md",6,Intégration,Medium,,To Do,2025-09-10,Testing,"tests/unit_tests/test_redirections.c"

"Gestion signaux complète",Signals,Week 9,"Implémenter gestion complète SIGINT/SIGQUIT selon faq.md",6,Tests redirections,High,,To Do,2025-09-12,Signals,"srcs/signals/signal_handler.c"
"Signal setup",Signals,Week 9,"Créer setup_signals(), restore_signals()",4,Gestion signaux,High,,To Do,2025-09-13,Signals,"srcs/signals/signal_utils.c"
"Tests signaux",Signals,Week 9,"Tests interruption Ctrl+C, Ctrl+\\ selon examples.md",4,Signal setup,Medium,,To Do,2025-09-14,Testing,"tests/unit_tests/test_signals.c"

"Opérateurs logiques (&&, ||)",Bonus,Week 10,"Implémenter && et || selon examples.md (bonus)",8,Tests signaux,Low,,To Do,2025-09-19,Bonus,"srcs/bonus/logical_operators.c"
"Command substitution",Bonus,Week 10,"Implémenter $(command) et `command` (bonus)",10,Opérateurs logiques,Low,,To Do,2025-09-21,Bonus,"srcs/bonus/command_substitution.c"
"Wildcards globbing",Bonus,Week 10,"Implémenter globbing * avec opendir/readdir (bonus)",8,Command substitution,Low,,To Do,2025-09-23,Bonus,"srcs/bonus/wildcards.c"

"Audit mémoire global",Quality,Week 11,"Valgrind sur toute la suite de tests, corriger fuites",8,Fonctionnalités core,High,,To Do,2025-09-26,Quality,"Tous fichiers"
"Tests d'intégration",Quality,Week 11,"Tests comparaison avec bash selon examples.md",6,Audit mémoire,High,,To Do,2025-09-27,Testing,"tests/integration_tests/"
"Norme 42 complète",Quality,Week 11,"Vérification norminette sur tout le projet",4,Tests intégration,High,,To Do,2025-09-28,Quality,"Tous fichiers"
"Documentation finale",Quality,Week 11,"Compléter README, vérifier cohérence docs/",4,Norme 42,Medium,,To Do,2025-09-29,Docs,"README.md, docs/"
"Tests edge cases",Quality,Week 11,"Tests cas limites selon faq.md",6,Documentation,Medium,,To Do,2025-09-30,Testing,"tests/"
```

## 🎯 Épiques et modules

### 📋 Épiques principales
1. **Setup** - Infrastructure et configuration
2. **Init** - Initialisation du shell
3. **Lexer** - Analyse lexicale
4. **Parser** - Analyse syntaxique
5. **Expander** - Expansion des variables
6. **Executor** - Exécution des commandes
7. **Builtins** - Commandes intégrées
8. **Redirections** - Gestion I/O
9. **Signals** - Gestion des signaux
10. **Bonus** - Fonctionnalités bonus
11. **Quality** - Qualité et tests

### 🏗️ Modules (selon notre architecture)
- **Core** - Fonctions principales
- **Init** - Initialisation
- **Lexer** - Analyse lexicale
- **Parser** - Analyse syntaxique
- **Expander** - Expansion
- **Executor** - Exécution
- **Builtins** - Commandes intégrées
- **Redirections** - Redirections I/O
- **Signals** - Gestion signaux
- **Utils** - Utilitaires
- **Bonus** - Fonctionnalités bonus
- **Testing** - Tests
- **Quality** - Qualité code
- **Docs** - Documentation

## 📊 Répartition des tâches recommandée

### 👥 Équipe de 3 personnes

**Personne 1 - Core & Executor**
- Setup projet & infrastructure
- Init du shell
- Executor principal
- Gestion processus et PATH

**Personne 2 - Parsing & Expansion**
- Lexer complet
- Parser et AST
- Expander et variables
- Gestion quotes

**Personne 3 - Builtins & I/O**
- Tous les builtins
- Redirections complètes
- Signaux
- Tests et qualité

## 🔧 Import dans Notion

### 📥 Procédure d'import

1. **Créer la base de données**
   - Nouveau → Database → Table
   - Nom : "Minishell - Tâches"

2. **Importer le CSV**
   - Copier le CSV complet ci-dessus
   - Import → CSV → Coller le contenu

3. **Configurer les types de colonnes**
   - `Name` : Title
   - `Epic` : Select (Setup, Init, Lexer, Parser, Expander, Executor, Builtins, Redirections, Signals, Bonus, Quality)
   - `Sprint` : Select (Week 1, Week 2, ..., Week 11)
   - `Description` : Text
   - `Estimate (h)` : Number
   - `Dependencies` : Relation (auto-reference)
   - `Priority` : Select (High, Medium, Low)
   - `Assignee` : Person
   - `Status` : Select (To Do, In Progress, Review, Done)
   - `Due Date` : Date
   - `Module` : Select (Core, Init, Lexer, Parser, Expander, Executor, Builtins, Redirections, Signals, Utils, Bonus, Testing, Quality, Docs)
   - `Files Affected` : Text

4. **Vues recommandées**
   - **Kanban par Status** : Colonne par statut
   - **Timeline par Epic** : Vue chronologique
   - **Calendrier** : Vue par dates d'échéance
   - **Tableau par Assignee** : Répartition équipe

### 🎨 Templates de vues Notion

#### Vue Kanban

```text
Grouper par : Status
Filtrer par : Epic (sélectionnable)
Trier par : Priority, Due Date
```

#### Vue Timeline

```text
Grouper par : Epic
Propriété de date : Due Date
Trier par : Dependencies
```

#### Vue Sprint

```text
Grouper par : Sprint
Filtrer par : Assignee (sélectionnable)
Trier par : Priority
```

## 📝 Notes importantes

- Les estimations sont basées sur notre documentation technique
- Les dépendances respectent l'architecture modulaire
- Les tests sont intégrés à chaque étape
- La qualité (norminette, valgrind) est prioritaire
- Les bonus sont optionnels mais bien définis
