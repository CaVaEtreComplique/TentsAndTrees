#Main of the help, when you need a help, let's call Helper to help you

require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsGrassHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsTentsHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellDontTouchTreeHelper"

class Helper
  def Helper.help( game )
    #game.beginGuess
    if(!((help = CellDontTouchTreeHelper.help(game)).helpFound?))  #1
      if(true)  #2
        if(!((help = RowsAndColumnsGrassHelper.help(game)).helpFound?))  #3
          if(!((help = RowsAndColumnsTentsHelper.help(game)).helpFound?))  #4
            help = HelpNotFound.new
          end
        end
      end
    end

    #game.removeGuess

    return help
  end
end
