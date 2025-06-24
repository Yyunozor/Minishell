# Frequently Asked Questions (FAQ)

## General Questions

### Q: What is Minishell?
**A:** Minishell is a simplified shell implementation written in C that mimics the behavior of bash. It's a project from 42 School that teaches systems programming concepts including process management, file descriptors, and signal handling.

### Q: What features does Minishell support?
**A:** Minishell supports:
- Command execution with PATH resolution
- Built-in commands (echo, cd, pwd, export, unset, env, exit)
- Input/Output redirections (`<`, `>`, `>>`)
- Pipes (`|`)
- Environment variable expansion (`$VAR`)
- Signal handling (Ctrl+C, Ctrl+\)
- Quote parsing and escaping
- Command history (with readline)

## Compilation & Setup

### Q: How do I compile Minishell?
**A:** Use the provided Makefile:
```bash
make                # Standard build
make bonus          # Build with bonus features
make debug          # Debug build with -g flag
make sanitize       # Build with address sanitizer
```

### Q: I get "readline not found" errors during compilation. How do I fix this?
**A:** Install the readline library:
```bash
# macOS
brew install readline

# Ubuntu/Debian
sudo apt-get install libreadline-dev

# Arch Linux
sudo pacman -S readline
```

### Q: What compiler flags are used?
**A:** The project uses strict compilation flags for code quality:
- `-Wall -Wextra -Werror`: Enable all warnings and treat them as errors
- `-std=c99`: Use C99 standard
- `-g3`: Include debug information (debug build)
- `-fsanitize=address`: Memory error detection (sanitize build)

## Usage Questions

### Q: How do I run Minishell?
**A:** After compilation, simply run:
```bash
./minishell
```

### Q: What built-in commands are available?
**A:** 
- `echo [-n] [text]`: Display text
- `cd [directory]`: Change directory
- `pwd`: Print working directory
- `export [VAR=value]`: Set environment variables
- `unset [VAR]`: Unset environment variables
- `env`: Display environment variables
- `exit [code]`: Exit shell with optional status code

### Q: How do I use redirections?
**A:**
```bash
# Input redirection
command < input_file

# Output redirection
command > output_file

# Append redirection
command >> output_file

# Here-document (bonus)
command << delimiter
```

### Q: How do pipes work?
**A:** Pipes connect the output of one command to the input of another:
```bash
ls -la | grep ".c" | wc -l
```

## Development Questions

### Q: How is the code organized?
**A:** The codebase follows a modular structure:
- `srcs/lexer/`: Tokenization and lexical analysis
- `srcs/parser/`: Syntax parsing and AST building
- `srcs/executor/`: Command execution
- `srcs/builtins/`: Built-in command implementations
- `srcs/expander/`: Variable and wildcard expansion
- `srcs/signals/`: Signal handling
- `srcs/redirections/`: I/O redirection handling
- `srcs/utils/`: Utility functions

### Q: What coding standards are followed?
**A:** The project follows the 42 Norm:
- Maximum 25 lines per function
- Maximum 5 functions per file
- Descriptive variable names
- Proper memory management
- No memory leaks

### Q: How do I add a new built-in command?
**A:**
1. Create a new file in `srcs/builtins/`
2. Implement the function following the pattern: `int builtin_name(char **args, t_shell *shell)`
3. Add the function prototype to `minishell.h`
4. Register the command in the built-in command lookup table
5. Update the Makefile to include the new source file

## Debugging Questions

### Q: How do I debug memory leaks?
**A:** Use the provided targets:
```bash
make sanitize       # Build with AddressSanitizer
make leaks         # Run with Valgrind
```

### Q: How do I debug segmentation faults?
**A:**
```bash
make debug         # Build with debug symbols
gdb ./minishell    # Run with GDB
(gdb) run
(gdb) bt           # Get backtrace when crash occurs
```

### Q: What if my shell hangs or becomes unresponsive?
**A:** Check for:
- Infinite loops in parsing logic
- Blocked file descriptors
- Missing signal handlers
- Deadlocks in pipe handling

## Testing Questions

### Q: How do I run tests?
**A:**
```bash
make test          # Run unit tests
make norm          # Check coding standard compliance
```

### Q: How do I test my shell against bash?
**A:** Create test scripts and compare outputs:
```bash
echo "command" | bash > bash_output.txt
echo "command" | ./minishell > minishell_output.txt
diff bash_output.txt minishell_output.txt
```

### Q: What edge cases should I test?
**A:**
- Empty input
- Invalid syntax
- Non-existent commands
- Permission denied
- Memory exhaustion
- Signal interruption
- Large input strings
- Nested quotes
- Complex pipelines

## Error Handling Questions

### Q: How should I handle errors?
**A:**
- Always check return values of system calls
- Print meaningful error messages to stderr
- Clean up allocated resources on errors
- Return appropriate exit codes
- Don't exit the shell for non-fatal errors

### Q: What exit codes should I use?
**A:**
- `0`: Success
- `1`: General error
- `2`: Syntax error
- `126`: Permission denied
- `127`: Command not found
- `128+n`: Killed by signal n

## Performance Questions

### Q: How can I optimize my shell's performance?
**A:**
- Minimize memory allocations
- Reuse buffers where possible
- Avoid unnecessary string copying
- Use efficient data structures
- Profile with tools like `time` and `valgrind --tool=callgrind`

### Q: My shell is slow with large outputs. How can I fix this?
**A:**
- Buffer I/O operations
- Avoid frequent small writes
- Use appropriate buffer sizes
- Consider pipe buffer limits

## Common Issues

### Q: Why does my shell not handle Ctrl+C properly?
**A:** Make sure you:
- Set up signal handlers with `signal()` or `sigaction()`
- Handle SIGINT appropriately (don't exit, just display new prompt)
- Restore terminal state after signal handling

### Q: Environment variables aren't expanding correctly. What's wrong?
**A:** Check:
- Variable name parsing (alphanumeric + underscore)
- Environment lookup implementation
- Quote handling (variables in single quotes shouldn't expand)
- Special variables like `$?` (exit status)

### Q: My pipes aren't working. What could be the issue?
**A:** Common pipe issues:
- Not closing file descriptors properly
- Fork/exec order problems
- Parent process not waiting for children
- File descriptor leaks
- Mixing stdout/stderr redirection

### Q: The shell crashes when I type certain commands. How do I debug this?
**A:**
1. Use `make debug` to build with debug symbols
2. Run with `gdb ./minishell`
3. Set breakpoints: `(gdb) break function_name`
4. Use `valgrind` to check for memory errors
5. Add printf debugging for complex logic

## Documentation Questions

### Q: How do I generate the documentation?
**A:**
```bash
make docs          # Generate HTML documentation
make docs-clean    # Clean generated documentation
```

### Q: Where can I find the API reference?
**A:** After running `make docs`, open `docs/html/index.html` in your browser. The API reference includes all function signatures, parameters, and return values.

### Q: How do I add documentation to my code?
**A:** Use Doxygen comments:
```c
/**
 * @brief Brief description of the function
 * @param param1 Description of parameter 1
 * @param param2 Description of parameter 2
 * @return Description of return value
 */
int my_function(int param1, char *param2);
```
