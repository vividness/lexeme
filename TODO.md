TODO
====

Introduce skip tokens
---------------------
- Comments
- Whitespaces

```ruby
lexer = Lexeme.define do 
  token :ID      => /^\w+/
  skip  :WHITE   => /^\s/
  skip  :COMMENT => /^#.*\n/          # one line comment ruby style
  skip  :COMMENT => /^\/\/.*\n/       # one line comment c++ style
  skip  :COMMENT => /^\/\*.*(\*\/)+/  # multi line comment c style
end

```

Language specs (in progress)
----------------------------
Write a doc section that explains how a lang-spec is created

```ruby
lexer = Lexeme.define do 
  use_language :mysql
end

lexer.analyze
  from_string 'SELECT * FROM users WHERE id = 1'
end
```

Scanner algorithm 
-----------------
Needs more improvements for better time complexity

Document the code 
-----------------
Use Rdoc to document the lib
