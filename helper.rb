module Helper
  def selector?(token)
    (token[:token] == 'ELEMENT') || (token[:token] == 'CLASS') || (token[:token] == 'ID')
  end

  def comma?(token)
    token[:token] == 'COMMA'
  end

  def element?(token)
    token[:token] == 'ELEMENT'
  end

  def class?(token)
    token[:token] == 'CLASS'
  end

  def id?(token)
    token[:token] == 'ID'
  end

  def url?(token)
    token[:token] == 'URL'
  end

  def unit?(token)
    token[:token] == 'UNIT'
  end

  def color?(token)
    token[:token] == 'COLOR'
  end

  def number?(token)
    token[:token] == 'NUMBER'
  end

  def ocb?(token)
    token[:token] == 'OCB'
  end

  def ccb?(token)
    token[:token] == 'CCB'
  end

  def text?(token)
    (token[:token] == 'TEXT')
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
end