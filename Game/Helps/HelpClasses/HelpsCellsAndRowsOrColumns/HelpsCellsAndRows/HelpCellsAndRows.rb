require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

class HelpCellsAndRows < HelpCellsAndRowsOrColumns
  #abstract class
  #help about a cell and a row

  def initialize(cell, row)
    super(cell, row)
  end
end
