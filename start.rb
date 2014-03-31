require './scanner'
require './parser'

def start(css_string)
  array_of_structs = Scanner.tokens_array(css_string)
  parser           = Parser.new(array_of_structs)
end

css_string = ".container #lol{text-align:;}"

start(css_string)