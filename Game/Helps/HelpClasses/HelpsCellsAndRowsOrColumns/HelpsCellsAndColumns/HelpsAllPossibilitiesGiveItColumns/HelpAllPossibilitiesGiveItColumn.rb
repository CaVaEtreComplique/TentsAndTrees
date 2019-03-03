require File.dirname(__FILE__) + "/../HelpCellsAndColumns"

#Help for when all the possibilities of the row give a cell with a state

class HelpAllPossibilitiesGiveItColumn < HelpCellsAndRowsOrColumns
  def initialize(cell, column, state)
    super(cell, column)
    @state = state
    puts "Test " + @state.to_s
  end

  def getText()
    @helpText = "Toutes les possibilités de la colonne " + @row.to_s + " font que la case a l'état " +  @state.to_s + " Test"
  end
end
