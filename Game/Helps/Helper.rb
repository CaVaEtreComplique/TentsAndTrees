#Main of the help, when you need a help, let's call Helper to help you

require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsGrassHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsTentsHelper"
require File.dirname(__FILE__) + "/CellDontTouchTreeHelper"

class Helper
  def Helper.help( game )
    #game.beginGuess
    if(!((help = CellDontTouchTreeHelper.help(game)).helpFound?))  #1
      p "ici"
      if(true)  #2
        if(!((help = RowsAndColumnsGrassHelper.help(game)).helpFound?))  #3
          p "là"
          if(!((help = RowsAndColumnsTentsHelper.help(game)).helpFound?))  #4
            p "Je suis un génie"
            help = HelpNotFound.new
          end
        end
      end
    end

    #game.removeGuess

    return help
  end
end
