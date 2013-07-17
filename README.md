lexeme   [![Build Status](https://travis-ci.org/mancmelou/lexeme.png)](https://travis-ci.org/mancmelou/lexeme)
======
A simple lexical analyzer for programming and human languages.

Install
-------
There are two easy ways to get `lexeme` on your box. You can either download the source or install the ruby gem. 

    gem install lexeme

The easiest and fastest way to try the latest version is:

    git clone https://github.com/mancmelou/lexeme.git
    cd lexeme
    
    irb -Ilib 
    irb(main):001:0> require 'lexeme'
    => true
    irb(main):002:0> "Greetings from LA!!".tokenize
    => [WORD: Greetings, WORD: from, WORD: LA, EXCL: !, EXCL: !]
    
Usage
-----
Just look under the `example` directory for a quick example on how the library can be used to efficiently 
tokenize mathematical expressions such is `1 + 3 - sin(0)/cos(1) * pow(6)`. However, since tokenizing 
mathematical expressions may not be sufficient for a modern day programming language, another good example
could be a demonstration of the ability to toknize pseudo code.

Let's say we have a source code of some pseudo program and we save it in a file named `pseudo-code.src`:

    func hello_world
      x = 1
      y = x + 2
      print "Hello"
    fin

Since we can see that there's a couple of lexemes used in this language we will define them as part 
of the lexer's operative ruleset. To keep things as simple as possible, I'll place
the language definition and the lexical analyzer call in the same code base. 
Ideally, language definition would be something you want to write and include separately. 

Our ruby code should look like this:

```ruby
require 'lexeme'

lexer = Lexeme.define do
  token :EQ       => /^=$/
  token :PLUS     => /^\+$/
  token :MINUS    => /^\-$/
  token :MULTI    => /^\*$/
  token :DIV      => /^\/$/
  token :NUMBER   => /^\d+\.?\d?$/
  token :RESERVED => /^(fin|print|func|)$/
  token :STRING   => /^".*"$/
  token :ID       => /^[\w_"]+$/ 
end

tokens = lexer.analyze do 
  from_file 'pseudo-code.src'
end

tokens.each do |t|
  puts "#{t.name}: #{t.value}"
end
```

Once ran, the code above should output:

    RESERVED: func
    ID: hello_world
    ID: x
    EQ: =
    NUMBER: 1
    ID: y
    EQ: =
    ID: x
    PLUS: +
    NUMBER: 2
    RESERVED: print
    STRING: "Hello"
    RESERVED: fin

Human languages 
---------------
Lexeme can also be used for human language processing. Here's a quick example on how to do it.

```ruby
require 'lexeme'

puts "Greetings from Los Angeles!!".tokenize
```

Running this code will produce:

    [WORD: Greetings, WORD: from, WORD: Los, WORD: Angeles, EXCL: !, EXCL: !]

A more advanced example with a customized syntatical rules would be something like this:

```ruby
require 'lexeme'

lexer = Lexeme.define do
  token :STOP     =>   /^\.$/
  token :COMA     =>   /^,$/
  token :QUES     =>   /^\?$/
  token :EXCLAM   =>   /^!$/
  token :QUOT     =>   /^"$/
  token :APOS     =>   /^'$/
  token :WORD     =>   /^[\w\-]+$/
end 

tokens = lexer.analyze do
  from_string 'Hello! My name is Inigo Montoya. You killed my father. Prepare to die.'
end

tokens.each do |t|
  puts "#{t.name}: #{t.value}"
end
```

Will output: 

    WORD: Hello
    EXCLAM: !
    WORD: My
    WORD: name
    WORD: is
    WORD: Inigo
    WORD: Montoya
    STOP: .
    WORD: You
    WORD: killed
    WORD: my
    WORD: father
    STOP: .
    WORD: Prepare
    WORD: to
    WORD: die
    STOP: .

Contributing
------------
Any help on this project is very welcome. Please feel free to fork, modify and 
make pull requests. Also make sure you check the TODO file when the file is present in the repository. 

Author
------
Lexeme was written by Vladimir Ivic (vladimir.ivic at icloud.com) and is
released under the MIT license.
