require File.dirname(__FILE__) + "/../Help"

class HelpOnRowsAndColumn < Help
  private_class_methode :new  #abstract
  def initialize(rowOrColumn)
    @column = rowOrColumn
    @row = rowOrColumn
    super()
  end
end
