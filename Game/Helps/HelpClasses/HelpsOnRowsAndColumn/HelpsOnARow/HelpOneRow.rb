#Helps whitch help for a row

require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn"

class HelpOneRow < HelpOnRowsAndColumn
  #help gave when player need a help by giving a row
  private_class_method :new  #abstract

  def initialize(row)
    super(row)
  end
end
