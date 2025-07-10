# 🔄 Workflow Git

## 🎯 Workflow de base

### Configuration initiale
```bash
# Configurer Git
git config --global user.name "Votre Nom"
git config --global user.email "votre.email@example.com"

# Cloner le projet
git clone <url-du-repo>
cd Minishell
```

### Workflow de développement

#### 1. Créer une branche pour une fonctionnalité
```bash
# Créer et basculer sur une nouvelle branche
git checkout -b feature/nom-fonctionnalite

# Exemples :
git checkout -b feature/lexer-implementation
git checkout -b feature/pipe-execution
git checkout -b fix/memory-leak
```

#### 2. Développer et tester
```bash
# Développer votre fonctionnalité
# Tester avec make et valgrind
make && valgrind --leak-check=full ./minishell

# Vérifier la norme
norminette srcs/ includes/
```

#### 3. Commiter les changements
```bash
# Ajouter les fichiers modifiés
git add .

# Commiter avec un message descriptif
git commit -m "feat(lexer): implement token classification"

# Autres exemples :
git commit -m "fix(parser): resolve memory leak in AST creation"
git commit -m "docs: update README with new features"
```

#### 4. Pousser et créer une PR
```bash
# Pousser la branche
git push origin feature/nom-fonctionnalite

# Créer une Pull Request sur GitHub
# Demander une review
```

### Convention de nommage des commits

#### Format
```
<type>(<scope>): <description>

[optional body]
```

#### Types
- **feat** : Nouvelle fonctionnalité
- **fix** : Correction de bug
- **docs** : Documentation
- **style** : Formatage du code
- **refactor** : Refactoring
- **test** : Tests
- **chore** : Maintenance

#### Exemples
```bash
git commit -m "feat(executor): add pipeline execution support"
git commit -m "fix(signals): handle SIGINT during command execution"
git commit -m "refactor(parser): simplify AST node creation"
git commit -m "test(builtins): add comprehensive echo command tests"
```

## 🔄 Workflow collaboratif

### Synchronisation avec la branche principale
```bash
# Récupérer les derniers changements
git checkout main
git pull origin main

# Revenir sur votre branche
git checkout feature/votre-branche

# Rebaser sur main (optionnel)
git rebase main
```

### Résolution de conflits
```bash
# En cas de conflit lors du rebase
git status              # Voir les fichiers en conflit
# Éditer les fichiers pour résoudre les conflits
git add .               # Ajouter les fichiers résolus
git rebase --continue   # Continuer le rebase
```

## 🏷️ Gestion des versions

### Tags pour les versions
```bash
# Créer un tag pour une version
git tag -a v1.0.0 -m "Version 1.0.0 - Fonctionnalités de base"

# Pousser les tags
git push origin --tags
```

### Branches importantes
- **main** : Branche stable
- **develop** : Branche de développement
- **feature/** : Branches de fonctionnalités
- **fix/** : Branches de correction
- **hotfix/** : Corrections urgentes

## 🔍 Commandes utiles

### Vérification et inspection
```bash
# Voir l'état des fichiers
git status

# Voir l'historique des commits
git log --oneline

# Voir les différences
git diff

# Voir les branches
git branch -a
```

### Nettoyage
```bash
# Nettoyer les branches locales fusionnées
git branch --merged | grep -v "\*\|main\|develop" | xargs -n 1 git branch -d

# Nettoyer les références des branches supprimées
git remote prune origin
```

## 📋 Checklist avant commit

- [ ] Le code compile sans erreur (`make`)
- [ ] Aucune fuite mémoire (`valgrind`)
- [ ] Respect de la norme 42 (`norminette`)
- [ ] Tests manuels effectués
- [ ] Message de commit descriptif
- [ ] Fichiers appropriés ajoutés (pas de fichiers temporaires)

## 🚨 Cas d'urgence

### Annuler le dernier commit (local)
```bash
# Garder les modifications
git reset --soft HEAD~1

# Supprimer les modifications
git reset --hard HEAD~1
```

### Revenir à un commit spécifique
```bash
# Voir l'historique
git log --oneline

# Revenir à un commit (attention : destructif)
git reset --hard <hash-du-commit>
```

### Stash (sauvegarder temporairement)
```bash
# Sauvegarder les modifications en cours
git stash

# Récupérer les modifications
git stash pop
```
