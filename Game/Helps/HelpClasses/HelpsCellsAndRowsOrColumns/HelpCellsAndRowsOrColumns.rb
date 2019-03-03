require File.dirname(__FILE__) + "/../Help"

class HelpCellsAndRowsOrColumns < Help
  #private_class_method :new  #abstract
  def initialize(cell, rowOrColumn)
    @column = rowOrColumn
    @cell = cell
    @row = rowOrColumn
    super()
  end
end
