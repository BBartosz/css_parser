require './scanner'
require './parser'
require './parser2'
require './parser3'

def start_test(css_string)
  array_of_structs = Scanner.tokens_array(css_string)
  parser           = Parser2.new(array_of_structs)
end


css_test = "body{ margin-left:200px; background:#5d9ab2 url(\"img_tree.png\") no-repeat top left;}
.container{text-align:center;}
#box{
   border:1px solid gray; 
   width:90%;
   background-colorr:#d0f0f6; 
   text-align:left;padding:8px;
}
a {display:block;background-color:#98bf21;width:120px ;text-align:center;padding:4px;}
"
input_string = ".bartek, monika, #piotrkow {bartek: warszawa; rudy:chuj;}"
# puts Scanner.new(css_test).inspect
scanner = Scanner.new(css_test)
puts Scanner.tokens_array(css_test)
parser = Parser3.new(scanner)
parser.start