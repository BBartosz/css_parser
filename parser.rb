require './scanner'


def check_for_undefined(array_of_structs)
  array_of_structs.each do |struct|

    if struct[:token] == "UNKNOWN"
      return "#{struct} is broken token"
    end
  end
  return "everything is ok"
end




def start(array_of_structs)
  first_token = array_of_structs[0]
  if first_token[:token] == ("ELEMENT" || "CLASS" || "ID")

  else
    # raise "error"
  end


  # 
  # amount_of_tokens = array_of_structs.length
  # without_spaces   = remove_whitespaces(array_of_structs)
  # first_token = array_of_structs[0]
  # if first_token[:token] == ('ELEMENT' || 'ID' || 'CLASS')
  #   sliced_array_of_structs = array_of_structs[1..-1]
  #   next_token = get_token(0, sliced)
  # else
  #   raise "Error" 
  # end
end

def get_next_token(array_of_structs)
  sliced_array_of_structs = array_of_structs[1..-1]
  next_token              = sliced_array_of_structs[0]
  next_token
end

def comma_selector_ocb
   
end
array_of_structs = Scanner.tokens_array('p .marked { color: white; } ')
puts array_of_structs.inspect
start(array_of_structs)
# puts check_for_undefined

