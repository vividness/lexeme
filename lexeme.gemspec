Gem::Specification.new do |s| 
  s.name        = 'lexeme'
  s.version     = '0.0.4'
  s.date        = '2013-07-15'
  s.summary     = 'Lexeme'
  s.description = 'A simple lexical analyzer written in Ruby'
  s.license     = 'MIT'
  s.authors     = ['Vladimir Ivic']
  s.email       = 'vladimir.ivic@icloud.com'
  s.homepage    = 'https://github.com/mancmelou/lexeme'
  s.files       = ['lib/lexeme.rb', 'lib/lexeme/lexeme.rb', 
                   'lib/lexeme/token.rb', 'lib/lexeme/ruleset.rb', 
                   'lib/lexeme/rule.rb', 'lib/lexeme/core_extensions.rb', 
                   'lib/lexeme/version.rb', 'lib/lexeme/languages/natural.rb']
  
  s.require_paths = ['lib']
end
