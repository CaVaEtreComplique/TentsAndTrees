# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpAllPossibilitiesGiveItColumn.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpCellsAndColumns"

class HelpAllPossibilitiesGiveItColumn < HelpCellsAndColumns
  #Help for when all the possibilities of the row give a cell with a state

  public_class_method :new #Instanciable class
  def initialize(cell, column, state) #need a cell, a column, and the state you can set on the cell
    @state = state
    super(cell, column)
  end

  def getText()
    #returns the text of the help, saying that all the possibilitieses of a column give the state of the cell
    return @helpText = "Toutes les possibilités de la colonne " + @row.to_s + " font que la case " + @cell.to_s + " est a l'état " + @state.to_s
  end
end
