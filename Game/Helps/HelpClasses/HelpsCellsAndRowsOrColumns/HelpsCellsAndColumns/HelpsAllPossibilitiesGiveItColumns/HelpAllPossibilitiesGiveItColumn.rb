# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpAllPossibilitiesGiveItColumn.rb
# @Last modified by:   maxime
# @Last modified time: 29-Mar-2019


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
  # ===== Attributes
  # * +cell+ : The cell the player needs help with.
  # * +column+ : The column the player needs help with.
  # * +state+ : The obvious state for the cell, in order to show it to the player.
  def initialize(cell, column, state)
    @state = state
    super(cell, column)
  end

  ##
  # The getText method sends the help text the player will see.
  # ===== Attributes
  # * +helpLevel+ : Depending on this attribute, the help will be more or less precise.
  # ===== Examples
  # If the help's level is 1, this method will tell the player that the given
  # row leaves only one state possible for one of the cells (without giving the
  # cell, only telling the row).
  #
  # On level 2, this method will tell the player the
  # column and the state for one of the cells (without telling the cell, only the
  # column and the state).
  #
  # On level 3, the column, the cell and the state will be given.
  def getText(helpLevel)
    case(helpLevel)
      when 1
        @helpText = "La colonne " + @column[0].column.to_s + " donne une possibilité unique pour une case"
      when 2
        @helpText = "La colonne " + @column[0].column.to_s + " donne une case " +  @state.to_s + " obligatoire"
      when 3
        @helpText = "Toutes les possibilités de la colonne " + @column[0].column.to_s + " font que la case " + @cell.to_s + " est a l'état " + @state.to_s
      else
          super(helpLevel)
      end
  end
end
