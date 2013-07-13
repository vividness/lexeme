TODO
====

Language specs
--------------

The idea is to have lexeme extendable with user defined langage rulesets.

example:

```ruby
Lexeme.define do 
  use_language :ruby
end

tokens = Lexeme.analyze do 
  from_file 'kernel.rb'
end
```

or: 

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

Go singleton or not?
--------------------

Lexeme#define redefines previously configured ruleset.
Refactor Lexeme#define to return a lexer instance instead of running it as a singleton.
