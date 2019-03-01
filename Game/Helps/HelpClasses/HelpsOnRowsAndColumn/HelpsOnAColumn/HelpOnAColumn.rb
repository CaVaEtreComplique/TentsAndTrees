require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn"

class HelpOnAColumn < HelpOnRowsAndColumn
  #private_class_methode :new  #abstract
  def initialize(column)
    super(column)
  end
end
