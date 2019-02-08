require File.dirname(__FILE__) + "/../HelpCellsAndRows"

#Help for when all the possibilities of the row give a cell with a state

class HelpAllPossibilitiesGiveItRow < HelpCellsAndRows
  def initialize(cell, row, state)
    super(cell, row)
    @state = state
  end
  def getText()
    return "Toutes les possibilités de la rangée "+ row +" font que la case a l'état "+state
  end
end
