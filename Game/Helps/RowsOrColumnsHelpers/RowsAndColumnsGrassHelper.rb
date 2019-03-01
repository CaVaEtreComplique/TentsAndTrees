#GrassHelper help you to find where you can fill a row or column whith grass

require File.dirname(__FILE__) + "/../Count"

class RowsAndColumnsGrassHelper
  def RowsAndColumnsGrassHelper.help(game)
    (0...game.nCol).each{ |i| #for each column
      if( Count.count(game,:tent, 0, i ) == game.colClues &&
        #if there are much tents that we need for the column
        cell = Count.findFirst(game,:white ,0,i).class == Cell)
        #if there is an empty cell
          return HelpAllTentsOnAColumn.new(i)
          #You help player by saying that the row is full of tents
      end
    }
    (0...game.nRow).each{ |i| #for each row
      if(Count.count(game,:tent, 1, i ) == game.colClues &&
        #if there are much tents that we need for the row
        cell = Count.findFirst(game,:white ,1,i).class == Cell)
        #if there is an empty cell
          return HelpAllTentsOnARow.new(i) #You find a row to help player
      end
    }
    return HelpNotFound.new()
  end
end
