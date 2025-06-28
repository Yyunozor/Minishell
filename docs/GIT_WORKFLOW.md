# 🌊 Git Workflow Guide for Minishell

## 🎯 Quick Reference

### Essential Commands
```bash
# Check current status
git status
git branch -v

# Update dev branch from main
git checkout dev
git pull origin main

# Create and switch to feature branch
git checkout -b feature/new-feature

# Stage, commit, and push changes
git add .
git commit -m "feat: add new feature description"
git push origin feature/new-feature

# Merge feature back to dev
git checkout dev
git merge feature/new-feature
git push origin dev

# Clean up feature branch
git branch -d feature/new-feature
git push origin --delete feature/new-feature
```

## 🏗️ Branch Strategy

### Main Branches
- **`main`** - Production-ready code, stable releases
- **`dev`** - Development integration branch
- **`feature/*`** - Individual feature development

### Branch Naming Convention
```bash
feature/parser-improvements     # New features
bugfix/memory-leak-fix         # Bug fixes
hotfix/critical-security-fix   # Critical fixes
docs/api-documentation         # Documentation updates
refactor/executor-cleanup      # Code refactoring
```

## 🔄 Common Workflows

### 1. Start New Feature
```bash
# Ensure you're on latest dev
git checkout dev
git pull origin main

# Create feature branch
git checkout -b feature/your-feature-name

# Work on your feature...
# Make commits with descriptive messages

# Push feature branch
git push -u origin feature/your-feature-name
```

### 2. Update Dev Branch from Main
```bash
# Switch to dev branch
git checkout dev

# Pull latest changes from main
git pull origin main

# Push updated dev branch
git push origin dev
```

### 3. Merge Feature to Dev
```bash
# Switch to dev branch
git checkout dev

# Merge your feature
git merge feature/your-feature-name

# Push updated dev
git push origin dev

# Delete local feature branch
git branch -d feature/your-feature-name

# Delete remote feature branch
git push origin --delete feature/your-feature-name
```

### 4. Release to Main
```bash
# Switch to main
git checkout main

# Merge stable dev changes
git merge dev

# Tag the release
git tag -a v1.0.0 -m "Release version 1.0.0"

# Push everything
git push origin main
git push origin --tags
```

## 🚨 Conflict Resolution

### If you encounter merge conflicts:
```bash
# View conflicted files
git status

# Edit files to resolve conflicts
# Look for <<<<<<< HEAD markers

# Mark conflicts as resolved
git add .

# Complete the merge
git commit -m "fix: resolve merge conflicts"
```

### Common Conflict Patterns
```bash
<<<<<<< HEAD
// Your changes
=======
// Incoming changes
>>>>>>> branch-name
```

## 🧹 Branch Cleanup

### Delete Local Branches
```bash
# List all branches
git branch -a

# Delete merged feature branch
git branch -d feature/completed-feature

# Force delete unmerged branch (careful!)
git branch -D feature/abandoned-feature
```

### Delete Remote Branches
```bash
# Delete remote branch
git push origin --delete feature/old-feature

# Prune deleted remote branches from local
git remote prune origin
```

### Clean Up Tracking Branches
```bash
# See remote tracking status
git branch -vv

# Remove tracking for deleted remote branches
git branch --unset-upstream
```

## 📝 Commit Message Best Practices

### Format
```
type(scope): description

[optional body]

[optional footer]
```

### Types
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, etc.)
- **refactor**: Code refactoring
- **test**: Adding/updating tests
- **chore**: Maintenance tasks

### Examples
```bash
git commit -m "feat(parser): add support for quoted arguments"
git commit -m "fix(executor): resolve memory leak in pipe handling"
git commit -m "docs: update API reference with new functions"
git commit -m "refactor(lexer): simplify token parsing logic"
```

## 🔍 Useful Git Commands

### Check History
```bash
# View commit history
git log --oneline --graph --all

# View changes in specific commit
git show <commit-hash>

# View file history
git log --follow -- path/to/file
```

### Compare Changes
```bash
# Compare working directory with staging
git diff

# Compare staging with last commit
git diff --cached

# Compare two branches
git diff main..dev
```

### Undo Changes
```bash
# Undo working directory changes
git checkout -- file.c

# Unstage file
git reset HEAD file.c

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1
```

## 🚀 Advanced Workflows

### Rebase Instead of Merge
```bash
# Rebase feature branch onto dev
git checkout feature/your-feature
git rebase dev

# Interactive rebase to clean up commits
git rebase -i HEAD~3
```

### Cherry-pick Commits
```bash
# Apply specific commit from another branch
git cherry-pick <commit-hash>
```

### Stash Work in Progress
```bash
# Stash current changes
git stash push -m "work in progress on feature X"

# List stashes
git stash list

# Apply latest stash
git stash pop

# Apply specific stash
git stash apply stash@{1}
```

## 🎯 42 School Specific Tips

- Always ensure code passes **norminette** before committing
- Run `make && make clean` before major commits
- Test with Valgrind for memory leaks
- Keep commits atomic and focused
- Write descriptive commit messages for evaluation

---

*Remember: Clean Git history makes code review and debugging much easier!*
