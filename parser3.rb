class Parser3
  def initialize(array_of_tokens)
    array_to_parse = array_of_tokens.clone
    check_for_undefined(array_to_parse)
    start(array_to_parse)
  end

  def check_for_undefined(array_of_tokens)
    array_of_tokens.each {|token| raise "#{token} is broken token" if token[:token] == "UNKNOWN"}
  end
  
  def start
    stylesheet(array_of_tokens)
  end

  def stylesheet(array_of_tokens)
    styled_selector 
    stylesheet
  end

  def styled_selectors(array_of_tokens)
    selectors(array_of_tokens)
    parameters_block(array_of_tokens)
  end

  def selectors(array_of_tokens)
    selector(array_of_tokens[0])
    continuation_of_selectors(array_of_tokens)
  end

  def selector(token)
    if (token[:token] == 'ELEMENT') || (token[:token] == 'CLASS') || (token[:token] == 'ID')
    else
      raise "Expecting selector"
    end
  end

  def continuation_of_selectors(array_of_tokens)
    if (token[:token] == 'COMMA')
      selector
    else
    end
  end

  def sliced_array
    
  end
end

