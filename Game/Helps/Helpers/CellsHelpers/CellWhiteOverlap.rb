# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: CellWhiteOverlap.rb
# @Last modified by:   Sckylle
# @Last modified time: 15-Mar-2019



#A helper whitch help the player to place grass in cells that touch tents
require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnCells/HelpsOn3Cells/HelpsOnACellOverlap/HelpsOnACellOverlap"
require File.dirname(__FILE__) + "/../FictivHelper"

class CellWhiteOverlap < FictivHelper

public_class_method :new

  def help(game)

    tree = game.tree()
    game = game.game()

    tree.each do |cell|
      north = south = est = west = false

      compt = 0

      cellV = if cell.row + 1 < game.nCol then game.cellAt(cell.row + 1, cell.column) else nil end
      if ( !(cellV.nil?) && cellV.isAWhite? )
        compt += 1
        est = true
      end
      cellV = if cell.row - 1 >= 0 then game.cellAt(cell.row - 1, cell.column) else nil end
      if ( !(cellV.nil?) && cellV.isAWhite? )
        compt += 1
        west = true
      end
      cellV = if cell.column + 1 < game.nCol then game.cellAt(cell.row, cell.column + 1) else nil end
      if ( !(cellV.nil?) && cellV.isAWhite? )
        compt += 1
        south = true
      end
      cellV = if cell.column - 1 >= 0 then game.cellAt(cell.row, cell.column - 1) else nil end
      if ( !(cellV.nil?) && cellV.isAWhite? )
        compt += 1
        north = true
      end

      if (compt == 2)
        if (north && west)
    	     cellV = game.cellAt(cell.row - 1, cell.column - 1)
    	     return HelpsOnACellOverlap.new(cellV, game.cellAt(cell.row - 1, cell.column), game.cellAt(cell.row, cell.column - 1)) if cellV.isAWhite?
        elsif (west && south)
    	      cellV = game.cellAt(cell.row - 1, cell.column + 1)
    	      return HelpsOnACellOverlap.new(cellV, game.cellAt(cell.row - 1, cell.column), game.cellAt(cell.row, cell.column + 1)) if cellV.isAWhite?
        elsif (south && est)
    	     cellV = game.cellAt(cell.row + 1, cell.column + 1)
    	      return HelpsOnACellOverlap.new(cellV, game.cellAt(cell.row + 1, cell.column), game.cellAt(cell.row, cell.column + 1)) if cellV.isAWhite?
        elsif (est && north)
    	     cellV = game.cellAt(cell.row + 1, cell.column - 1)
    	     return HelpsOnACellOverlap.new(cellV, game.cellAt(cell.row + 1, cell.column), game.cellAt(cell.row, cell.column - 1)) if cellV.isAWhite?
        end
      end

    end

    return HelpNotFound.new()

  end
end
