require './scanner'


def check_for_undefined(array_of_structs)
  array_of_structs.each do |struct|

    if struct[:token] == "UNKNOWN"
      raise "#{struct} is broken token"
    end
  end
  return "everything is ok"
end

def start(array_of_structs)
  first_token  = array_of_structs[0]
  sliced_array = array_of_structs[1..-1]
  if (first_token[:token] == "ELEMENT") or (first_token[:token] == "CLASS") or (first_token[:token] == "ID")
    check_for_selector(sliced_array)
  else
    raise "ZLE NA STARCIE"
  end
end

def check_for_selector(sliced_array)
  token = sliced_array[0]

  if (token[:token] == "ELEMENT") || (token[:token] == "CLASS") || (token[:token] == "ID")
    array_with_removed_first_token = sliced_array[1..-1]
    if array_with_removed_first_token.length > 0
      check_for_selector(array_with_removed_first_token) 
    else
      raise "BRAK { CHUJOWY CSS"
    end
  elsif token[:token] == 'OCB'
    array_with_removed_ocb = sliced_array[1..-1]
    check_declaration(array_with_removed_ocb)
  else
    raise "BLEDNY CSS"
  end
end

def check_declaration(tokens_after_ocb)
  token = tokens_after_ocb[0]
  if (token[:token] == "ELEMENT") || (token[:token] == "TEXT")
    array_with_removed_first_token = tokens_after_ocb[1..-1]
    if array_with_removed_first_token.length > 0
      check_for_colon(array_with_removed_first_token)
    else
      raise "BRAK : CHUJOWY CSS"
    end
  elsif token[:token] == "CCB"
    array_with_removed_first_token = tokens_after_ocb[1..-1]
    raise "POPRAWNY CSS"
  end
end

def check_for_semicolon(sliced_array)
  token = sliced_array[0]
  if token[:token] == 'SCOLON'
    if sliced_array.length > 1
      array_with_removed_first_token = sliced_array[1..-1]
      start(array_with_removed_first_token)
    else
      raise 'POPRAWNY CSS'
    end
  end
end

def check_for_colon(tokens_array)
  token = tokens_array[0]
  if (token[:token] == "COLON")
    if tokens_array.length > 1
      array_with_removed_first_token = tokens_array[1..-1]
      check_for_first_declaration(array_with_removed_first_token)
    end
  end
end

def check_for_first_declaration(tokens_array)
  token = tokens_array[0]
  if (token[:token] == "ELEMENT") || (token[:token] == "TEXT")
    if tokens_array.length > 1
      array_with_removed_first_token = tokens_array[1..-1]
      check_for_rest_declaration(array_with_removed_first_token)
    else
      raise "DUZO CI BRAKUJE"
    end
  else
    raise "ZLA DEKLARACJA"
  end
end

def check_for_rest_declaration(tokens_array)
  token = tokens_array[0]
  if token[:token] == "SCOLON"
    
    if tokens_array.length > 1
      array_with_removed_first_token = tokens_array[1..-1]
      check_declaration(array_with_removed_first_token)
    else
      raise "BRAK ELEMENTÓW PO SREDNIKU"
    end
  elsif (token[:token] == "ELEMENT") || (token[:token] == "TEXT")
    if tokens_array.length > 1
      array_with_removed_first_token = tokens_array[1..-1]
      check_for_rest_declaration(array_with_removed_first_token)
    else
      raise "DUZO CI BRAKUJE"
    end
  else
    raise "BRAK SREDNIKA"
  end
end

def get_next_token(array_of_structs)
  sliced_array_of_structs = array_of_structs[1..-1]
  next_token              = sliced_array_of_structs[0]
  next_token[:token]
end

def comma_selector_ocb
   
end
array_of_structs = Scanner.tokens_array('.container #lol{text-align:bartek monika dziala nie dziala;} container #lol{text-align:bartek monika dziala nie dziala;}')
puts check_for_undefined(array_of_structs)
puts start(array_of_structs)
# puts array_of_structs.inspect


