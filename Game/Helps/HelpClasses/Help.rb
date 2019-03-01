#class Help, which contain a String text to explain the help, a column, a row
require_all(__FILE__)
class Help
  #private_class_methode :new  #abstract

  def initialize()
    @helpText = self.getText
    p self.class.to_s + "initialise"
  end

  attr_reader :helpText

  alias :to_s :helpText

  def helpFound?()
    return true
  end

  def getText()
    "Txt not Available"
  end

  def to_s
    p "ici"
    return @helpText
  end
end
