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

##
# ===== Presentation
# The CellWhiteOverlap class is a helper class inherited from FictivHelper.
# Its role is to find grass if a tree only have two possible position for a
# tent and thoses positions give a nearby cell to be grass.
#
# ===== Methods
# * +help+ - This method is inherited from FictivHelper, but definded there.
class CellWhiteOverlap < FictivHelper

public_class_method :new

  ##
  # ===== Presentation
  # This method find tree and check if they have only two positions for it's
  # tent and if thoses two position are neighbour a cell nearby is a grass .
  #
  # ===== Attributes
  # * +game+ - The game you want help for.
  #
  # ===== Returns
  # If it finds a tree with two position who are neighbour, return a
  # HelpsOnACellOverlap instance, otherwise return an HelpNotFound instance.
  #
  # ===== Exemple
  # W -> white cell; T -> Tree;
  #       0   1
  #     | W | W |   0
  #     | T | W |   1
  # Here the white cell in column 1 and row 0 is therefore a grass cell
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
