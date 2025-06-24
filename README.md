# Minishell

Un shell UNIX minimal en C pour 42 School.

## Description

Implémentation d'un shell basique avec :
- Exécution de commandes
- Pipes et redirections
- Variables d'environnement
- Commandes built-in
- Gestion des signaux

## Fonctionnalités

### Obligatoires

- Exécution de commandes système
- Built-ins : `echo`, `cd`, `pwd`, `export`, `unset`, `env`, `exit`
- Pipes `|`
- Redirections `<`, `>`, `>>`, `<<`
- Gestion des quotes `'` et `"`
- Variables d'environnement `$VAR`
- Signaux `Ctrl+C`, `Ctrl+\`, `Ctrl+D`

### Bonus

- Opérateurs logiques `&&` et `||`
- Wildcards `*`

## Prérequis

- POSIX-compliant system (Linux or macOS)
- GCC or Clang compiler with C99 support
- Make build system
- GNU Readline library (for command history and editing)

## Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Yyunozor/minishell.git
   cd minishell
   ```

2. **Build the project**

   ```bash
   make
   ```

   This compiles both the custom `libft` library and the `minishell` executable.

3. **Run the shell**

   ```bash
   ./minishell
   ```

## Build Commands

```bash
make clean   # Remove object files
make fclean  # Remove object files and executables
make re      # Clean rebuild (fclean + make)
make bonus   # Build with bonus features
```

## Usage Examples

```bash
minishell$ echo "Hello, World!"
Hello, World!

minishell$ ls -la | grep minishell
-rwxr-xr-x  1 user  staff  45678 Jun 24 12:00 minishell

minishell$ export MY_VAR="test"
minishell$ echo $MY_VAR
test

minishell$ cat < input.txt | sort > output.txt

minishell$ exit
```

## Structure du Projet

```text
minishell/
├── includes/               # public headers
│   └── minishell.h
├── libft/                  # your custom libft
│   ├── includes/
│   │   └── ft_libft.h
│   └── srcs/
│       ├── ft_strutils.c
│       └── ft_memutils.c
├── srcs/                   # all shell code
│   ├── main.c
│   ├── lexer/              
│   │   ├── lexer.c
│   │   └── lexer.h
│   ├── parser/             
│   │   ├── parser.c
│   │   └── parser.h
│   ├── expander/           
│   │   ├── expander.c
│   │   └── expander.h
│   ├── executor/           
│   │   ├── executor.c
│   │   └── executor.h
│   ├── redirections/       
│   │   ├── redirect.c
│   │   └── redirect.h
│   ├── builtins/           
│   │   ├── cd.c
│   │   ├── echo.c
│   │   └── ...  
│   ├── signals/            
│   │   ├── signals.c
│   │   └── signals.h
│   └── bonus/              # bonus mirrors mandatory structure
│       ├── logical_ops.c
│       └── globbing.c
├── tests/                  
│   ├── mandatory/          
│   ├── bonus/              
│   └── run_tests.sh        
├── scripts/                
│   ├── build.sh
│   └── clean.sh
├── docs/                   
│   └── design.md
├── .github/                
│   └── workflows/ci.yml
├── Makefile
├── README.md
└── .gitignore
```

Made with ❤️ for 42 School