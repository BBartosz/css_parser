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
    if selector_first?(array_of_tokens)
      sliced_array = selectors(array_of_tokens)
      parameters_block(sliced_array)
    else
      raise "Error: First token must be selector"
    end
  end

  def selectors(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens)
    
    if selector?(token) && sliced_array.length > 0
      continuation_of_selectors(sliced_array)     
    else
      raise "Error: Expecting selector or '{'"
    end
  end

  def continuation_of_selectors(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens)
    if comma?(token)
      selectors(sliced_array)
    else
      puts 'Finished to skan selectors'
      return array_of_tokens
    end
  end

  def parameters_block(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens)

    if ocb?(token) && !sliced_array.empty?
      parameters(sliced_array)
    else
      raise "Error: Missing '{'" if !ocb?(token)
      raise "Error: Missing parameters after '{'" if sliced_array.empty?
    end
  end

  def parameters(array_of_tokens)
    token1        = get_first_token(array_of_tokens)
    token2        = get_second_token(array_of_tokens)
    sliced_array  = get_sliced_array(array_of_tokens)

    if text?(token1) && colon?(token2)
      values(sliced_array)
    else
      raise "Error: Expecting TEXT COLON got #{token1} and #{token2}"
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

  def text?(token)
    token[:token] == 'TEXT'
  end

  def colon?(token)
    token[:token] == 'COLON'
  end

  def selector_first?(array_of_tokens)
    first_token = get_first_token(array_of_tokens)
    if selector?(first_token)
      return true
    else
      return false
    end
  end

  def get_first_token(array_of_tokens)
    first_token = array_of_tokens[0]
    return first_token
  end

  def get_second_token(array_of_tokens)
    second_token = array_of_tokens[1]
    return second_token
  end

  def get_sliced_array(array_of_tokens)
    sliced_array = array_of_tokens[1..-1] 
    return sliced_array
  end
end