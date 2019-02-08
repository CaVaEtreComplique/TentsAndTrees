require File.dirname(__FILE__) + "/../Help"

class HelpCellsAndRowsOrColumns < Help
  def initialize(cell, rowOrColumn)
    Super()
    @column = rowOrColumn
    @cell = rowOrColumn
    @row = row
  end
end
