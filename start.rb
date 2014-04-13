require './scanner'
require './parser'
require './parser2'
require './parser3'

def start_test(css_string)
  scanner = Scanner.new(css_string)
  parser  = Parser3.new(scanner)
  parser.start
end


css_test = "body{ margin-left:200px; background:#5d9ab2 url(\"img_tree.png\") no-repeat top left;}
.container{text-align:center;}
#box{
   border:1px solid gray; 
   width:90%;
   background-colorr:#d0f0f6;
   text-align:left;padding:8px;
}
a {display:block;background-color: #98bf21;width:120px ;text-align:center;padding:4px;}
"

start_test(css_test)