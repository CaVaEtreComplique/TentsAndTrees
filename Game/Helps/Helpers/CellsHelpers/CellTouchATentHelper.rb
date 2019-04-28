# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: CellTouchATentHelper.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019

#A helper whitch helps the player to put grass on cells that touch tents.
require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnCells/HelpsOn2Cells/HelpsOnACellTouchATent/HelpOnACellTouchATent"
require File.dirname(__FILE__) + "/../FictivHelper"

##
# ===== Presentation
# The CellTouchATentHelper class is a helper class inherited from FictivHelper.
# Its role is to find a cell which is touching a tent.
#
# ===== Methods
# * +help+ - Inherited from FictivHelper, but defined there.
class CellTouchATentHelper < FictivHelper

public_class_method :new


##
# ===== Presentation
# This method tries to find a cell touched by a tent.
#
# ===== Attributes
# * +game+ - The game you want help for.
#
# ===== Returns
# If it finds a cell touched by a tent, returns a HelpOnACellTouchATent instance.
# If not, it returns a HelpNotFound instance.
#
# ===== How to use
# To get helped for a cell touched by a tent :
#    CellTouchATentHelper_instance.help(theGameYouWantHelpFor)
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

      #If the cell is white and touch a tent /in X, not +/ :
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
