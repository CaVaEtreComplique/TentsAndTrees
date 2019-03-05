require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnCells/HelpsOn1Cell/HelpsCellTooFarOfTrees/HelpCellTooFarOfTrees"
require File.dirname(__FILE__) + "/../FictivHelper"

class CellDontTouchTreeHelper < FictivHelper

  public_class_method :new

  def help(game)

    #puts(game.cellAt(0, 5).state.to_s)

    (0...game.nCol).each{ |x|
      (0...game.nRow).each{ |y|
          if((game.cellAt(x, y).isAWhite?) &&
              (x+1 >= game.nCol || !(game.cellAt(x+1, y).isATree?)) &&
              (x-1 < 0 || !(game.cellAt(x-1, y).isATree?)) &&
              (y+1 >= game.nCol || !(game.cellAt(x, y+1).isATree?)) &&
              (y-1 < 0 || !(game.cellAt(x, y-1).isATree?) ))
              #If the cell is white dont touch a tree

              return HelpCellTooFarOfTrees.new(game.cellAt(x,y))
          end
      }
    }
    return HelpNotFound.new()
  end
end
