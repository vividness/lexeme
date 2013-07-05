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

# Set our text file path that we want to run analysis against
ipsum_path = File.join(File.dirname(__FILE__), './lorem-ipsum.txt')

# run the analysis using the #file method
tokens = Lexeme.analyze do
  from_file ipsum_path
end

# Displaying tokens is a super easy task
# once the #analyze method returns results
tokens.each do |t|
  puts t.to_text
end

# Here's another example of running the #analyze method by 
# using #string inside the block
# tokens = Lexeme.analyze do 
#   source 'Hi! My name is Vladimir. I live and work in LA, California.'
# end
