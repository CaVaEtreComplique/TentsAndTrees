# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpAllPossibilitiesGiveItRow.rb
# @Last modified by:   maxime
# @Last modified time: 29-Mar-2019

require File.dirname(__FILE__) + "/../HelpCellsAndRows"

##
# The HelpAllPossibilitiesGiveItRow class is inherited from the
# HelpCellsAndRows class and helps when all the possibilities of the row
# can determine a cell's state. This class knows its initialization method and
# the getText method that sends text to the player when he/she needs help.
class HelpAllPossibilitiesGiveItRow < HelpCellsAndRows

   #:nodoc:
  public_class_method :new
  #:startdoc:

 ##
 # The initialize method gives to the state variable a value from the method's
 # parameters and initializes the cell and the row in parameters with the
 # method from HelpCellsAndColumns.
  def initialize(cell, row, state)
    @state = state
    super(cell, row)
  end

  ##
  # The getText method sends the help text the player will see.
  # It returns the helpText variable that changes depending on the helpLevel the
  # player is at.
  # ===== Examples
  # On level 1, the help says that a row leaves only one possible state for
  # a cell (only the row is given).
  #
  # On level 2, the help says that a row leaves an obligatory state for one of
  # the cells (the row and the state are given).
  #
  # On level 3, the help tells the player that all the possibilities from a row
  # only leave one state for a cell (the row, the state and the cell are given).
  def getText(helpLevel)
    case(helpLevel)
      when 1
        @helpText = "La ligne " + @column[0].column.to_s + " donne une possibilité unique pour une case"
      when 2
        @helpText = "La ligne " + @column[0].column.to_s + " donne une case " +  @state.to_s + " obligatoire"
      when 3
        @helpText = "Toutes les possibilités de la rangée " + @row[0].row.to_s + " font que la case " + @cell.to_s + " est a l'état " + @state.to_s
      else
          super(helpLevel)
      end
  end
end
