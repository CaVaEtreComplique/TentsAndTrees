#class Help, which contain a String text to explain the help, a column, a row

class Help
  private_class_methode :new

  def initialize()
    @helpText = self.helpText
  end

  attr_reader :row, :column, :cell, :text

  def to_s
    return text
  end

  def helpFound?()
    return true
  end

  def getText()
    @helpText = "Txt not Available"
  end
end
