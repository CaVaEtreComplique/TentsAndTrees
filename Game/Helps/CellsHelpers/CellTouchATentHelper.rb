#A helper whitch help the player to place grass in cells whitch touch tents
require File.dirname(__FILE__) + "/../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../HelpClasses/HelpsOnCells/HelpsOn2Cells/HelpsOnACellTouchATent/HelpOnACellTouchATent"

class CellTouchATentHelper
  def CellTouchATentHelper.help(game)
    (0...game.nCol).each{ |x|
      (0...game.nRow).each{ |y|
          if(game.cellAt(x, y).isAWhite?)
            #if the cell touch in + a tent:
                if(x+1 < game.nCol && game.cellAt(x+1, y).isATent?)
                  return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x+1, y))
                end
                if(x-1 >= 0 && game.cellAt(x-1, y).isATent?)
                  return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x-1, y))
                end
                if(y+1 < game.nCol && game.cellAt(x, y+1).isATent?)
                  return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x, y+1))
                end
                if(y-1 >= 0 && game.cellAt(x, y-1).isATent?)
                  return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x, y-1))
                end

                #If the cell is white and touch a tent -in X, not +-
                p "ici"
                if(y-1 >= 0 && x-1 >= 0 && game.cellAt(x-1, y-1).isATent?)
                  return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x-1, y-1))
                end
                if(y-1 >= 0 && x+1 < game.nCol && game.cellAt(x+1, y-1).isATent?)
                  return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x+1, y-1))
                end
                if(y+1 < game.nCol && x+1 < game.nCol && game.cellAt(x+1, y+1).isATent?)
                  return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x+1, y+1))
                end
                if(y+1 < game.nCol && x-1 >= 0  && game.cellAt(x-1, y+1).isATent?)
                  return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x-1, y+1))
                end
          end
      }
    }
    return HelpNotFound.new()
  end
end
