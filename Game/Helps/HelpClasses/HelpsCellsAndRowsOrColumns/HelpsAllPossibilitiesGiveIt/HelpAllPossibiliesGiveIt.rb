require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

class HelpAllPossibilitiesGiveIt < HelpCellsAndRowsOrColumns
  def initialize(cell, row)
    super(cell, row, state)
  end
  def getText()
    return "Toutes les possibilités de la rangée "+ row +" font que la case a l'état "+state
  end
end
