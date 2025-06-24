# 🐚 Minishell

<div align="center">

![42 School](https://img.shields.io/badge/42-School-000000?style=for-the-badge&logo=42&logoColor=white)
![C](https://img.shields.io/badge/C-00599C?style=for-the-badge&logo=c&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)

*Un shell UNIX minimal et robuste développé en C pour 42 School*

[Installation](#-installation) • [Usage](#-usage) • [Collaboration](#-collaboration-avec-git--github) • [Documentation](#-documentation)

</div>

---

## 📋 Table des Matières

- [🎯 À Propos](#-à-propos)
- [✨ Fonctionnalités](#-fonctionnalités)
- [🔧 Prérequis](#-prérequis)
- [🚀 Installation](#-installation)
- [📖 Usage](#-usage)
- [🤝 Collaboration avec Git & GitHub](#-collaboration-avec-git--github)
- [🏗️ Architecture](#️-architecture)
- [🧪 Tests](#-tests)
- [🔄 Workflow de Développement](#-workflow-de-développement)
- [📚 Documentation](#-documentation)
- [🛠️ Dépannage](#️-dépannage)
- [👥 Équipe](#-équipe)

## 🎯 À Propos

Minishell est une implémentation complète d'un shell UNIX développée dans le cadre du cursus 42 School. Ce projet vise à comprendre les mécanismes fondamentaux d'un interpréteur de commandes, de la gestion des processus à l'analyse syntaxique, en passant par la manipulation des signaux système.

### Objectifs Pédagogiques

- **Compréhension système** : Maîtrise des appels système UNIX/Linux
- **Gestion mémoire** : Allocation/libération sans fuites mémoire
- **Architecture logicielle** : Conception modulaire et maintenable
- **Travail d'équipe** : Collaboration avec Git/GitHub

## ✨ Fonctionnalités

### 🎯 Fonctionnalités Obligatoires

| Fonctionnalité | Description | Statut |
|---------------|-------------|--------|
| **Exécution de commandes** | Lancement de programmes système | ✅ |
| **Built-ins** | `echo`, `cd`, `pwd`, `export`, `unset`, `env`, `exit` | ✅ |
| **Pipes** | Chaînage de commandes avec `\|` | ✅ |
| **Redirections** | `<`, `>`, `>>`, `<<` (heredoc) | ✅ |
| **Quotes** | Gestion des guillemets simples `'` et doubles `"` | ✅ |
| **Variables** | Expansion des variables d'environnement `$VAR` | ✅ |
| **Signaux** | `Ctrl+C`, `Ctrl+\`, `Ctrl+D` | ✅ |

### 🌟 Fonctionnalités Bonus

| Fonctionnalité | Description | Statut |
|---------------|-------------|--------|
| **Opérateurs logiques** | `&&` et `\|\|` | 🚧 En cours |
| **Wildcards** | Expansion des `*` | 📋 Planifié |

## 🔧 Prérequis

### Système & Outils

- **Système** : Linux ou macOS (compatible POSIX)
- **Compilateur** : GCC >= 9.0 ou Clang >= 10.0 avec support C99
- **Build system** : GNU Make >= 3.81
- **Bibliothèques** : GNU Readline (pour historique et édition de ligne)
- **Git** : Version 2.25+ recommandée
- **Debugger** : GDB ou LLDB pour le débogage

### Installation des Dépendances

**Ubuntu/Debian :**
```bash
sudo apt-get update
sudo apt-get install build-essential libreadline-dev git valgrind
```

**macOS :**
```bash
# Avec Homebrew
brew install readline git
# Valgrind n'est pas disponible sur macOS, utiliser leaks à la place
```

## 🚀 Installation

### Installation Standard

```bash
# 1. Cloner le repository
git clone https://github.com/Yyunozor/minishell.git
cd minishell

# 2. Compiler le projet
make

# 3. Lancer le shell
./minishell
```

### Commandes de Build

```bash
make          # Compilation standard
make clean    # Supprime les fichiers objets
make fclean   # Supprime tout (objets + exécutables)
make re       # Recompilation complète (fclean + make)
make bonus    # Compilation avec fonctionnalités bonus
make debug    # Compilation avec symboles de debug (-g -fsanitize=address)
make norm     # Vérification de la norme 42 avec norminette
```

## 📖 Usage

### Exemples Pratiques

```bash
# Commandes de base
minishell$ echo "Hello, World!"
Hello, World!

minishell$ pwd
/Users/yyuno/Developer/42/Cursus/Minishell

# Pipes et redirections
minishell$ ls -la | grep minishell | wc -l
1

minishell$ echo "Contenu du fichier" > test.txt
minishell$ cat < test.txt
Contenu du fichier

# Variables d'environnement
minishell$ export MY_VAR="42 School"
minishell$ echo $MY_VAR
42 School

minishell$ unset MY_VAR
minishell$ echo $MY_VAR

# Heredoc
minishell$ cat << EOF
> Première ligne
> Deuxième ligne
> EOF
Première ligne
Deuxième ligne

# Navigation
minishell$ cd /tmp
minishell$ pwd
/tmp

minishell$ cd -
/Users/yyuno/Developer/42/Cursus/Minishell

# Quitter proprement
minishell$ exit
```

## 🤝 Collaboration avec Git & GitHub

### 🛠️ Configuration Initiale Git

#### Configuration Personnelle

```bash
# Configuration globale (à faire une seule fois par développeur)
git config --global user.name "Votre Nom Complet"
git config --global user.email "votre.login@student.42.fr"
git config --global init.defaultBranch main
git config --global core.autocrlf input
git config --global pull.rebase true
git config --global core.editor "vim"  # ou "code" pour VSCode
```

#### Configuration Avancée

```bash
# Aliases utiles pour l'équipe
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.unstage "reset HEAD --"
git config --global alias.last "log -1 HEAD"
```

### 🌳 Structure des Branches

Notre projet suit le **Git Flow** adapté pour 42 :

```
main                    # Production (stable, prêt pour évaluation)
├── develop            # Intégration (features terminées)
├── feature/lexer      # Analyse lexicale
├── feature/parser     # Analyse syntaxique  
├── feature/executor   # Exécution des commandes
├── feature/builtins   # Commandes intégrées
├── feature/redirections # Gestion des redirections
├── feature/signals    # Gestion des signaux
├── hotfix/memory-leak # Corrections urgentes
└── bonus/logical-ops  # Fonctionnalités bonus
```

### 📋 Workflow Git Complet pour l'Équipe

#### 1. **Setup Initial du Projet**

```bash
# Le maintainer du projet fait :
git clone https://github.com/Yyunozor/minishell.git
cd minishell
git checkout -b develop
git push -u origin develop

# Chaque membre de l'équipe fait :
git clone https://github.com/Yyunozor/minishell.git
cd minishell
git checkout develop
git pull origin develop
```

#### 2. **Créer et Travailler sur une Feature**

```bash
# 1. S'assurer d'être sur develop et à jour
git checkout develop
git pull origin develop

# 2. Créer une branche pour votre feature
git checkout -b feature/nom-descriptif-de-votre-feature

# 3. Développer (cycle itératif)
# ... coder ...
git add .
git commit -m "feat(lexer): add basic token recognition"

# ... coder plus ...
git add src/lexer/token_utils.c
git commit -m "feat(lexer): implement token validation"

# 4. Pousser régulièrement pour backup
git push -u origin feature/nom-descriptif-de-votre-feature
```

#### 3. **Conventions de Commits (Obligatoires)**

Nous utilisons **Conventional Commits** pour la lisibilité :

```bash
# Format : type(scope): description courte
#
# Types obligatoires :
git commit -m "feat(parser): implement command parsing"      # Nouvelle fonctionnalité
git commit -m "fix(builtins): resolve cd absolute path bug" # Correction de bug
git commit -m "docs(readme): update installation guide"     # Documentation
git commit -m "test(executor): add process creation tests"  # Tests
git commit -m "refactor(lexer): optimize token allocation"  # Refactorisation
git commit -m "style(all): fix norminette violations"       # Style/norme
git commit -m "chore(makefile): update compiler flags"      # Maintenance

# Scopes recommandés :
# lexer, parser, executor, builtins, signals, redirections, memory, tests, docs
```

#### 4. **Pull Requests (Process Obligatoire)**

Avant de merger une feature, **toujours** créer une Pull Request :

```bash
# 1. Finaliser votre feature
git checkout feature/ma-feature
git add .
git commit -m "feat(scope): finalize feature implementation"

# 2. Rebaser sur develop pour éviter les conflits
git checkout develop
git pull origin develop
git checkout feature/ma-feature
git rebase develop

# 3. Résoudre les conflits éventuels puis push
git push origin feature/ma-feature

# 4. Créer la PR sur GitHub avec le template
```

**Template de Pull Request Obligatoire :**

```markdown
## 📋 Description

Brève description de ce que fait cette PR.

## 🔄 Type de changement

- [ ] 🐛 Bug fix (correction non-breaking)
- [ ] ✨ New feature (fonctionnalité non-breaking)
- [ ] 💥 Breaking change (correction ou feature qui casserait l'existant)
- [ ] 📚 Documentation update

## ✅ Checklist Qualité

- [ ] ✅ Code compile sans warnings avec -Wall -Wextra -Werror
- [ ] ✅ Norminette passe sans erreurs
- [ ] ✅ Pas de fuites mémoire (testé avec valgrind/leaks)
- [ ] ✅ Tests manuels effectués
- [ ] ✅ Code review interne fait
- [ ] ✅ Documentation mise à jour si nécessaire

## 🧪 Comment tester

```bash
# Instructions précises pour tester les changements
make && ./minishell
# Puis tester : commande_specifique
```

## 📸 Screenshots/Exemples

Si applicable, ajouter des exemples d'utilisation.

## 🔗 Issues liées

Closes #[numéro_issue]
```

#### 5. **Résolution de Conflits (Guide Pratique)**

```bash
# Quand vous avez des conflits lors d'un rebase/merge :

# 1. Voir les fichiers en conflit
git status

# 2. Pour chaque fichier en conflit, éditer et résoudre
# Chercher et résoudre les marqueurs :
# <<<<<<< HEAD
# votre code
# =======
# code de l'autre branche  
# >>>>>>> feature/autre-branch

# 3. Après résolution, marquer comme résolu
git add fichier_resolu.c

# 4. Continuer le rebase
git rebase --continue

# 5. Si trop compliqué, annuler et demander de l'aide
git rebase --abort
```

### 🔍 Commandes Git Essentielles pour l'Équipe

#### Inspection et Historique

```bash
# Voir l'état actuel
git status                    # État des fichiers
git log --oneline --graph     # Historique visuel
git log --author="Nom"        # Commits d'un auteur
git show HEAD                 # Dernier commit détaillé

# Voir les différences
git diff                      # Changements non stagés
git diff --staged             # Changements stagés
git diff develop..feature/ma-branch  # Différences entre branches
```

#### Annulation et Correction

```bash
# Annuler des modifications
git checkout -- fichier.c           # Annuler modifs non commitées
git reset HEAD fichier.c            # Unstage un fichier
git reset --soft HEAD~1             # Annuler dernier commit (garde changes)
git reset --hard HEAD~1             # Annuler dernier commit + changes

# Corriger le dernier commit
git commit --amend -m "nouveau message"
```

#### Stash (Sauvegarde Temporaire)

```bash
# Sauvegarder temporairement des changements
git stash                            # Sauvegarder
git stash push -m "description"      # Sauvegarder avec message
git stash list                       # Voir les stashes
git stash pop                        # Récupérer dernier stash
git stash apply stash@{0}            # Appliquer un stash spécifique
git stash drop stash@{0}             # Supprimer un stash
```

#### Gestion des Branches

```bash
# Branches locales et distantes
git branch -a                       # Voir toutes les branches
git branch -d feature/old            # Supprimer branche locale
git push origin --delete feature/old # Supprimer branche distante

# Synchronisation
git fetch origin                     # Récupérer infos sans merger
git pull origin develop             # Récupérer + merger develop
git push origin ma-branch           # Pousser ma branche
```

### 📱 GitHub : Issues et Project Management

#### Créer des Issues Structurées

```markdown
**Template d'Issue Bug Report :**
---
## 🐛 Bug Report

### 📝 Description
Description claire et concise du bug.

### 🔄 Steps to Reproduce
1. Lancer `./minishell`
2. Exécuter `commande problématique`
3. Observer le comportement incorrect

### ✅ Expected Behavior
[Comportement attendu]

### ❌ Actual Behavior  
[Comportement observé]

### 🖥️ Environment
- **OS:** [macOS 12.6 / Ubuntu 20.04]
- **Compiler:** [gcc 9.4.0 / clang 13.0.0]
- **Branch:** [develop / feature/xyz]
- **Commit:** [hash du commit]

### 📋 Additional Context
Informations supplémentaires, screenshots, logs...

### 🏷️ Labels
`bug`, `priority:high`, `help wanted`
```

```markdown
**Template d'Issue Feature Request :**
---
## 🚀 Feature Request

### 📝 Description
Description de la fonctionnalité demandée.

### 💡 Motivation
Pourquoi cette feature est-elle nécessaire ?

### 📋 Detailed Description
Description technique détaillée.

### ✅ Acceptance Criteria
- [ ] Critère 1
- [ ] Critère 2
- [ ] Tests passent

### 🏷️ Labels
`enhancement`, `feature`, `good first issue`
```

#### Utilisation des Labels GitHub

| Label | Description | Couleur |
|-------|-------------|---------|
| `bug` | Bug confirmé | #d73a4a |
| `enhancement` | Nouvelle fonctionnalité | #a2eeef |
| `documentation` | Documentation | #0075ca |
| `good first issue` | Bon pour débuter | #7057ff |
| `help wanted` | Aide externe bienvenue | #008672 |
| `priority:high` | Priorité haute | #b60205 |
| `priority:medium` | Priorité moyenne | #fbca04 |
| `priority:low` | Priorité basse | #0e8a16 |

## 🏗️ Architecture

### Structure des Répertoires

```text
minishell/
├── 📁 includes/                    # Headers publics
│   └── minishell.h                # Header principal
├── 📁 libft/                      # Bibliothèque personnalisée
│   ├── includes/ft_libft.h        # Header libft
│   └── srcs/                      # Sources libft
│       ├── ft_string/             # Fonctions string
│       ├── ft_memory/             # Gestion mémoire
│       └── ft_list/               # Listes chaînées
├── 📁 srcs/                       # Code source principal
│   ├── main.c                     # Point d'entrée
│   ├── 📁 lexer/                  # Analyse lexicale
│   │   ├── lexer.c               # Tokenisation
│   │   ├── token_utils.c         # Utilitaires tokens
│   │   └── lexer.h               # Header lexer
│   ├── 📁 parser/                 # Analyse syntaxique
│   │   ├── parser.c              # AST construction
│   │   ├── ast_utils.c           # Utilitaires AST
│   │   └── parser.h              # Header parser
│   ├── 📁 expander/               # Expansion variables
│   │   ├── expander.c            # Expansion $VAR
│   │   ├── quote_handler.c       # Gestion quotes
│   │   └── expander.h            # Header expander
│   ├── 📁 executor/               # Exécution commandes
│   │   ├── executor.c            # Exécution principale
│   │   ├── process_manager.c     # Gestion processus
│   │   └── executor.h            # Header executor
│   ├── 📁 redirections/           # Redirections I/O
│   │   ├── redirect.c            # Redirections
│   │   ├── heredoc.c             # Here documents
│   │   └── redirect.h            # Header redirections
│   ├── 📁 builtins/               # Commandes intégrées
│   │   ├── cd.c                  # Commande cd
│   │   ├── echo.c                # Commande echo
│   │   ├── pwd.c                 # Commande pwd
│   │   ├── export.c              # Commande export
│   │   ├── unset.c               # Commande unset
│   │   ├── env.c                 # Commande env
│   │   ├── exit.c                # Commande exit
│   │   └── builtins.h            # Header builtins
│   ├── 📁 signals/                # Gestion signaux
│   │   ├── signals.c             # Handlers signaux
│   │   └── signals.h             # Header signaux
│   ├── 📁 utils/                  # Utilitaires généraux
│   │   ├── error_handler.c       # Gestion erreurs
│   │   ├── memory_manager.c      # Gestion mémoire
│   │   └── utils.h               # Header utils
│   └── 📁 bonus/                  # Fonctionnalités bonus
│       ├── logical_ops.c         # Opérateurs && ||
│       ├── globbing.c            # Wildcards *
│       └── bonus.h               # Header bonus
├── 📁 tests/                      # Tests
│   ├── 📁 unit/                  # Tests unitaires
│   ├── 📁 integration/           # Tests intégration
│   ├── 📁 mandatory/             # Tests fonctionnalités obligatoires
│   ├── 📁 bonus/                 # Tests fonctionnalités bonus
│   └── run_tests.sh              # Script de tests
├── 📁 scripts/                    # Scripts utilitaires
│   ├── build.sh                  # Script build
│   ├── clean.sh                  # Script nettoyage
│   └── check_norm.sh             # Vérification norminette
├── 📁 docs/                       # Documentation
│   ├── design.md                 # Document design
│   ├── api.md                    # Documentation API
│   └── troubleshooting.md        # Guide dépannage
├── 📁 .github/                    # Configuration GitHub
│   ├── workflows/ci.yml          # CI/CD
│   ├── ISSUE_TEMPLATE/           # Templates issues
│   └── pull_request_template.md  # Template PR
├── 📄 Makefile                    # Instructions build
├── 📄 .gitignore                  # Fichiers ignorés
├── 📄 .norminette                 # Configuration norminette
└── 📄 README.md                   # Ce fichier
```

## 🧪 Tests

### Tests Manuels Basiques

```bash
# Tests de base
echo "Hello World"
echo 'Single quotes test'
echo "Double quotes with $USER"
pwd
cd /tmp && pwd
cd - && pwd

# Tests pipes
ls | grep minishell
cat /etc/passwd | head -5 | tail -2

# Tests redirections
echo "test" > file.txt
cat < file.txt
echo "append" >> file.txt
cat file.txt

# Tests variables
export TEST_VAR="42"
echo $TEST_VAR
unset TEST_VAR
echo $TEST_VAR

# Tests signaux (Ctrl+C, Ctrl+\, Ctrl+D)
```

### Tests Automatisés

```bash
# Lancer tous les tests
make test

# Tests spécifiques
./tests/run_tests.sh mandatory
./tests/run_tests.sh bonus
./tests/run_tests.sh memory  # Tests de fuites mémoire
```

## 🔄 Workflow de Développement

### Processus de Review de Code

1. **Self-Review** : Vérifier son code avant PR
2. **Peer Review** : Au moins 1 approbation requise
3. **Testing** : Tests manuels + automatisés
4. **Merge** : Squash commits si nécessaire

### Checklist Avant Merge

- [ ] ✅ Norminette OK
- [ ] ✅ Compilation sans warnings
- [ ] ✅ Tests passent
- [ ] ✅ Pas de fuites mémoire
- [ ] ✅ Documentation mise à jour
- [ ] ✅ Code review fait

## 📚 Documentation

### Resources Utiles

- [Bash Manual](https://www.gnu.org/software/bash/manual/bash.html)
- [POSIX Shell Specification](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)
- [Conventional Commits](https://www.conventionalcommits.org/)

## 🛠️ Dépannage

### Problèmes Courants

**Compilation échoue :**
```bash
# Vérifier les dépendances
make fclean && make

# Sur macOS avec Homebrew
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
```

**Conflits Git :**
```bash
# Voir les conflits
git status

# Annuler et recommencer
git merge --abort
git rebase --abort
```

**Fuites mémoire :**
```bash
# Linux
valgrind --leak-check=full ./minishell

# macOS
leaks -atExit -- ./minishell
```

## 👥 Équipe

### Contributeurs

- **[@Yyunozor](https://github.com/Yyunozor)** - Lead Developer
- **[@VotrePartenaire](https://github.com/VotrePartenaire)** - Co-Developer

### Responsabilités

| Développeur | Modules Principaux | Responsabilités |
|-------------|-------------------|-----------------|
| **Yyunozor** | Lexer, Parser, Architecture | Architecture générale, Review de code |
| **Partenaire** | Executor, Builtins, Tests | Implémentation features, Testing |

---

<div align="center">

**Made with ❤️ for 42 School**

[⬆ Retour en haut](#-minishell)

</div>