
Token = Struct.new(:token, :word)
class Scanner

  
  def initialize (input)
    tokens = []
    current_token_number = 0
    tokenize(input).each do |token_array|
      token_array.each do |token|
        puts token.match(tok_regex).inspect if token
      end
    end
  end

  def tokenize(input)
    string_to_tokenize = input.clone
    string_to_tokenize.scan(tok_regex)
  end

  def tok_regex

    token_specification = [
    ["COMMA" , /\,/],
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

skaner = Scanner.new('.dupa{};')
# p Ripper.lex("def m(a) nil end")

### UWAGI
### (?-mix:[a-z]) == /[a-z]/
