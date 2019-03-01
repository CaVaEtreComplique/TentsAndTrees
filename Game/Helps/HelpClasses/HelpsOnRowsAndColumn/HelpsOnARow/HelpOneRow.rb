#Helps whitch help for a row

require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn"

class HelpOneRow < HelpOnRowsAndColumn
  private_class_method :new  #abstract

  def initialize(row)
    super(row)
  end
end
