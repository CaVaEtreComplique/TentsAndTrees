require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn"

class HelpOnAColumn < HelpOnRowsAndColumn
  private_class_method :new  #abstract
  def initialize(column)
    super(column)
  end
end
