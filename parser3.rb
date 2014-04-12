class Parser3
  def initialize(scanner)
    @scanner    = scanner
    @token      = @scanner.next_token
  end

  def take_token(token_type)
    if @token[:token] != token_type
      raise "Unexpected token: %s" % token_type
    end

    if token_type != 'CCB'
      @token = @scanner.next_token
    end
  end

  def check_for_undefined(array_of_tokens)
    array_of_tokens.each {|token| raise "#{token} is broken token" if token[:token] == "UNKNOWN"}
  end
  
  def start
    stylesheet
  end
# stylesheet => styled_selector  
  def stylesheet
    styled_selector
    stylesheet
  end

  def styled_selector
    selectors
    # parameters_block
  end

  def selectors
    selector
    continuation_of_selectors
  end

  def selector
    if (@token[:token] == 'ELEMENT') || (@token[:token] == 'CLASS') || (@token[:token] == 'ID')
      take_token('CLASS')
    else
      raise "Expecting selector"
    end
  end

  def continuation_of_selectors
    if (@token[:token] == 'COMMA')
      take_token('COMMA')
      selector
    else
    end
  end

  def parameters_block
    return
  end
end

