#A helper whitch help the player to place grass in cells that touch tents
require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnCells/HelpsOn2Cells/HelpsOnACellTouchATent/HelpOnACellTouchATent"
require File.dirname(__FILE__) + "/../FictivHelper"

class CellTouchATentHelper < FictivHelper

public_class_method :new

  def help(game)

    white = game.white()
    game = game.game()

    white.each() do |cell|
      x = cell.row
      y = cell.column

      #If the cell touch in + a tent:
      if (x+1 < game.nCol && game.cellAt(x+1, y).isATent?)
        return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x+1, y))
      elsif (x-1 >= 0 && game.cellAt(x-1, y).isATent?)
        return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x-1, y))
      elsif (y+1 < game.nCol && game.cellAt(x, y+1).isATent?)
        return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x, y+1))
      elsif (y-1 >= 0 && game.cellAt(x, y-1).isATent?)
        return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x, y-1))
      end

      #If the cell is white and touch a tent -in X, not +-
      if(y-1 >= 0 && x-1 >= 0 && game.cellAt(x-1, y-1).isATent?)
        return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x-1, y-1))
      elsif(y-1 >= 0 && x+1 < game.nCol && game.cellAt(x+1, y-1).isATent?)
        return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x+1, y-1))
      elsif(y+1 < game.nCol && x+1 < game.nCol && game.cellAt(x+1, y+1).isATent?)
        return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x+1, y+1))
      elsif(y+1 < game.nCol && x-1 >= 0  && game.cellAt(x-1, y+1).isATent?)
        return HelpOnACellTouchATent.new(game.cellAt(x, y), game.cellAt(x-1, y+1))
      end

    end
    return HelpNotFound.new()

  end
end
