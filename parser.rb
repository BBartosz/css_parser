require './scanner'

class Parser
  def initialize(array_of_structs)
    array_to_parse = array_of_structs.clone
    check_for_undefined(array_to_parse)
    start(array_to_parse)
  end

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
      check_for_next_selector(sliced_array)
    else
      raise "BAD TOKEN: #{first_token}"
    end
  end

  def check_for_next_selector(tokens_array)
    token = tokens_array[0]

    if (token[:token] == "ELEMENT") || (token[:token] == "CLASS") || (token[:token] == "ID")
      
      if tokens_array.length > 1
        array_with_removed_first_token = tokens_array[1..-1]
        check_for_next_selector(array_with_removed_first_token) 
      end
    elsif token[:token] == 'OCB'
      array_with_removed_ocb = tokens_array[1..-1]
      check_declaration(array_with_removed_ocb)
    else
      raise "WRONG CSS MISSING { OR SELECTOR"
    end
  end

  def check_declaration(tokens_after_ocb)
    token = tokens_after_ocb[0]
    if (token[:token] == "ELEMENT") || (token[:token] == "TEXT")
      array_with_removed_first_token = tokens_after_ocb[1..-1]
      if array_with_removed_first_token.length > 0
        check_for_colon(array_with_removed_first_token)
      else
        raise "MISSING \":\""
      end
    elsif token[:token] == "CCB"
      if tokens_after_ocb.length > 1
        array_with_removed_first_token = tokens_after_ocb[1..-1]
        start(array_with_removed_first_token)
      else
        raise "PROPER CSS"
      end
    end
  end

  def check_for_semicolon(sliced_array)
    token = sliced_array[0]
    if token[:token] == 'SCOLON'
      if sliced_array.length > 1
        array_with_removed_first_token = sliced_array[1..-1]
        check_declaration(array_with_removed_first_token)
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
    else
      raise "BAD DECLARATION. WRONG TOKEN #{token}"
    end
  end

  def check_for_first_declaration(tokens_array)
    token = tokens_array[0]
    if (token[:token] == "ELEMENT") || (token[:token] == "TEXT") || (token[:token] == "COLOR") || (token[:token] == "URL")
      if tokens_array.length > 1
        array_with_removed_first_token = tokens_array[1..-1]
        check_for_rest_declaration(array_with_removed_first_token)
      end
    elsif token[:token] == "NUMBER"
      if tokens_array.length > 1
       array_with_removed_first_token = tokens_array[1..-1]
       check_for_unit(array_with_removed_first_token)
      end
    else
      raise "WRONG DECLARATION BODY BEFORE #{token}"
    end
  end

  def check_for_unit(tokens_array)
    token = tokens_array[0]
    if (token[:token] == "UNIT")
      if tokens_array.length > 1
        array_with_removed_first_token = tokens_array[1..-1]
        check_for_rest_declaration(array_with_removed_first_token)
      end
    else
      raise "ERROR MISSING UNIT AFTER NUMBER"
    end
  end

  def check_for_rest_declaration(tokens_array)
    token = tokens_array[0]
    if token[:token] == "SCOLON"
      if tokens_array.length > 1
        array_with_removed_first_token = tokens_array[1..-1]
        check_declaration(array_with_removed_first_token)
      end
    elsif (token[:token] == "ELEMENT") || (token[:token] == "TEXT") || (token[:token] == "COLOR") || (token[:token] == "URL")
      if tokens_array.length > 1
        array_with_removed_first_token = tokens_array[1..-1]
        check_for_rest_declaration(array_with_removed_first_token)
      end
    else
      raise "MISSING SEMICOLON"
    end
  end
end




