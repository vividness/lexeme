TODO
====

Documentation
-------------
Use Rdoc to document the lib


Language specs (in progress)
--------------

The idea is to have lexeme extendable with user defined langage rulesets.

example 1:

```ruby
Lexeme.define do 
  use_language :ruby
end

tokens = Lexeme.analyze do 
  from_file 'kernel.rb'
end
```

example 2: 

```ruby
Lexeme.define do 
  use_language :mysql
end

tokens = Lexeme.analyze
  from_string 'SELECT * FROM users WHERE id = 1'
end
```

Scanner algorithm 
-----------------
Needs more improvements for better time complexity

Go singleton or not? (implemented; instance model)
-------------------- 
Lexeme#define redefines previously configured ruleset.
Refactor Lexeme#define to return a lexer instance instead of running it as a singleton.
 
