require File.dirname(__FILE__) + "/../HelpCellsAndColumns"

class HelpAllPossibilitiesGiveItColumn < HelpCellsAndRowsOrColumns
  #Help for when all the possibilities of the row give a cell with a state

  public_class_method :new #Instanciable class
  def initialize(cell, column, state) #need a cell, a column, and the state you can set on the cell
    @state = state
    puts "Test " + @state.to_s
    super(cell, column)
  end

  def getText()
    #returns the text of the help, saying that all the possibilitieses of a column give the state of the cell
    return @helpText = "Toutes les possibilités de la colonne " + @row.to_s + " font que la case " + @cell.to_s + " est a l'état " + @state.to_s + " Test"
  end
end
