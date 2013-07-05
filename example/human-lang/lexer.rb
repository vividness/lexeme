#!/usr/bin/env ruby

# The only reason this line is here is 
# so I make loading lexeme lib files easier
($:).unshift(File.join(File.dirname(__FILE__), '../../lib/'))

# This is how your code should look like - starting this line
require 'lexeme'

# Setup the lexeme object by adding language lexical rules.
Lexeme.define do
  token :STOP     =>   /^\.$/
  token :COMA     =>   /^,$/
  token :QUES     =>   /^\?$/
  token :EXCLAM   =>   /^!$/
  token :QUOT     =>   /^"$/
  token :APOS     =>   /^'$/
  token :WORD     =>   /^[\w\-]+$/
end

source = File.join(File.dirname(__FILE__), './lorem-ipsum.txt')
tokens = Lexeme.analyze(source)

tokens.each do |t|
  puts t.to_text
end
