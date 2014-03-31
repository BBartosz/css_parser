require './scanner'
require './parser'

def start(css_string)
  array_of_structs = Scanner.tokens_array(css_string)
  puts array_of_structs
  parser           = Parser.new(array_of_structs)
end

css_string = "body{ margin-left:200px; background:#5d9ab2 url(\"img_tree.png\") no-repeat top left;}
.container{text-align:center;}
#box{
   border:1px solid gray; 
   width:90%;
   background-color:#d0f0f6; 
   text-align:left;padding:8px;
}
a {display:block;background-color:#98bf21;width:120px;text-align:center;padding:4px;}
"

start(css_string)