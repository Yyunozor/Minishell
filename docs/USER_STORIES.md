# 📝 Templates User Stories

## 🎯 Format des User Stories

### 📋 Template standard

```
En tant que [rôle],
Je veux [fonctionnalité],
Afin de [bénéfice/objectif].

**Critères d'acceptation :**
- [ ] Critère 1
- [ ] Critère 2
- [ ] Critère 3

**Définition de "Done" :**
- [ ] Code fonctionnel
- [ ] Tests passent
- [ ] Norme 42 respectée
- [ ] Pas de fuites mémoire
```

## 📚 Exemples de User Stories

### 🚀 Setup & Infrastructure

**US-001 : Setup du projet**
```
En tant que développeur,
Je veux initialiser le projet Minishell,
Afin de pouvoir commencer le développement dans un environnement propre.

**Critères d'acceptation :**
- [ ] Dépôt Git initialisé avec .gitignore
- [ ] Structure dossiers créée selon architecture
- [ ] Makefile fonctionnel (make, clean, fclean, re)
- [ ] Compilation sans warnings
- [ ] README.md à jour
```

**US-002 : Structures de données**
```
En tant que développeur,
Je veux définir les structures de données principales,
Afin d'avoir une base solide pour l'implémentation.

**Critères d'acceptation :**
- [ ] minishell.h avec toutes les structures
- [ ] Types d'énumération définis
- [ ] Structures alignées avec l'architecture
- [ ] Protection double inclusion
- [ ] Compilation sans erreurs
```

### 🏠 Initialisation

**US-003 : Initialisation du shell**
```
En tant qu'utilisateur,
Je veux que le shell s'initialise correctement,
Afin de pouvoir utiliser l'environnement de commandes.

**Critères d'acceptation :**
- [ ] Fonction init_shell() opérationnelle
- [ ] Copie de l'environnement
- [ ] Gestion des erreurs d'allocation
- [ ] Initialisation des variables shell
- [ ] Retour d'erreur approprié
```

**US-004 : Boucle principale**
```
En tant qu'utilisateur,
Je veux une boucle interactive pour saisir des commandes,
Afin de pouvoir utiliser le shell de manière continue.

**Critères d'acceptation :**
- [ ] Affichage du prompt "minishell$ "
- [ ] Lecture de l'entrée utilisateur
- [ ] Gestion EOF (Ctrl+D)
- [ ] Historique des commandes
- [ ] Sortie propre
```

### 🔤 Lexer

**US-005 : Tokenisation**
```
En tant que développeur,
Je veux décomposer l'entrée utilisateur en tokens,
Afin de pouvoir analyser la syntaxe des commandes.

**Critères d'acceptation :**
- [ ] Reconnaissance des mots
- [ ] Reconnaissance des opérateurs (|, <, >, >>, <<)
- [ ] Gestion des espaces et tabs
- [ ] Gestion basique des quotes
- [ ] Création de liste chaînée de tokens
```

**US-006 : Classification des tokens**
```
En tant que développeur,
Je veux classifier les tokens selon leur type,
Afin de faciliter l'analyse syntaxique.

**Critères d'acceptation :**
- [ ] Types de tokens définis (WORD, PIPE, REDIRECT, etc.)
- [ ] Fonction classify_token()
- [ ] Gestion des erreurs
- [ ] Validation des tokens
- [ ] Libération mémoire appropriée
```

### 🌳 Parser

**US-007 : Construction AST**
```
En tant que développeur,
Je veux construire un AST depuis les tokens,
Afin de représenter la structure des commandes.

**Critères d'acceptation :**
- [ ] Fonction parse() opérationnelle
- [ ] Création de nœuds AST
- [ ] Gestion des commandes simples
- [ ] Gestion des pipes
- [ ] Gestion des redirections
```

**US-008 : Validation syntaxique**
```
En tant qu'utilisateur,
Je veux être informé des erreurs de syntaxe,
Afin de corriger mes commandes.

**Critères d'acceptation :**
- [ ] Détection erreurs syntaxe
- [ ] Messages d'erreur clairs
- [ ] Pas de crash sur erreur
- [ ] Compatibilité avec bash
- [ ] Gestion des cas limites
```

### 🔧 Expander

**US-009 : Expansion des variables**
```
En tant qu'utilisateur,
Je veux utiliser des variables d'environnement dans mes commandes,
Afin d'avoir des commandes dynamiques.

**Critères d'acceptation :**
- [ ] Reconnaissance $VAR et ${VAR}
- [ ] Recherche dans l'environnement
- [ ] Gestion variables inexistantes
- [ ] Expansion $? (code retour)
- [ ] Pas d'expansion dans quotes simples
```

**US-010 : Gestion des quotes**
```
En tant qu'utilisateur,
Je veux utiliser des quotes pour protéger les espaces,
Afin de passer des arguments complexes.

**Critères d'acceptation :**
- [ ] Quotes simples préservent tout
- [ ] Quotes doubles permettent expansion
- [ ] Suppression quotes de protection
- [ ] Gestion quotes échappées
- [ ] Préservation espaces
```

