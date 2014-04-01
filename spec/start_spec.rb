require 'spec_helper'

describe '#start' do
  it 'should raise Error POPRAWNY CSS' do
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

    expect { start(css_string) }.to raise_error(RuntimeError, "POPRAWNY CSS")
  end

  it 'should raise Error BLEDNY CSS BRAK { lub SELEKTORA' do
    css_string = "body{ margin-left:200px; background:#5d9ab2 url(\"img_tree.png\") no-repeat top left;}
      .container{text-align:center;}
      #box 
         border:1px solid gray; 
         width:90%;
         background-color:#d0f0f6; 
         text-align:left;padding:8px;
      }
      a {display:block;background-color:#98bf21;width:120px;text-align:center;padding:4px;}
      "

    expect { start(css_string) }.to raise_error(RuntimeError, "BLEDNY CSS BRAK { lub SELEKTORA")
  end

  it 'should raise Error MISSING SEMICOLON' do
    css_string = "body{ margin-left:200px; background:#5d9ab2 url(\"img_tree.png\") no-repeat top left;}
      .container{text-align:center;}
      #box{
         border:1px solid gray 
         width:90%;
         background-color:#d0f0f6; 
         text-align:left;padding:8px;
      }
      a {display:block;background-color:#98bf21;width:120px;text-align:center;padding:4px;}
      "

    expect { start(css_string) }.to raise_error(RuntimeError, "MISSING SEMICOLON")
  end
end