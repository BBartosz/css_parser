require './scanner'


class Parser2
  def initialize(array_of_tokens)
    array_to_parse = array_of_tokens.clone
    # check_for_undefined(array_to_parse)
    start(array_to_parse)
  end


  def start(array_of_tokens)
    stylesheet(array_of_tokens) 
  end

  def stylesheet(array_of_tokens)
    styled_selector(array_of_tokens) 
  end

  def styled_selector(array_of_tokens)
    selectors(array_of_tokens)
  end

  def selectors(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens)
    puts 'dupa'
    if selector?(token) && !sliced_array.empty?
      continuation_of_selectors(sliced_array)
    else
      raise "Error: Expecting selector"
    end
  end

  def continuation_of_selectors(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens)
    if comma?(token)
      selectors(sliced_array)
    elsif ocb?(token)
      parameters_block(sliced_array)
    else
      raise "Error: Expecting comma or ocb"
    end
  end

  def selector?(token)
    (token[:token] == 'ELEMENT') || (token[:token] == 'CLASS') || (token[:token] == 'ID')
  end

  def comma?(token)
    token[:token] == 'COMMA'
  end

  def ocb?(token)
    token[:token] == 'OCB'
  end

  




  def get_first_token(array_of_tokens)
    first_token = array_of_tokens[0]
    return first_token
  end

  def get_sliced_array(array_of_tokens)
    sliced_array = array_of_tokens[1..-1] 
    return sliced_array
  end
end