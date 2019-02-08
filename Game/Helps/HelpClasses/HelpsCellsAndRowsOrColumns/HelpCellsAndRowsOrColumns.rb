require File.dirname(__FILE__) + "/../Help"

class HelpCellsAndRowsOrColumns < Help
  private_class_methode :new  #abstract
  def initialize(cell, rowOrColumn)
    super()
    @column = rowOrColumn
    @cell = rowOrColumn
    @row = row
  end
end
