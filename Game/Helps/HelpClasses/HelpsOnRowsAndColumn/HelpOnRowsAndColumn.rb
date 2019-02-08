require File.dirname(__FILE__) + "/../Help"

class HelpOnRowsAndColumn
  private_class_methode :new
  def initialize(rowOrColumn)
    @column = rowOrColumn
    @row = rowOrColumn
    super()
  end
end
