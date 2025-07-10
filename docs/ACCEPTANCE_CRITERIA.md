# ✅ Critères d'acceptation des tâches

## 🎯 Définition des critères "Done"

### 📋 Setup & Infrastructure

#### Setup projet & infrastructure
- [ ] Dépôt Git initialisé avec remote
- [ ] Structure dossiers créée selon architecture.md
- [ ] .gitignore configuré (objets, binaires, .DS_Store)
- [ ] Makefile fonctionnel (make, make clean, make fclean, make re)
- [ ] Compilation sans warnings (-Wall -Wextra -Werror)

#### Créer headers & structures
- [ ] minishell.h avec toutes les structures définies
- [ ] Structures alignées avec architecture.md
- [ ] Types d'énumération définis (tokens, nodes, erreurs)
- [ ] Includes système nécessaires
- [ ] Protection contre double inclusion

### 🚀 Initialisation

#### Implémenter init_shell()
- [ ] Fonction respecte prototype API
- [ ] Initialise tous les champs de t_shell
- [ ] Gestion erreurs malloc avec cleanup
- [ ] Copie environnement correctement
- [ ] Retour 0 succès, -1 erreur

#### Boucle principale main()
- [ ] Boucle readline fonctionnelle
- [ ] Gestion EOF (Ctrl+D)
- [ ] Ajout historique commandes
- [ ] Appel process_input() 
- [ ] Cleanup complet à la sortie
- [ ] Gestion signaux de base

### 🔤 Lexer

#### Tokenizer de base
- [ ] Fonction tokenize() opérationnelle
- [ ] Split sur espaces, tabs, newlines
- [ ] Reconnaissance opérateurs (|, <, >, >>, <<)
- [ ] Gestion quotes basique
- [ ] Retour liste chaînée tokens
- [ ] Gestion erreurs mémoire

#### Structures token
- [ ] create_token() avec gestion erreurs
- [ ] free_tokens() libère toute la liste
- [ ] classify_token() détermine type
- [ ] Pas de fuites mémoire (valgrind)

### 🌳 Parser

#### Parser core
- [ ] Fonction parse() construit AST
- [ ] Gestion commandes simples
- [ ] Gestion pipes
- [ ] Gestion redirections
- [ ] Validation syntaxique
- [ ] Gestion erreurs avec messages

#### AST builder
- [ ] create_ast_node() pour tous types
- [ ] free_ast() récursif complet
- [ ] Structures AST cohérentes
- [ ] Gestion erreurs malloc

### 🔧 Expander

#### Expansion variables
- [ ] Reconnaissance $VAR et ${VAR}
- [ ] Recherche dans environnement
- [ ] Gestion variables inexistantes
- [ ] Expansion $? (code retour)
- [ ] Pas d'expansion dans quotes simples

#### Gestion quotes
- [ ] Suppression quotes de protection
- [ ] Préservation espaces dans quotes
- [ ] Gestion quotes échappées
- [ ] Différenciation simple/double quotes

### ⚡ Executor

#### Executor de base
- [ ] Fonction execute_command() opérationnelle
- [ ] Fork/exec fonctionnel
- [ ] Gestion codes retour
- [ ] Distinction builtin/externe
- [ ] Gestion erreurs exec

#### Gestion PATH
- [ ] Recherche binaire dans PATH
- [ ] Gestion PATH relatif/absolu
- [ ] Gestion commandes inexistantes
- [ ] Optimisation recherche

#### Pipeline executor
- [ ] Pipes multiples fonctionnels
- [ ] Gestion file descriptors
- [ ] Fermeture FDs appropriée
- [ ] Wait sur tous processus
- [ ] Gestion erreurs pipe

### 🏠 Builtins

#### Built-in echo
- [ ] Affichage texte avec newline
- [ ] Option -n fonctionnelle
- [ ] Gestion arguments multiples
- [ ] Pas d'expansion dans quotes simples
- [ ] Retour 0 toujours

#### Built-in cd
- [ ] Changement répertoire fonctionnel
- [ ] Gestion cd sans argument (HOME)
- [ ] Gestion cd - (OLDPWD)
- [ ] Mise à jour PWD/OLDPWD
- [ ] Gestion erreurs (inexistant, permissions)

#### Built-in export
- [ ] Ajout variables environnement
- [ ] Affichage variables si pas d'args
- [ ] Validation format variable
- [ ] Gestion multiple variables
- [ ] Persistance dans shell

#### Built-in exit
- [ ] Sortie propre du shell
- [ ] Gestion code retour numérique
- [ ] Validation argument numérique
- [ ] Cleanup complet avant sortie

### 📤 Redirections

#### Redirection input (<)
- [ ] Ouverture fichier en lecture
- [ ] Redirection stdin avec dup2
- [ ] Gestion fichier inexistant
- [ ] Fermeture FD appropriée
- [ ] Gestion erreurs permissions

#### Redirection output (>)
- [ ] Création/troncature fichier
- [ ] Redirection stdout avec dup2
- [ ] Gestion permissions écriture
- [ ] Fermeture FD appropriée

#### Here-document (<<)
- [ ] Lecture jusqu'au délimiteur
- [ ] Stockage temporaire
- [ ] Redirection stdin
- [ ] Gestion délimiteur exact
- [ ] Expansion variables dans contenu

### 📡 Signaux

#### Gestion signaux complète
- [ ] SIGINT (Ctrl+C) dans prompt
- [ ] SIGINT dans commande
- [ ] SIGQUIT (Ctrl+\\) ignoré
- [ ] Pas de terminaison sur SIGQUIT
- [ ] Restauration handlers

### 🧪 Tests

#### Tests unitaires
- [ ] Un test par fonction publique
- [ ] Couverture cas normaux
- [ ] Couverture cas erreurs
- [ ] Assertions claires
- [ ] Exécution automatisée

#### Tests d'intégration
- [ ] Tests comparaison bash
- [ ] Tests commandes complexes
- [ ] Tests edge cases
- [ ] Scripts automatisés
- [ ] Validation sortie identique

### 🔍 Qualité

#### Audit mémoire
- [ ] Valgrind sans fuites
- [ ] Valgrind sans erreurs
- [ ] Tous les malloc ont free
- [ ] Cleanup en cas d'erreur
- [ ] Pas d'accès mémoire invalide

#### Norme 42
- [ ] Norminette sans erreurs
- [ ] Fonctions max 25 lignes
- [ ] Max 5 fonctions par fichier
- [ ] Nommage cohérent
- [ ] Indentation correcte

#### Performance
- [ ] Pas de fuites FD
- [ ] Optimisation PATH
- [ ] Pas de boucles infinies
- [ ] Gestion mémoire efficace

## 📝 Critères transversaux

### Pour chaque tâche
- [ ] Code compile sans warnings
- [ ] Respecte la norme 42
- [ ] Pas de fuites mémoire
- [ ] Gestion d'erreurs appropriée
- [ ] Tests unitaires passent
- [ ] Documentation mise à jour si nécessaire

### Avant merge
- [ ] Review par un pair
- [ ] Tests intégration passent
- [ ] Norme 42 validée
- [ ] Conflicts résolus
- [ ] Commit message clair

## 🎯 Définition de "Done"

Une tâche est considérée comme terminée quand :
1. ✅ **Tous les critères d'acceptation sont remplis**
2. ✅ **Les tests passent** (unitaires et intégration)
3. ✅ **Le code respecte la norme 42**
4. ✅ **Pas de fuites mémoire** (valgrind)
5. ✅ **Review approuvée** par un pair
6. ✅ **Integration dans main** sans conflits
