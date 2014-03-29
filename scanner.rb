
Token = Struct.new(:token, :def)
class Scanner

  
  def initialize (input)
    tokens = []
    current_token_number = 0
    tokenize(input)
  end

  def tokenize(input)
    string_to_tokenize = input.clone
    array_of_token_arrays = string_to_tokenize.scan(tok_regex)
    array_of_token_arrays.each do |token_array|
      token_array.each do |token|
        if token
          #tu poiwnienem zwrócić liste tokenół najlepiej wraz z
          puts token.inspect
        end
      end
    end

  end

  def tok_regex

    token_specification = [
    ["COMMA" , /\,/],
    ["COLON" ,  /\:/],
    ["SCOLON" , /\;/],
    ["OCB" , /\{/],
    ["CCB" , /\}/],
    ["SELECTOR" , /[.#]?[a-zA-Z]+[0-9]?/]]  

    token_group_str = create_token_group_string(token_specification)

    token_group_regex = %r{#{token_group_str}}
  end

  def create_token_group_string(token_spec)
    token_group_string = ''

    token_spec.each do |pair|
      token_group_string += ('(?<%s>%s)' % pair) 
      token_group_string += '|' if pair != token_spec.last
    end
    token_group_string
  end
end

skaner = Scanner.new('.dupa{};')
# p Ripper.lex("def m(a) nil end")

### UWAGI
### (?-mix:[a-z]) == /[a-z]/
