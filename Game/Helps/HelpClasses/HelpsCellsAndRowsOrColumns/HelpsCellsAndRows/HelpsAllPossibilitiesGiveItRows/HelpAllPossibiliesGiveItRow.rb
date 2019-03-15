# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpAllPossibilitiesGiveItRow.rb
# @Last modified by:   Sckylle
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpCellsAndRows"

class HelpAllPossibilitiesGiveItRow < HelpCellsAndRows
  #Help for when all the possibilities of the row give a cell a certain state
  public_class_method :new #instanciable
  def initialize(cell, row, state)
    @state = state
    super(cell, row)
  end

  def getText()
    #returns the text of the help, saying that all the possibilitieses of a row give the state of the cell
    @helpText = "Toutes les possibilités de la rangée " + @row.to_s + " font que la case " + @cell.to_s + " est a l'état " + @state.to_s
  end
end
