require 'ripper'
require 'pp'


Token = Struct.new(:type, :value)
  
class Scanner

  
  def initialize (input)
    tokens = []
    current_token_number = 0
    tokenize(input).each do |token|

      # self.tokens << token
    end
  end

  def tokenize(input)
    puts tok_regex.match(".chuj{};")
    # puts ".test{};".scan (create_tok_regex)
    []
  end

  def tok_regex

    token_specification = [["COMMA" , /\,/],
    ["COLON" ,  /\:/],
    ["SCOLON" , /\;/],
    ["OCB" , /\{/],
    ["CCB" , /\}/],
    ["SELECTOR" , /[.#]?[a-zA-Z]+[0-9]?/], 
    ["WHITESPACE" , /\s+/]] 

    tok_regex = '' 
    

    token_specification.each do |pair|
      tok_regex += ('(?<%s>%s)' % pair) 
      tok_regex += '|' if pair != token_specification.last
    end
    tok_regex = %r{#{tok_regex}}
    tok_regex
  end
end
skaner = Scanner.new('')
# p Ripper.lex("def m(a) nil end")

### UWAGI
### (?-mix:[a-z]) == /[a-z]/
