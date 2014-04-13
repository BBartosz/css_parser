require './helper'
include Helper

class Parser3
  def initialize(scanner)
    @scanner = scanner
    @token   = @scanner.next_token
  end

  def take_token(token_type)
    if @token[:token] != token_type
      raise "Missing token: %s" % token_type
    end

    if token_type == 'CCB' && !@scanner.more_tokens?
      return
    end

    @token = @scanner.next_token
  end

  def check_for_undefined(array_of_tokens)
    array_of_tokens.each {|token| raise "#{token} is broken token" if token[:token] == "UNKNOWN"}
  end
  
  def start
    stylesheet
  end
 
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
    if element?(@token)
      take_token('ELEMENT')
    elsif class?(@token)
      take_token('CLASS')
    elsif id?(@token)
      take_token('ID')
    else
      raise "Expecting selector, got #{@token}"
    end
  end

  def continuation_of_selectors
    if comma?(@token)
      take_token('COMMA')
      selectors
    end
  end

  def parameters_block
    take_token('OCB')
    parameters
    take_token('CCB')
  end

  def parameters
    parameter
    more_parameters
  end

  def parameter
    if text?(@token) 
      take_token('TEXT')
    elsif element?(@token)
      take_token('ELEMENT')
    else 
      return
    end

    take_token('COLON')
    values 
    take_token('SCOLON')
  end

  def more_parameters
    if text?(@token) || element?(@token)
      parameters
    end
  end

  def values
    value
    rest_values
  end

  def value
    if text?(@token)
      take_token('TEXT')
    elsif element?(@token)
      take_token('ELEMENT')
    elsif url?(@token)
      take_token('URL')
    elsif unit?(@token)
      take_token('UNIT')
    elsif color?(@token)
      take_token('COLOR')
    elsif number?(@token)
      take_token('NUMBER')
    else
      raise "Expecting value, got #{@token}"
    end
  end

  def rest_values
    if value?(@token)
      values
    end
  end
end

