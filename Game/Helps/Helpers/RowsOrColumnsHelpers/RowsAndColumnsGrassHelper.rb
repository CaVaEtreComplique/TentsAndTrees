# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: RowsAndColumnsGrassHelper.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../../Count"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnRowsAndColumn/HelpsOnAColumn/HelpsAllTentsOnAColumn/HelpAllTentsOnAColumn"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnRowsAndColumn/HelpsOnARow/HelpsAllTentsOnARow/HelpAllTentsOnARow"
require File.dirname(__FILE__) + "/../FictivHelper"

##
# ===== Presentation
# The RowsAndColumnsGrassHelper class is a helper class inherited from FictivHelper.
# Its role is to help you finding where you can fill a row or column with grass.
#
# ===== Methods
# * +help+ - Inherited from FictivHelper, but defined there.
class RowsAndColumnsGrassHelper < FictivHelper

  public_class_method :new

  ##
  # ===== Presentation
  # This method tries to find whitch row or column you can fill with grass.
  #
  # ===== Attributes
  # * +game+ - The game you need help on.
  #
  # ===== Returns
  # If it finds a row or a column to fill with grass,
  # returns a HelpAllTentsOnARow instance if it's a row to fill,
  # returns a HelpAllTentsOnAColumn instance if it's a column to fill,
  # else it returns a HelpNotFound instance.
  #
  # ===== How to use
  # To get help :
  #     rowsAndColumnsGrassHelper_instace.help(theGameYouWantHelpFor)
  # -----------
  def help(game)

    game = game.game()

    (0...game.nCol).each{ |i| #for each column
      if( Count.count(game, :tent, 0, i ) == game.colClues[i] &&
        #if there are much tents that we need for the column
        cell = Count.findFirst(game, :white , 0, i).class == Cell)
        #if there is an empty cell
        return HelpAllTentsOnARow.new(game.correction.cols[i])
          #You help player by saying that the row is full of tents
      end
    }

    (0...game.nRow).each{ |i| #for each row
      if(Count.count(game, :tent, 1, i ) == game.rowClues[i] &&
        #if there are much tents that we need for the row
        cell = Count.findFirst(game, :white , 1, i).class == Cell)
        #if there is an empty cell
           #You find a row to help player
          return HelpAllTentsOnAColumn.new(game.correction.rows[i])
          #You help player by saying that the column is full of tents
      end
    }
    return HelpNotFound.new()
  end
end
