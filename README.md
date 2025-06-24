# Minishell

A simple Unix-style command-line shell built as part of the 42 School curriculum.  
Implements core shell features (`execve`, `fork`, pipes, redirections, built-ins) with optional bonus (`&&`/`||`, globbing). Written in C, using your own Libft utilities.

---

## Table of Contents

1. [Features](#features)  
2. [Prerequisites](#prerequisites)  
3. [Installation & Build](#installation--build)  
4. [Usage](#usage)  
5. [Project Structure](#project-structure)  
6. [Git & GitHub Workflow](#git--github-workflow)  
7. [Testing](#testing)  
8. [Coding Standards](#coding-standards)  
9. [Contributing](#contributing)  
10. [License](#license)  

---

## Features

- **Core execution**: `fork` + `execve` + simple pipelines (`|`)  
- **Parsing & expansion**: tokenization, quotes, `$VAR`  
- **Redirections**: `<`, `>`, `>>`, here-document (`<<`)  
- **Built-ins**: `cd`, `echo`, `exit`, `env`, `export`, `unset`, `pwd`  
- **Signals**: `SIGINT`/`SIGQUIT` handling for parent vs. child  
- **Bonus** (optional): `&&` / `||`, wildcard globbing (`*.c`, etc.)

---

## Prerequisites

- A Unix-like environment (Linux or macOS)  
- GCC (or Clang) with C99 support  
- Make  
- Access to a POSIX shell for running tests  

---

## Installation & Build

1. **Clone the repo**  
   ```bash
   git clone https://github.com/<your-org>/minishell.git
   cd minishell
   ```

2. **Build**  
   ```bash
   make
   ```  
   This will compile both your custom `libft` and the shell binary `minishell`.

3. **Clean**  
   ```bash
   make clean       # remove object files
   make fclean      # remove object files & binary
   make re          # fclean + all
   ```

---

## Usage

Launch your shell:
```bash
./minishell
```

Basic examples:
```bash
$ echo "Hello, world!"
Hello, world!
$ ls -l | grep minishell
-rwxr-xr-x  1 you  staff  123456 Jun 24 12:00 minishell
$ cat < input.txt | sort > output.txt
```

Exit with:
```bash
$ exit
```

---

## Project Structure

```plaintext
minishell/
├── includes/               # public headers
├── libft/                  # custom Libft utilities
├── srcs/                   # all shell source code
│   ├── lexer/              
│   ├── parser/             
│   ├── expander/           
│   ├── executor/           
│   ├── redirections/       
│   ├── builtins/           
│   ├── signals/            
│   └── bonus/              
├── tests/                  # manual & automated tests
├── scripts/                # helper scripts (build, clean, run)
├── docs/                   # design notes, UML diagrams
├── .github/                # CI workflows
├── Makefile
├── README.md
└── .gitignore
```

---

## Git & GitHub Workflow

Since you’re two developers, adopt a simple **Git Feature-Branch** workflow:

1. **Main Branch**  
   - `main` (or `master`) always holds stable, reviewed code.

2. **Feature Branches**  
   - Create a new branch for each task/feature:  
     ```bash
     git checkout main
     git pull origin main
     git checkout -b feature/lexer-improvements
     ```
   - Work and commit early & often:
     ```bash
     git add <files>
     git commit -m "feat(lexer): handle escaped spaces"
     ```

3. **Push & Pull Request (PR)**  
   - Push your branch:
     ```bash
     git push -u origin feature/lexer-improvements
     ```
   - On GitHub, open a PR targeting `main`.  
   - Include a clear description and link to the related task.

4. **Code Review & Merge**  
   - Your partner reviews the PR, requests changes or approves.  
   - Once approved, merge (via GitHub UI) with “Squash and merge” to keep history clean.

5. **Keep in Sync**  
   - Regularly pull from `main` to avoid drift:
     ```bash
     git checkout main
     git pull
     git checkout feature/lexer-improvements
     git merge main
     ```

6. **Resolving Conflicts**  
   - If merge conflicts arise, use:
     ```bash
     git mergetool
     git add <resolved files>
     git commit
     ```
   - Communicate on Slack/Discord to coordinate overlapping changes.

---

## Testing

Run all tests with:
```bash
./tests/run_tests.sh
```
- By default, runs **mandatory** tests.  
- To include bonus tests:
  ```bash
  ./tests/run_tests.sh --bonus
  ```

---

## Coding Standards

- Follow the 42 **Norm**:  
  - Max 25 lines per function, 80 columns per line, no more than 5 functions per file, etc.  
- Header comment on each `.c`/`.h`: project, author, creation/update dates.  
- Use descriptive variable names and modular functions.

---

## Contributing

1. Fork the repo.  
2. Follow the **Git & GitHub Workflow** above.  
3. Write clear, atomic commits.  
4. Open PRs against `main`.  
5. Tag your partner or assign reviewers before merging.

---

## License

This project is released under the [MIT License](LICENSE).  
