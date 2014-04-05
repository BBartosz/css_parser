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
    if array_of_tokens.length > 0
      styled_selector(array_of_tokens) 
    end
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
    sliced_array = get_sliced_array(array_of_tokens,1)
    
    if selector?(token) && sliced_array.length > 0
      continuation_of_selectors(sliced_array)     
    else
      raise "Error: Expecting selector or '{'"
    end
  end

  def continuation_of_selectors(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens, 1)
    if comma?(token)
      selectors(sliced_array)
    else
      puts 'Finished to skan selectors'
      return array_of_tokens
    end
  end

  def parameters_block(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens, 1)

    if ocb?(token) && sliced_array.length > 1
      parameters(sliced_array)
    else
      raise "Error: Missing '{'" if !ocb?(token)
      raise "Error: Missing parameters after '{'" if sliced_array.empty?
      raise "Error: Missing ':'" if sliced_array.length == 1
    end
  end

  def parameters(array_of_tokens)
    token1        = get_first_token(array_of_tokens)
    token2        = get_second_token(array_of_tokens)
    sliced_array  = get_sliced_array(array_of_tokens, 2) 

    if text?(token1) && colon?(token2) && !sliced_array.empty?
      values(sliced_array)
    else
      raise "Error: Expecting Text got #{token1}"  if !text?(token1)
      raise "Error: Expecting Colon got #{token2}" if !colon?(token2)
      raise "Error: Expecting values of the parameter" if sliced_array.empty?
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
    (token[:token] == 'TEXT') || (token[:token] == 'ELEMENT')
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

  def get_sliced_array(array_of_tokens, start_point)
    sliced_array = array_of_tokens[start_point..-1] 
    return sliced_array
  end
end