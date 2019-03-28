# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpAllPossibilitiesGiveItColumn.rb
# @Last modified by:   maxime
# @Last modified time: 28-Mar-2019


require File.dirname(__FILE__) + "/../HelpCellsAndColumns"

##
# The HelpAllPossibilitiesGiveItColumn class is inherited from the
# HelpCellsAndColumns class and helps when all the possibilities of the column
# can determine a cell's state. This class knows its initialization method and
# the getText method that sends text to the player when he/she needs help.
class HelpAllPossibilitiesGiveItColumn < HelpCellsAndColumns
#:nodoc:
  public_class_method :new
  #:startdoc:

  ##
  # The initialize method gives to the state variable a value from the method's
  # parameters and initializes the cell and the column in parameters with the
  # method from HelpCellsAndColumns.
  def initialize(cell, column, state)
    @state = state
    super(cell, column)
  end

  ##
  # The getText method sends the help text the player will see.
  # It returns the helpText variable, here the text that will be returned says
  # that all the column's possibilities give only one possible option for a
  # given cell.
  def getText(helpLevel)
    return @helpText = "Toutes les possibilités de la colonne " + @column[0].column.to_s + " font que la case " + @cell.to_s + " est a l'état " + @state.to_s
  end
end
