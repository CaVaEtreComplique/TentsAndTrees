# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: CellDontTouchTreeHelper.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019


require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnCells/HelpsOn1Cell/HelpsCellTooFarOfTrees/HelpCellTooFarOfTrees"
require File.dirname(__FILE__) + "/../FictivHelper"

##
# ===== Presentation
# The CellDontTouchTreeHelper class is a helper class inherited from FictivHelper.
# Its role is to find a cell whitch does not touch a tree.
#
# ===== Methods
# * +help+ - This method is inherited from FictivHelper, but definded there.
class CellDontTouchTreeHelper < FictivHelper

  public_class_method :new

   ##
   # ===== Presentation
   # This method tries to find a cell that is not touched by a tree.
   #
   # ===== Attributes
   # * +game+ - The game you want help for.
   #
   # ===== Returns
   # If it finds a cell that is not touched by a tree, returns a
   # HelpCellTooFarOfTrees instance If not, it returns a HelpNotFound instance.
   #
   # ===== How to use
   # To get help for a cell that is not touched by a tree :
   #    cellDontTouchTreeHelper_instace.help(theGameYouWantHelpFor)
   # -----------
  def help(game)

    white = game.white()
    game = game.game()

    white.each() do |cell|
      x = cell.row
      y = cell.column

      if( (x + 1 >= game.nRow || !(game.cellAt(x + 1, y).isATree?)) &&
      (x - 1 < 0 || !(game.cellAt(x - 1, y).isATree?)) &&
      (y + 1 >= game.nCol || !(game.cellAt(x, y + 1).isATree?)) &&
      (y - 1 < 0 || !(game.cellAt(x, y - 1).isATree?)) )
        #If the cell is white dont touch a tree
        return HelpCellTooFarOfTrees.new(cell)
      end
    end

    return HelpNotFound.new()
  end

end
