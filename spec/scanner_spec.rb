require 'spec_helper'

describe Scanner do
  before :each do
    @token_regex      = Scanner.tok_regex
  end

  context '.remove_whitespaces' do
    it "takes array of structs(tokens) and returns array of structs(tokens) without whitespaces" do
      array_of_structs_with_whitespaces = [Token.new(".bartek", "CLASS"), Token.new("#id", "ID"), Token.new(" ", "WHITESPACE")]
      expected_array = array_of_structs_with_whitespaces[0..-2]
      removed_whitespaces = Scanner.remove_whitespaces(array_of_structs_with_whitespaces)

      expect(removed_whitespaces).to eq(expected_array)
    end
  end 

  context '.create_token_group_string' do
    it "creates token group string" do
      token_group_string = Scanner.create_token_group_string([["COMMA", /\,/], ["COLON" ,  /\:/]])
      expected_output    = "(?<COMMA>(?-mix:\\,))|(?<COLON>(?-mix:\\:))"

      expect(token_group_string).to eq(expected_output)
    end
  end

  context '.create_token_structure' do
    it 'creates class token' do
      example_string = '.bartek'
      token_struct   = Scanner.create_token_struct(example_string)
      expected       = Token.new(example_string, 'CLASS')

      expect(token_struct).to eq(expected)
    end

    it 'creates url token' do
      example_string = 'url(www.google.pl)'
      token_struct   = Scanner.create_token_struct(example_string)
      expected       = Token.new(example_string, 'URL')

      expect(token_struct).to eq(expected)
    end
  end

  context '.create_array_of_structs' do
    it 'creates array of tokens' do
      array_of_tokens = Scanner.create_array_of_structs([['.bartek'], ['#id'], [':'], ['url(www.google.pl)']], [])
      expected_array  = [Token.new(".bartek", "CLASS"), Token.new("#id", "ID"), Token.new(":", "COLON"), Token.new("url(www.google.pl)", "URL")] 

      expect(array_of_tokens).to eq(expected_array)
    end
  end
end