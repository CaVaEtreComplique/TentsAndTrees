

require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

class HelpCellsAndColumns < HelpCellsAndRowsOrColumns
  #private_class_methode :new  #abstract

  def initialize(cell, column)
    super(cell, column)
  end
end
