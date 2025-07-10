# 🐚 Minishell

[![42 School](https://img.shields.io/badge/42-School-000000?style=flat&logo=42&logoColor=white)](https://42.fr/)
[![C](https://img.shields.io/badge/C-00599C?style=flat&logo=c&logoColor=white)](https://en.wikipedia.org/wiki/C_(programming_language))
[![42 Norm](https://img.shields.io/badge/42%20Norm-passing-success)](https://github.com/42School/norminette)

**Un shell POSIX-compatible implémenté en C dans le cadre du cursus 42**

## 🎯 Objectifs d'apprentissage

- **Gestion des processus**: Maîtrise de `fork()`, `execve()`, `wait()`
- **Descripteurs de fichiers**: Redirections I/O et gestion des pipes
- **Gestion des signaux**: Traitement correct des signaux et nettoyage
- **Gestion mémoire**: Zéro fuite mémoire avec tests complets
- **Conception de parseur**: Analyse lexicale et construction d'AST

## 🚀 Installation et utilisation

### Prérequis

```bash
# macOS
brew install readline

# Linux (Ubuntu/Debian)
sudo apt-get install libreadline-dev
```

### Installation

```bash
# Cloner le dépôt
git clone https://github.com/user/Minishell.git
cd Minishell

# Compiler
make

# Lancer minishell
./minishell
```

### Commandes disponibles

```bash
# Exemples d'utilisation
minishell$ echo "Hello World"
minishell$ ls -la | grep minishell
minishell$ export VAR=value
minishell$ echo $VAR
minishell$ cd /tmp && pwd
minishell$ cat < file.txt > output.txt
minishell$ exit
```

## ⭐ Fonctionnalités

### Fonctionnalités principales

- ✅ **Exécution de commandes** - Résolution PATH et commandes externes
- ✅ **Commandes intégrées** - `echo`, `cd`, `pwd`, `export`, `unset`, `env`, `exit`
- ✅ **Variables d'environnement** - Expansion `$VAR` et manipulation
- ✅ **Redirections I/O** - Support `<`, `>`, `>>`
- ✅ **Pipes** - Exécution de pipelines multi-commandes
- ✅ **Gestion des signaux** - SIGINT (Ctrl+C), SIGQUIT (Ctrl+\\)
- ✅ **Gestion des guillemets** - Parsing guillemets simples et doubles
- ✅ **Historique** - Navigation dans l'historique des commandes

### Bonus

- 🔄 **Substitution de commandes** - `$(command)` et `` `command` ``
- 🔗 **Opérateurs logiques** - `&&` et `||`
- 📁 **Wildcards** - Expansion `*`
- 🔀 **Here-documents** - Support `<<`

### Commandes intégrées

| Commande | Description | Exemple |
|----------|-------------|---------|
| `echo` | Affiche du texte (option -n) | `echo -n "Hello"` |
| `cd` | Change de répertoire | `cd /home/user` |
| `pwd` | Affiche le répertoire courant | `pwd` |
| `export` | Définit des variables d'environnement | `export VAR=value` |
| `unset` | Supprime des variables d'environnement | `unset VAR` |
| `env` | Affiche les variables d'environnement | `env` |
| `exit` | Quitte le shell | `exit 0` |

## 🏗️ Structure du projet

```
Minishell/
├── 📄 Makefile              # Configuration de build
├── 📖 README.md             # Documentation
├── � includes/minishell.h  # Header principal
├── 📂 srcs/                 # Code source
│   ├── 🚀 main.c            # Point d'entrée
│   ├── 📂 init/             # Initialisation du shell
│   ├── 📂 lexer/            # Analyse lexicale
│   ├── 📂 parser/           # Analyse syntaxique
│   ├── 📂 expander/         # Expansion des variables
│   ├── 📂 executor/         # Exécution des commandes
│   ├── 📂 builtins/         # Commandes intégrées
│   ├── 📂 redirections/     # Redirections I/O
│   ├── 📂 signals/          # Gestion des signaux
│   ├── 📂 utils/            # Fonctions utilitaires
│   └── 📂 bonus/            # Fonctionnalités bonus
├── 📂 tests/                # Tests
└── 📂 docs/                 # Documentation
```

## 🔧 Développement

### Compilation

```bash
make                # Build standard
make debug          # Build avec debug
make clean          # Nettoie les fichiers objets
make fclean         # Nettoie tous les fichiers générés
make re             # Recompile tout
```

### Tests

```bash
# Tests manuels
./minishell

# Tests avec valgrind
make debug
valgrind --leak-check=full ./minishell

# Comparaison avec bash
echo 'ls | wc -l' | bash > expected.txt
echo 'ls | wc -l' | ./minishell > actual.txt
diff expected.txt actual.txt
```

### Normes 42

- **Longueur des fonctions** : Maximum 25 lignes
- **Fonctions par fichier** : Maximum 5 fonctions
- **Gestion mémoire** : Pas de fuites mémoire
- **Norminette** : Respect strict des règles 42

## 🛠️ Problèmes courants

### Erreurs de compilation

```bash
# Readline non trouvé (macOS)
brew install readline
export CPPFLAGS="-I/usr/local/opt/readline/include"
export LDFLAGS="-L/usr/local/opt/readline/lib"
```

### Erreurs d'exécution

```bash
# Commande non trouvée
echo $PATH
export PATH="/usr/bin:/bin:$PATH"

# Segmentation fault
gdb ./minishell
(gdb) run
(gdb) bt
```

## 📚 Ressources

### Documentation

- [Manuel Bash](https://www.gnu.org/software/bash/manual/bash.html)
- [Spécification POSIX Shell](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html)
- [GNU Readline](https://tiswww.case.edu/php/chet/readline/rltop.html)

### Programmation système

- [Advanced Programming in UNIX Environment](https://www.apuebook.com/)
- [The Linux Programming Interface](https://man7.org/tlpi/)

### Ressources 42

- [42 Norm](https://github.com/42School/norminette)
- [Documentation Valgrind](https://valgrind.org/docs/manual/)
- [Tutoriel GDB](https://www.gdbtutorial.com/)

---

**Projet réalisé dans le cadre du cursus 42 School**
