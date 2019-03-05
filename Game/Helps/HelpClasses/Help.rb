#class Help, which contain a String text to explain the help
#this class is abstract
require_all(__FILE__)
class Help
  #parent of all helps, used any time when you ask a help
  private_class_method :new  #abstract class

  def initialize()
    #initialize the help text as what it need to be
    @helpText = self.getText
  end

  attr_reader :helpText

  def helpFound?()
    #return true if a help has been found, else return false
    return true
  end

  def getText()
    #retrun the text for the help
    return "Txt not Available"
  end

  def to_s
    return @helpText + "\n"
  end
end
