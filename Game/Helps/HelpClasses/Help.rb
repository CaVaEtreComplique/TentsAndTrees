#class Help, which contain a String text to explain the help, a column, a row

class Help
  private_class_methode :new  #abstract

  def initialize()
    @helpText = self.helpText
  end

  attr_reader :helpText

  alias :to_s :helpText

  def helpFound?()
    return true
  end

  def getText()
    @helpText = "Txt not Available"
  end
end
