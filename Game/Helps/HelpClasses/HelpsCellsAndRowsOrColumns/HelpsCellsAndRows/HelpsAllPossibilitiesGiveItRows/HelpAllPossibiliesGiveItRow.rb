# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpAllPossibilitiesGiveItRow.rb
# @Last modified by:   Sckylle
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpCellsAndRows"

##
# ===== Presentation
# The HelpAllPossibilitiesGiveItRow class is inherited from the
# HelpCellsAndRows class and helps when all the possibilities of the row
# can determine a cell's state. This class knows its initialization method and
# the getText method that sends text to the player when he/she needs help.
class HelpAllPossibilitiesGiveItRow < HelpCellsAndRows

   #:nodoc:
  public_class_method :new
  #:startdoc:

 ##
 # ===== Presentation
 # The initialize method gives to the state variable a value from the method's
 # parameters and initializes the cell and the row in parameters with the
 # method from HelpCellsAndColumns.
  def initialize(cell, row, state)
    @state = state
    super(cell, row)
  end

  ##
  # ===== Presentation
  # The getText method sends the help text the player will see.
  # It returns the helpText variable that changes depending on the helpLevel the
  # player is at.
  #
  # ===== Examples
  # On level 1, the help says that a row leaves only one possible state for
  # a cell (only the row is given).
  #
  # On level 2, the help says that a row leaves an obligatory state for one of
  # the cells (the row and the state are given).
  #
  # On level 3, the help tells the player that all the possibilities from a row
  # only leave one state for a cell (the row, the state and the cell are given).
  def getText(helpLevel) #allpossibilitiesrow

    case(helpLevel)
      when 1
        @helpText = @textManager.getHelpsTexts("allpossibilitiesrow", helpLevel, 0) + @column[0].getVisualRankColumn.to_s
      when 2
        @helpText = @textManager.getHelpsTexts("allpossibilitiesrow", helpLevel, 0) + @column[0].getVisualRankColumn.to_s + @textManager.getHelpsTexts("allpossibilitiesrow", helpLevel, 1) +  @state.to_s + @textManager.getHelpsTexts("allpossibilitiesrow", helpLevel, 2)
      when 3
        @helpText = @textManager.getHelpsTexts("allpossibilitiesrow", helpLevel, 0) + @column[0].getVisualRankColumn.to_s + @textManager.getHelpsTexts("allpossibilitiesrow", helpLevel, 1) + @cell.to_s + @textManager.getHelpsTexts("allpossibilitiesrow", helpLevel, 2) + @state.to_s
      else
          super(helpLevel)
      end
  end
end
