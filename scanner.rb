
Token = Struct.new(:token, :name)
class Scanner

  
  def initialize (input)
    current_token_number = 0
    puts tokenize(input).inspect
    # lista = []
    # lista << Token.new('mojtoken', 'definicja')
    # puts lista
  end

  def tokenize(input)
    tokens_defined = []
    string_to_tokenize = input.clone
    array_of_token_arrays = string_to_tokenize.scan(tok_regex)
    array_of_token_arrays.each do |token_array|
      token_array.each do |token|
        if token
          token_matchdata = token.match(tok_regex)
          token_names = token.match(tok_regex).names

          token_names.each do |name|            
            if token_matchdata[name.to_sym] != nil
              token_struct = Token.new(token_matchdata[name.to_sym].to_s, name) 
              tokens_defined << token_struct
            end
          end
        end
      end
    end
    tokens_defined
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
