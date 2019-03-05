require File.dirname(__FILE__) + "/../HelpCellsAndRows"

class HelpAllPossibilitiesGiveItRow < HelpCellsAndRows
  #Help for when all the possibilities of the row give a cell a certain state
  public_class_method :new #instanciable
  def initialize(cell, row, state)
    super(cell, row)
    @state = state
    puts "Test " + @state.to_s
  end

  def getText()
    #returns the text of the help, saying that all the possibilitieses of a row give the state of the cell
    @helpText = "Toutes les possibilités de la rangée " + @row.to_s + " font que la case a l'état " + @state.to_s + " Test"
  end
end