### ⚡ Executor

**US-011 : Exécution commandes simples**
```
En tant qu'utilisateur,
Je veux exécuter des commandes simples,
Afin de faire fonctionner le shell de base.

**Critères d'acceptation :**
- [ ] Fork/exec fonctionnel
- [ ] Recherche dans PATH
- [ ] Gestion codes retour
- [ ] Gestion erreurs exec
- [ ] Distinction builtin/externe
```

**US-012 : Exécution pipes**
```
En tant qu'utilisateur,
Je veux utiliser des pipes pour chaîner des commandes,
Afin de créer des pipelines complexes.

**Critères d'acceptation :**
- [ ] Pipes simples fonctionnels
- [ ] Pipes multiples
- [ ] Gestion file descriptors
- [ ] Fermeture FDs appropriée
- [ ] Wait sur tous processus
```

### 🏠 Builtins

**US-013 : Commande echo**
```
En tant qu'utilisateur,
Je veux utiliser la commande echo,
Afin d'afficher du texte.

**Critères d'acceptation :**
- [ ] Affichage texte avec newline
- [ ] Option -n (sans newline)
- [ ] Gestion arguments multiples
- [ ] Gestion variables
- [ ] Compatibilité bash
```

**US-014 : Commande cd**
```
En tant qu'utilisateur,
Je veux changer de répertoire avec cd,
Afin de naviguer dans le système de fichiers.

**Critères d'acceptation :**
- [ ] Changement répertoire
- [ ] cd sans argument (HOME)
- [ ] cd - (OLDPWD)
- [ ] Mise à jour PWD/OLDPWD
- [ ] Gestion erreurs
```

**US-015 : Commande export**
```
En tant qu'utilisateur,
Je veux définir des variables d'environnement,
Afin de configurer mon environnement.

**Critères d'acceptation :**
- [ ] Définition variables
- [ ] Affichage variables existantes
- [ ] Validation format
- [ ] Persistance dans session
- [ ] Gestion multiple variables
```

### 📤 Redirections

**US-016 : Redirection entrée**
```
En tant qu'utilisateur,
Je veux rediriger l'entrée depuis un fichier,
Afin de fournir des données à une commande.

**Critères d'acceptation :**
- [ ] Redirection < fonctionnelle
- [ ] Ouverture fichier lecture
- [ ] Gestion fichier inexistant
- [ ] Fermeture FD appropriée
- [ ] Gestion erreurs permissions
```

**US-017 : Redirection sortie**
```
En tant qu'utilisateur,
Je veux rediriger la sortie vers un fichier,
Afin de sauvegarder le résultat.

**Critères d'acceptation :**
- [ ] Redirection > fonctionnelle
- [ ] Création/troncature fichier
- [ ] Redirection >> (append)
- [ ] Gestion permissions
- [ ] Fermeture FD appropriée
```

**US-018 : Here-document**
```
En tant qu'utilisateur,
Je veux utiliser des here-documents,
Afin de fournir du contenu multi-lignes.

**Critères d'acceptation :**
- [ ] Syntaxe << DELIMITER
- [ ] Lecture jusqu'au délimiteur
- [ ] Expansion variables dans contenu
- [ ] Gestion délimiteur exact
- [ ] Redirection vers stdin
```

### 📡 Signaux

**US-019 : Gestion interruptions**
```
En tant qu'utilisateur,
Je veux pouvoir interrompre des commandes avec Ctrl+C,
Afin de contrôler l'exécution.

**Critères d'acceptation :**
- [ ] SIGINT pendant prompt (nouvelle ligne)
- [ ] SIGINT pendant commande (interruption)
- [ ] SIGQUIT ignoré
- [ ] Pas de terminaison shell
- [ ] Restauration handlers
```

## 📋 Template pour nouvelles User Stories

```
**US-XXX : [Titre]**
En tant que [rôle],
Je veux [fonctionnalité],
Afin de [bénéfice].

**Critères d'acceptation :**
- [ ] [Critère 1]
- [ ] [Critère 2]
- [ ] [Critère 3]

**Définition de "Done" :**
- [ ] Fonctionnalité implémentée
- [ ] Tests unitaires passent
- [ ] Tests d'intégration passent
- [ ] Norme 42 respectée
- [ ] Pas de fuites mémoire (valgrind)
- [ ] Review approuvée
- [ ] Documentation mise à jour

**Estimation :** [X heures]
**Priorité :** [High/Medium/Low]
**Dépendances :** [US-XXX, US-YYY]
```

## 🔄 Workflow des User Stories

1. **Création** : Rédiger l'US selon le template
2. **Estimation** : Évaluer la complexité en heures
3. **Priorisation** : Définir l'ordre d'implémentation
4. **Assignation** : Attribuer à un développeur
5. **Implémentation** : Développer selon les critères
6. **Tests** : Valider tous les critères
7. **Review** : Vérification par un pair
8. **Acceptation** : Validation finale et merge
