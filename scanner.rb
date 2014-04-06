  Token = Struct.new(:word, :token)
class Scanner


  def self.tokens_array(input)
    tokens_array = tokenize(input)
    tokens_array
  end

  def self.tokenize(input)
    tokens_defined        = []
    string_to_tokenize    = input.clone
    array_of_token_arrays = string_to_tokenize.scan(tok_regex)

    tokens_struct                     = create_array_of_structs(array_of_token_arrays, tokens_defined)
    tokens_struct_without_whitespaces = remove_whitespaces(tokens_struct)
    tokens_struct_without_whitespaces
    
  end

  def self.create_array_of_structs(array_of_token_arrays, tokens_defined)
    array_of_token_arrays.each do |token_array|
      token_array.each do |token|
        if token
          token_struct = create_token_struct(token)
          tokens_defined << token_struct 
        end
      end
    end
    tokens_defined
  end

  def self.create_token_struct(token)
    token_matchdata = token.match(tok_regex)
    token_names = token.match(tok_regex).names

    token_names.each do |name|            
      if token_matchdata[name.to_sym]
        token_struct = Token.new(token_matchdata[name.to_sym].to_s, name) 
        return token_struct
      end
    end
  end

  def self.tok_regex

    token_specification = [
    ["URL", /url\(.+\)/],
    ["COMMA" , /\,/],
    ["COLON" ,  /\:/],
    ["SCOLON" , /\;/],
    ["OCB" , /\{/],
    ["CCB" , /\}/],
    ["CLASS" , /\.[a-zA-Z_]+[0-9]?/],
    ["COLOR", /#[0-9a-fA-F]{6,6}/],
    ["ID" , /\#[a-zA-Z_]+[0-9]?/],
    ["TEXT", /[a-zA-Z_]+[\-]+[a-zA-Z_]*/],
    ["UNIT", /\d+[em|in|px|%]+/],
    ["ELEMENT" , /[a-zA-Z_]+[0-9]?/],
    ["NUMBER", /-?\d+[.\.]?\d*/],
    ["WHITESPACE", /\s+/],
    ["UNKNOWN", /./]]

    token_group_str = create_token_group_string(token_specification)
    token_group_regex = %r{#{token_group_str}}
  end

  def self.create_token_group_string(token_spec)
    token_group_string = ''
    
    token_spec.each do |pair|
      token_group_string += ('(?<%s>%s)' % pair) 
      token_group_string += '|' if pair != token_spec.last
    end
    token_group_string
  end

  def self.remove_whitespaces(array_of_structs)
    without_spaces = array_of_structs.select{|struct| struct[:token] != 'WHITESPACE'}
    without_spaces  
  end
end

Scanner.tok_regex
