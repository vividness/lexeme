#!/usr/bin/env ruby
# The only reason this line is here is 
# so I make loading lexeme lib files easier
($:).unshift(File.join(File.dirname(__FILE__), '../../lib/'))


# This is how your code should look like - starting this line
require 'lexeme'

# Setup the lexeme object by adding language lexical rules.
# Note: This is not a full C lang spec.
lexer = Lexeme.define do
  token :LPAR     =>   /^\($/
  token :LBRA     =>   /^\{$/
  token :RPAR     =>   /^\)$/
  token :RBRA     =>   /^\}$/
  token :PLUS     =>   /^\+$/
  token :MINUS    =>   /^\-$/
  token :DIV      =>   /^\/$/
  token :SEMI     =>   /^;$/
  token :COMA     =>   /^,$/
  token :ASTR     =>   /^\*$/
  token :NUMBER   =>   /^\d+\.?\d?$/
  token :DIRECTIVE=>   /^#[\w]*$/
  token :SOURCE   =>   /^<[\w\.]*>?$/
  token :STRING   =>   /^"[^"]*"?$/
  token :RESERVED =>   /^(int|char|if|else|main)$/
  token :ID       =>   /^[\w_]+$/
end

# Now that we have language defined
# Let's analyze the file and collect the tokens
tokens = lexer.analyze do 
  from_file 'hello_world.c'
end

# Once we have the tokens, we can choose what 
# output we want to render out. I'll display something
# similar to what GNU flex would display
tokens.each { |t| puts "#{t}" }
