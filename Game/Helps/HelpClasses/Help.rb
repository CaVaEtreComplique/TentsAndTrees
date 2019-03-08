require_all(__FILE__)
##
#The help class is an abstract class which contains a String to explain the
#help. It contains the methods helpFound? and getText and they act on the help
#text.
class Help
  # :nodoc:
  #Parent of all helps, used any time when you ask for help.
  private_class_method :new  #abstract class

  # :startdoc:
  # The class' constructor.
  def initialize()
    #Initializes the help text as what it needs to be.
    @helpText = self.getText
  end

  # :nodoc:
  attr_reader :helpText
  # :startdoc:

  # This tries to find the necessary help.
  # ===== Returns
  # Returns true if help has been found, else it returns false.
  # --------------
  def helpFound?()
    return true
  end

  # This method fetches the help text.
  # ===== Returns
  # Returns the help text.
  # ---------
  def getText()
    return "Txt not Available"
  end

  # This method prints the help text.
  # -----------
  def to_s
    return @helpText + "\n"
  end
end
