require File.dirname(__FILE__) + "/../Help"

class HelpCellsAndRowsOrColumns < Help
  #Abstract class
  #class helping for helps about cells and column or row
  def initialize(cell, rowOrColumn)
    @column = rowOrColumn
    @cell = cell
    @row = rowOrColumn
    super()
  end
end
