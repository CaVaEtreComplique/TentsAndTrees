require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn"

class HelpOnAColumn < HelpOnRowsAndColumn
  #helps player when we need to give a column 
  private_class_method :new  #abstract class
  def initialize(column)
    super(column)
  end
end
