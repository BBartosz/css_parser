class Parser3
  def initialize(scanner)
    @scanner = scanner
    @token   = @scanner.next_token
  end

  def take_token(token_type)
    if @token[:token] != token_type
      raise "Missing token: %s" % token_type
    end
    @token = @scanner.next_token
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
    stylesheets
  end

  def styled_selector
    selectors
    parameters_block
  end

  def stylesheets
    if selector?(@token)
      stylesheet
    end
  end

  def selectors
    selector
    continuation_of_selectors
  end

  def selector
    if (@token[:token] == 'ELEMENT')
      take_token('ELEMENT')
    elsif (@token[:token] == 'CLASS')
      take_token('CLASS')
    elsif (@token[:token] == 'ID')
      take_token('ID')
    else
      raise "Expecting selector, got #{@token}"
    end
  end

  def continuation_of_selectors
    if (@token[:token] == 'COMMA')
      take_token('COMMA')
      selectors
    end
  end

  def parameters_block
    take_token('OCB')
    parameters
    puts @token
    take_token('CCB')
  end

  def parameters
    parameter
    another_parameters
  end

  def parameter
    if @token[:token] == 'TEXT' 
      take_token('TEXT')
    elsif @token[:token] == 'ELEMENT'
      take_token('ELEMENT')
    end

    take_token('COLON')
    values 
    take_token('SCOLON')
  end

  def another_parameters
    if @token[:token] == 'TEXT'
      take_token('TEXT')
      parameter
    elsif @token[:token] == 'ELEMENT'
      take_token('ELEMENT')
      parameter
    end
  end

  def values
    value
    rest_values
  end

  def value
    if @token[:token] == 'TEXT'
      take_token('TEXT')
    elsif @token[:token] == 'ELEMENT'
      take_token('ELEMENT')
    elsif @token[:token] == 'URL'
      take_token('URL')
    elsif @token[:token] == 'UNIT'
      take_token('UNIT')
    elsif @token[:token] == 'COLOR'
      take_token('COLOR')
    elsif @token[:token] == 'NUMBER'
      take_token('NUMBER')
    else
      raise "Expecting value, got #{@token}"
    end
  end

  def rest_values
    if @token[:token] == 'TEXT'
      take_token('TEXT')
      rest_values
    elsif @token[:token] == 'ELEMENT'
      take_token('ELEMENT')
      rest_values
    elsif @token[:token] == 'URL'
      take_token('URL')
      rest_values
    elsif @token[:token] == 'UNIT'
      take_token('UNIT')
      rest_values
    elsif @token[:token] == 'COLOR'
      take_token('COLOR')
      rest_values
    elsif @token[:token] == 'NUMBER'
      take_token('NUMBER')
      rest_values
    end
  end

  def selector?(token)
    (token[:token] == 'ELEMENT') || (token[:token] == 'CLASS') || (token[:token] == 'ID')
  end
end

