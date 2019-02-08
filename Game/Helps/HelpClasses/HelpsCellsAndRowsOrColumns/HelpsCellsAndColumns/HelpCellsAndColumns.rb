require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

class HelpCellsAndColumns < HelpCellsAndRowsOrColumns
  private_class_methode :new  #abstract
  def initialize(column, cell)
    super(column, cell)
  end
end
