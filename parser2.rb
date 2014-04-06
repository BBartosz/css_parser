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
    if !array_of_tokens.empty?
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
    sliced_array = get_sliced_array(array_of_tokens, 1, 0, "Error: Expecting '{'")
    
    if selector?(token)
      continuation_of_selectors(sliced_array)     
    else
      raise "Error: Expecting selector"
    end
  end

  def continuation_of_selectors(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens, 1, 0, '')
    if comma?(token)
      selectors(sliced_array)
    else
      puts 'Finished to skan selectors'
      return array_of_tokens
    end
  end

  def parameters_block(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens, 1, 1, "Error: Missing ':'")

    if ocb?(token)
      parameters(sliced_array)
    else
      raise "Error: Missing '{'" if !ocb?(token)
      raise "Error: Missing parameters after '{'" if sliced_array.empty?
    end
  end

  def parameters(array_of_tokens)
    token1       = get_first_token(array_of_tokens)
    return stylesheet(get_sliced_array(array_of_tokens, 1, 0, '')) if ccb?(token1)
    token2       = get_second_token(array_of_tokens)
    token3       = get_third_token(array_of_tokens) 
    sliced_array = get_sliced_array(array_of_tokens, 2, 0, "Error: Expecting values of the parameter")

    if text?(token1) && colon?(token2) && value?(token3)
      values(sliced_array)
    else
      raise "Error: Expecting Text got #{token1}"  if !text?(token1)
      raise "Error: Expecting Colon got #{token2}" if !colon?(token2)
      raise "Error: Expecting Value after Colon"   if !value?(token3)
    end
  end

  def values(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens, 1, 1, "Error: Expecting value")

    if value?(token)
      values(sliced_array)
    elsif semicolon?(token)
      parameters(sliced_array)
    elsif ccb?(token)
      stylesheet(sliced_array)
    end
  end

  def check_for_ccb(array_of_tokens)
    token        = get_first_token(array_of_tokens)
    sliced_array = get_sliced_array(array_of_tokens, 1, 1, "Error: Expecting }")
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

  def ccb?(token)
    token[:token] == 'CCB'
  end

  def text?(token)
    (token[:token] == 'TEXT') || (token[:token] == 'ELEMENT')
  end

  def colon?(token)
    token[:token] == 'COLON'
  end

  def semicolon?(token)
    token[:token] == 'SCOLON'
  end

  def value?(token)
    (token[:token] == "ELEMENT") || (token[:token] == "TEXT") || (token[:token] == "COLOR") || (token[:token] == "URL") || (token[:token] == "UNIT")
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

  def get_third_token(array_of_tokens)
    third_token = array_of_tokens[2]
    return third_token
  end

  def get_sliced_array(array_of_tokens, start_point, minimal_length, error_msg)
    if array_of_tokens.length > minimal_length
      sliced_array = array_of_tokens[start_point..-1] 
      return sliced_array
    else 
      raise error_msg
    end 
  end
end