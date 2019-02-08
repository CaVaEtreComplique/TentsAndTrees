require File.dirname(__FILE__) + "/../Game"

class CellDontTouchTreeHelper
  def CellDontTouchTreeHelper.help(game)
    (0..game.nCol).each{ |x|
      (0..game.nRow).each{ |y|
        begin
          if((game.cellAt(x, y).state == (state: :white)) &&
              !(game.cellAt(x+1, y).state == (state: :tree)) &&
              !(game.cellAt(x-1, y).state == (state: :tree))&&
              !(game.cellAt(x, y+1).state == (state: :tree)) &&
              !(game.cellAt(x, y-1).state == (state: :tree)) )
              {#If the cell is white dont touch a tree
                return HelpCellTooFarOfTrees.new(game.cellAt(x, y))
              }
          end
        rescue
          ##We are out of the grid
        end
      }
    }
    return HelpNotFound.new()
  end
end
