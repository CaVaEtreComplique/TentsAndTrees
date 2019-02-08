require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

class HelpCellsAndRows < HelpCellsAndRowsOrColumns
  private_class_methode :new  #abstract
  def initialize(row, cell)
    super(row, cell)
  end
end
