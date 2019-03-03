

require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

class HelpCellsAndRows < HelpCellsAndRowsOrColumns
  #private_class_method :new  #abstract

  def initialize(cell, row)
    super(cell, row)
  end
end
