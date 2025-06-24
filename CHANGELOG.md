# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Enhanced documentation with Doxygen
- Code examples and FAQ sections
- Comprehensive API reference
- Architecture documentation
- Interactive documentation browser

### Changed
- Improved Makefile with documentation targets
- Enhanced error handling patterns
- Better memory management practices

### Fixed
- Documentation formatting improvements
- Makefile dependency tracking

## [1.0.0] - 2025-06-24

### Added
- Complete shell implementation
- Built-in commands (echo, cd, pwd, export, unset, env, exit)
- Pipeline execution support
- Input/Output redirections
- Environment variable expansion
- Signal handling (SIGINT, SIGQUIT)
- Quote parsing and escaping
- Command history with readline
- Memory leak detection
- Comprehensive test suite
- 42 Norm compliance checking

### Core Features
- **Lexer**: Token-based input parsing
- **Parser**: Abstract Syntax Tree construction
- **Executor**: Command execution with process management
- **Expander**: Variable and wildcard expansion
- **Signals**: Proper signal handling
- **Redirections**: File I/O redirection support
- **Utils**: Memory management and string utilities

### Development Tools
- Makefile with multiple build targets
- Debug and sanitizer builds
- Automated testing framework
- Norm checking integration
- Memory leak detection with Valgrind

### Documentation
- Comprehensive README with usage examples
- Architecture documentation
- API reference guide
- FAQ section
- Code examples

## [0.9.0] - Development Phase

### Added
- Initial project structure
- Basic tokenization
- Simple command execution
- Built-in command framework

### Changed
- Refactored parsing logic
- Improved error handling
- Enhanced memory management

### Fixed
- Memory leaks in tokenizer
- Signal handling edge cases
- File descriptor management

## [0.8.0] - Alpha Release

### Added
- Basic shell prompt
- Simple command parsing
- Environment variable support
- Basic error handling

### Known Issues
- Limited pipe support
- Incomplete signal handling
- Memory management improvements needed

## [0.7.0] - Prototype

### Added
- Initial codebase
- Basic Makefile
- Core data structures
- Simple input processing

### Development Notes
- Focus on 42 Norm compliance
- Modular architecture design
- Test-driven development approach

---

## Version History Summary

| Version | Release Date | Key Features |
|---------|--------------|--------------|
| 1.0.0   | 2025-06-24   | Complete shell implementation |
| 0.9.0   | Development  | Core functionality |
| 0.8.0   | Alpha        | Basic shell features |
| 0.7.0   | Prototype    | Initial implementation |

## Future Enhancements

### Planned Features (v1.1.0)
- [ ] Command completion with Tab
- [ ] Improved error messages
- [ ] Performance optimizations
- [ ] Extended test coverage
- [ ] Better documentation examples

### Bonus Features (v1.2.0)
- [ ] Wildcard expansion (`*`)
- [ ] Here-document support (`<<`)
- [ ] Logical operators (`&&`, `||`)
- [ ] Command substitution (`$(command)`)
- [ ] Process substitution

### Long-term Goals (v2.0.0)
- [ ] Job control
- [ ] Aliases
- [ ] Functions
- [ ] Advanced scripting features
- [ ] Configuration file support

## Contributing

When contributing to this project, please:

1. Follow the existing code style and 42 Norm
2. Add tests for new features
3. Update documentation as needed
4. Update this changelog for notable changes
5. Ensure no memory leaks with Valgrind

## Release Process

1. Update version numbers in relevant files
2. Update this changelog with release notes
3. Run full test suite
4. Check memory leaks with Valgrind
5. Verify 42 Norm compliance
6. Generate and review documentation
7. Create release tag
