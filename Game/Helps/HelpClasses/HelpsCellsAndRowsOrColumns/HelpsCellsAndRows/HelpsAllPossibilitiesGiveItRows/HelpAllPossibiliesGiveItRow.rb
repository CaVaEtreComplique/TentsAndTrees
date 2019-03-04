require File.dirname(__FILE__) + "/../HelpCellsAndRows"

#Help for when all the possibilities of the row give a cell a certain state

class HelpAllPossibilitiesGiveItRow < HelpCellsAndRows
  public_class_method :new
  def initialize(cell, row, state)
    super(cell, row)
    @state = state
    puts "Test " + @state.to_s
  end

  def getText()
    @helpText = "Toutes les possibilités de la rangée " + @row.to_s + " font que la case a l'état " + @state.to_s + " Test"
  end
end
