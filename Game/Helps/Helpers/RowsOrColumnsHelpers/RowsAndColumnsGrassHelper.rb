#GrassHelper help you to find where you can fill a row or column whith grass

require File.dirname(__FILE__) + "/../../Count"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnRowsAndColumn/HelpsOnAColumn/HelpsAllTentsOnAColumn/HelpAllTentsOnAColumn"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnRowsAndColumn/HelpsOnARow/HelpsAllTentsOnARow/HelpAllTentsOnARow"
require File.dirname(__FILE__) + "/../FictivHelper"

class RowsAndColumnsGrassHelper < FictivHelper

  public_class_method :new

  def help(game)
    (0...game.nCol).each{ |i| #for each column
      if( Count.count(game,:tent, 0, i ) == game.colClues[i] &&
        #if there are much tents that we need for the column
        cell = Count.findFirst(game,:white ,0,i).class == Cell)
        #if there is an empty cell
        return HelpAllTentsOnARow.new(i)
          #You help player by saying that the row is full of tents
      end
    }
    (0...game.nRow).each{ |i| #for each row
      if(Count.count(game,:tent, 1, i ) == game.rowClues[i] &&
        #if there are much tents that we need for the row
        cell = Count.findFirst(game,:white ,1,i).class == Cell)
        #if there is an empty cell
           #You find a row to help player
          return HelpAllTantsOnAColumn.new(i)
          #You help player by saying that the column is full of tents
      end
    }
    return HelpNotFound.new()
  end
end
