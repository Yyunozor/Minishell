# ❓ FAQ - Questions fréquentes

## 🎯 Questions générales

### Q: Qu'est-ce que Minishell ?
**R:** Minishell est un shell simplifié mais complet écrit en C qui recrée les fonctionnalités principales de bash. C'est un projet du cursus 42 qui enseigne :
- **Gestion des processus** : fork(), execve(), wait()
- **Descripteurs de fichiers** : redirections I/O et pipes
- **Gestion des signaux** : traitement des signaux et nettoyage
- **Gestion mémoire** : zéro fuite mémoire
- **Conception de parseur** : lexer, parser, AST

### Q: Quelles fonctionnalités sont supportées ?
**R:** Fonctionnalités principales :
- ✅ Exécution de commandes avec résolution PATH
- ✅ Commandes intégrées (`echo`, `cd`, `pwd`, `export`, `unset`, `env`, `exit`)
- ✅ Variables d'environnement (`$VAR`)
- ✅ Redirections I/O (`<`, `>`, `>>`)
- ✅ Pipes (`|`)
- ✅ Gestion des signaux (Ctrl+C, Ctrl+\\)
- ✅ Gestion des guillemets (`'` et `"`)
- ✅ Historique des commandes

**Bonus :**
- 🔄 Substitution de commandes (`$(command)`, `` `command` ``)
- 🔗 Opérateurs logiques (`&&`, `||`)
- 📁 Wildcards (`*`)
- 🔀 Here-documents (`<<`)

## 🚀 Installation et configuration

### Q: Comment installer Minishell ?
**R:** 
```bash
# Cloner le dépôt
git clone https://github.com/user/Minishell.git
cd Minishell

# Installer les dépendances (macOS)
brew install readline

# Compiler
make

# Lancer
./minishell
```

### Q: Erreur "readline not found" ?
**R:**
```bash
# macOS
brew install readline
export CPPFLAGS="-I/usr/local/opt/readline/include"
export LDFLAGS="-L/usr/local/opt/readline/lib"

# Linux
sudo apt-get install libreadline-dev
```

## 🔧 Développement

### Q: Comment respecter la norme 42 ?
**R:** 
- **Longueur des fonctions** : Maximum 25 lignes
- **Fonctions par fichier** : Maximum 5 fonctions  
- **Noms de variables** : Descriptifs, pas de lettres seules
- **Gestion mémoire** : Toujours libérer la mémoire allouée
- **Norminette** : Vérifier avec `norminette *.c *.h`

### Q: Comment tester le projet ?
**R:**
```bash
# Tests manuels
./minishell

# Tests de mémoire
valgrind --leak-check=full ./minishell

# Comparaison avec bash
echo 'ls | wc -l' | bash > expected.txt
echo 'ls | wc -l' | ./minishell > actual.txt
diff expected.txt actual.txt
```

### Q: Comment déboguer ?
**R:**
```bash
# Compilation debug
make debug

# GDB
gdb ./minishell
(gdb) run
(gdb) bt  # backtrace en cas de segfault
```

## 🛠️ Problèmes courants

### Q: Segmentation fault ?
**R:**
1. Vérifier les pointeurs NULL
2. Vérifier la gestion mémoire
3. Utiliser `gdb` pour localiser le problème
4. Vérifier les limites de tableaux

### Q: Fuites mémoire ?
**R:**
1. Chaque `malloc()` doit avoir son `free()`
2. Libérer en cas d'erreur
3. Utiliser `valgrind` pour détecter les fuites
4. Implémenter des fonctions de nettoyage

### Q: Commande non trouvée ?
**R:**
1. Vérifier la variable PATH : `echo $PATH`
2. Vérifier les permissions : `ls -la`
3. Utiliser le chemin absolu : `/bin/ls`

## 📚 Ressources

### Q: Où trouver de la documentation ?
**R:**
- [Manuel Bash](https://www.gnu.org/software/bash/manual/bash.html)
- [POSIX Shell](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html)
- [42 Norm](https://github.com/42School/norminette)
- [Advanced Programming in UNIX Environment](https://www.apuebook.com/)

### Q: Outils de développement recommandés ?
**R:**
- **Compilateur** : `gcc` avec flags `-Wall -Wextra -Werror`
- **Débogueur** : `gdb`
- **Vérification mémoire** : `valgrind`
- **Norme** : `norminette`
- **Tests** : Scripts de comparaison avec bash
