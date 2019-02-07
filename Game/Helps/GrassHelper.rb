#GrassHelper help you to find where you can fill a row or column whith grass

require File.dirname(__FILE__) + "/Count"
require File.dirname(__FILE__) + "/../Game"

class GrassHelper
  def GrassHelper.help(game)
    0.upto(game.nCol){ |i| #for each column
      if(Count.count(game, state: :tent, 0, i ) == game.colClues )
      {#if there are much tents that we need for the column / the row
        if( cell = Count.findFirst(game, state: :white ,0,i).class == Cell)
        {#if there is an empty cell
          return 1
        }
      }
    }
  end
end