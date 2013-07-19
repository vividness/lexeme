TODO
====
as of 2013-07-17

Introduce skip tokens
---------------------
- Comments
- Whitespaces

Document the code 
-----------------
Use Rdoc to document the lib

Language specs (in progress)
--------------

The idea is to have lexeme extendable with user defined langage rulesets.

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
