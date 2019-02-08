#Main of the help, when you need a help, let's call Helper to help you

require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsGrassHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsTentsHelper"


class Helper
  def Helper.help( game )
    game.beginGuess

    CellDontTouchTreeHelper.help(game)#1
    
    RowsAndColumnsGrassHelper.help(game) #3
    RowsAndColumnsTentsHelper.help(game) #4

    game.removeGuess
  end
end
