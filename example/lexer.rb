#!/usr/bin/env ruby
# The only reason this line is here is 
# so I make loading lexeme lib files easier
($:).unshift(File.join(File.dirname(__FILE__), '../lib/'))


# This is how your code should look like - starting this line
require 'lexeme'

# Setup the lexeme object by adding language lexical rules.
# In this case, I described a language that will make the lexer
# process math equations such is 1 + 4 - 6/5 - sin(1)
Lexeme.setup do |lex|
  lex.ruleset = Lexeme::Ruleset.new do |r|
    r.rule 'LPAR',     /^\($/
    r.rule 'RPAR',     /^\)$/
    r.rule 'PLUS',     /^\+$/
    r.rule 'MINUS',    /^\-$/
    r.rule 'MULTI',    /^\*$/
    r.rule 'DIV',      /^\/$/
    r.rule 'NUMBER',   /^\d+\.?\d?$/
    r.rule 'FUNCTION', /^(sqrt|pow|sin|cos|tan)$/
  end 
end

# Now that we have language defined
# Let's analyze the file and collect the tokens
source = ARGV[0] || File.join(File.dirname(__FILE__), './sample_source_file.src')
tokens = Lexeme.analyze(source)

# Once we have the tokens, we can choose what 
# output we want to render out. I'll display something
# similar to what GNU flex would display
tokens.each do |t|
  puts t.to_text
end
