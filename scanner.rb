Token = Struct.new(:word, :token)

class Scanner
  def initialize(input)
    @current_token_number = 0
    @tokens = self.class.tokens_array(input)
  end

  def self.tokens_array(input)
    tokenize(input)
  end

  def self.tokenize(input)
    string_to_tokenize    = input.clone
    array_of_token_arrays = string_to_tokenize.scan(tok_regex)

    tokens_struct = create_array_of_structs(array_of_token_arrays)
    array_without_whitespaces(tokens_struct)
  end

  def self.create_array_of_structs(array_of_token_arrays)
    array_of_tokens = array_of_token_arrays.map {|token_array| token_array.find{|token| token}}
    array_of_tokens.map {|token| create_token_struct(token)}
  end

  def self.create_token_struct(token)
    token_matchdata = token.match(tok_regex)
    token_names     = token.match(tok_regex).names

    token_name = token_names.find {|name| token_matchdata[name.to_sym]}
    Token.new(token_matchdata[token_name.to_sym].to_s, token_name)
  end

  def self.tok_regex
    token_specification = [
    ["URL",        /url\(.+\)/],
    ["COMMA" ,     /\,/],
    ["COLON" ,     /\:/],
    ["SCOLON" ,    /\;/],
    ["OCB" ,       /\{/],
    ["CCB" ,       /\}/],
    ["CLASS" ,     /\.[a-zA-Z_]+[0-9]?/],
    ["COLOR",      /#[0-9a-fA-F]{6,6}/],
    ["ID" ,        /\#[a-zA-Z_]+[0-9]?/],
    ["ELEMENT",    /[a-zA-Z_]+[\-]+[a-zA-Z_]*/],
    ["UNIT",       /\d+[em|in|px|%]+/],
    ["ELEMENT" ,   /[a-zA-Z_]+[0-9]?/],
    ["NUMBER",     /-?\d+[.\.]?\d*/],
    ["WHITESPACE", /\s+/],
    ["UNKNOWN",    /./]]

    token_group_str   = create_token_group_string(token_specification)
    %r{#{token_group_str}}
  end

  def self.create_token_group_string(token_spec)
    token_group_string = ''
    token_spec.each do |pair|
      token_group_string += ('(?<%s>%s)' % pair) 
      token_group_string += '|' if pair != token_spec.last
    end
    token_group_string
  end

  def self.array_without_whitespaces(array_of_structs)
    array_of_structs.select{|struct| struct[:token] != 'WHITESPACE'}
  end

  def next_token
    @current_token_number += 1
    if @current_token_number - 1 < @tokens.length
      return @tokens[@current_token_number - 1]
    else
      raise 'Error: No more tokens'
    end
  end
end
