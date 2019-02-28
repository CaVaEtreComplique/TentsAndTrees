#Main of the help, when you need a help, let's call Helper to help you

require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsGrassHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsTentsHelper"


class Helper
  def Helper.help( game )
    game.beginGuess

    if(help = CellDontTouchTreeHelper.help(game).helpFound? == false) then #1
      if(true) then #2
        if(help = RowsAndColumnsGrassHelper.help(game).helpFound? == false) then #3
          if(help = RowsAndColumnsTentsHelper.help(game).helpFound? == false) then #4

          end
        end
      end
    end

    game.removeGuess

    #return help
  end
end
