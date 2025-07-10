# 📋 Minishell - Gestion de projet

## 🎯 Import Notion (2 personnes, 6 semaines)

### 📊 CSV optimisé

Le fichier `Notion.csv` contient un planning réaliste pour 2 développeurs sur 6 semaines maximum.

### 🚀 Import rapide

1. **Copier** tout le contenu de `Notion.csv`
2. **Notion** → Nouvelle database → Import CSV
3. **Configurer** les types :
   - Epic : Select (Setup, Core, Parsing, Builtins, Redirections, Signals, Testing, Bonus)
   - Priority : Select (High, Medium, Low)
   - Status : Select (To do, In Progress, Done)

### 👥 Répartition recommandée

#### 🧑‍💻 Développeur 1 - Core & Execution
- **Semaine 1** : Setup + Init + Tokenizer + Exec simple
- **Semaine 2-3** : Parsing + Pipes + Builtins
- **Semaine 4-5** : Redirections + Signaux + Tests

#### 🧑‍💻 Développeur 2 - Features & Quality  
- **Semaine 1** : Structure + Headers + Aide setup
- **Semaine 2-3** : Variables + Quotes + Builtins
- **Semaine 4-5** : Heredoc + Tests + Valgrind
- **Semaine 6** : Bonus + Documentation

## 📅 Timeline réaliste (6 semaines)

### Week 1 - Fondations
- ✅ Setup projet complet
- ✅ Structures de base
- ✅ Boucle principale + exec simple

### Week 2 - Parsing  
- ✅ Quotes + Variables
- ✅ AST basique + Pipes

### Week 3 - Builtins
- ✅ Tous les builtins obligatoires

### Week 4 - Redirections
- ✅ < > >> <<

### Week 5 - Finition
- ✅ Signaux + Tests + Valgrind

### Week 6 - Bonus (optionnel)
- ⭐ && || + wildcards

## 🎯 Critères de succès

### Minimum viable (obligatoire)
- Toutes les tâches "High" terminées
- Valgrind clean (0 leak)
- Comportement identique à bash
- Norminette OK

### Bonus (si temps)
- Opérateurs logiques && ||
- Wildcards *

## 🛠️ Conseils pratiques

### 📊 Utilisation Notion
- **Vue Kanban** : suivre l'avancement quotidien
- **Vue Sprint** : planning hebdomadaire
- **Assigner** les tâches selon expertise

### 🤝 Collaboration
- **Daily standup** rapide chaque matin
- **Code review** avant merge
- **Pair programming** sur parties complexes
- **Tests** réguliers ensemble

### ⚡ Productivité
- **Commencer simple** : commandes de base avant features avancées
- **Tester tôt** : comparaison bash dès que possible
- **Valgrind fréquent** : pas attendre la fin
- **Documentation** au fur et à mesure

Ce planning condensé vous permet de livrer un minishell complet et robuste en 6 semaines ! 🚀
