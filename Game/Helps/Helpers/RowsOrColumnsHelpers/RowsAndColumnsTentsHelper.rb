# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: RowsAndColumnsTentsHelper.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnRowsAndColumn/HelpsOnAColumn/HelpsAllGrassOnAColumn/HelpAllGrassOnAColumn"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnRowsAndColumn/HelpsOnARow/HelpsAllGrassOnARow/HelpAllGrassOnARow"
require File.dirname(__FILE__) + "/../FictivHelper"

##
# ===== Presentation
# The RowsAndColumnsTentsHelper class is a helper class inherited from FictivHelper
# it's role is to help you to find where you can fill a row or column whith tents.
#
# ===== Methods
# * +help+ - inheritade from FictivHelper, but definded there.
class RowsAndColumnsTentsHelper < FictivHelper

  public_class_method :new

  ##
  # ===== Presentation
  # This method try to find to find whitch row or column you can fill whith tents.
  #
  # ===== Attributes
  # * +game+ - The game you want a help for.
  #
  # ===== Returns
  # If it find a row or a column to fill with grass,
  # returns a HelpAllGrassOnARow instance if it's a row to fill,
  # returns a HelpAllGrassOnAColumn instance if it's a column to fill,
  # else it returns a HelpNotFound instance.
  #
  # ===== How to use
  # To get a help for a cell don't touched by a tree:
  #     RowsAndColumnsTentsHelper_instace.help(theGameYouWantHelpFor)
  # -----------
  def help(game)

    game = game.game()

    (0...game.nCol).each{ |i| #for each column
      if(Count.count(game, :white, 0, i ) + (nbTents = Count.count(game, :tent, 0, i )) == game.colClues[i] && nbTents != game.colClues[i])
      #if there are much grass that we need for the column
        if( cell = Count.findFirst(game, :white , 0, i).class == Cell)
        #if there is an empty cell
          return HelpAllGrassOnARow.new(game.correction.cols[i]) #You help player by saying that the row is full of tents
        end
      end
    }

    (0...game.nRow).each{ |i| #for each row

      if(Count.count(game, :white, 1, i ) + (nbTents = Count.count(game, :tent, 1, i )) == game.rowClues[i] && nbTents != game.rowClues[i])
      #if there are much grass that we need for the the row
        if( cell = Count.findFirst(game, :white , 1, i).class == Cell)
        #if there is an empty cell
          return HelpAllGrassOnAColumn.new(game.correction.rows[i]) #You find a column to help player
        end
      end
    }
    return HelpNotFound.new()
  end
end
