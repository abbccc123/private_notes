# How to exactly extract strings from source code?

## From low to high accuracy

1. Pure regular expression pattern match.
Use `python-regexp` or `bash + GNU term-based tools(grep, sed, coreutils)`

2. Use pygment(stateful lexing - according to Gemini)
More accuracy, but need to use pip to install pygment pkg first(on most machines).

3. Use tree-sitter
The most accuracy method, but need to download language-specific tree-sitter parser code and compile.
Nonetheless, the final package must include these shared objects.

gcc -o python.so -shared src/parser.c src/scanner.c -Os -fPIC
