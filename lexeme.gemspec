Gem::Specification.new do |s| 
  s.name        = 'lexeme'
  s.version     = '0.0.3'
  s.date        = '2013-07-13'
  s.summary     = 'Lexeme'
  s.description = 'A simple lexical analyzer written in Ruby'

  s.authors     = ['Vladimir Ivic']
  s.email       = 'vladimir.ivic@icloud.com'
  s.homepage    = 'http://rubygems.org/gems/lexeme'
  s.files       = ['lib/lexeme.rb', 'lib/lexeme/lexeme.rb', 
                   'lib/lexeme/token.rb', 'lib/lexeme/ruleset.rb', 
                   'lib/lexeme/rule.rb', 'lib/lexeme/core_extensions.rb', 'lib/lexeme/version.rb']
  
  s.require_paths = ['lib']
end
