require File.dirname(__FILE__) + "/../Game"

class CellDontTouchTreeHelper
  def CellDontTouchTreeHelper.help(game)
    (0..game.nCol).each{ |x|
      (0..game.nRow).each{ |y|
        begin
          if((game.cellAt(x, y).state == (state: :white)) &&
              !(game.cellAt(x+1, y).isATree?) &&
              !(game.cellAt(x-1, y).isATree?)&&
              !(game.cellAt(x, y+1).isATree?) &&
              !(game.cellAt(x, y-1).isATree?) )
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
