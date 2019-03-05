

require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

class HelpCellsAndColumns < HelpCellsAndRowsOrColumns
  #abstract class

  def initialize(cell, column)
    super(cell, column)
  end
end
