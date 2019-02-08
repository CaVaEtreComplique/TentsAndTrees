#class Help, which contain a String text to explain the help, a column, a row

class Help
  private_class_methode :new

  def initialize()
    @helpText = self.helpText
  end

  attr_reader :text

  alias :to_s :text

  def helpFound?()
    return true
  end

  def getText()
    @helpText = "Txt not Available"
  end
end
