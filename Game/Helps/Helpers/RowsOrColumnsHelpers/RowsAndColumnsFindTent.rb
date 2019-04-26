# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: RowsAndColumnsFindTent.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../../Count"
require File.dirname(__FILE__) + "/../../FindWhiteZone"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsCellsAndRowsOrColumns/HelpsCellsAndColumns/HelpsAllPossibilitiesGiveItColumns/HelpAllPossibilitiesGiveItColumn"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsCellsAndRowsOrColumns/HelpsCellsAndRows/HelpsAllPossibilitiesGiveItRows/HelpAllPossibiliesGiveItRow"
require File.dirname(__FILE__) + "/../FictivHelper"

##
# ===== Presentation
# The RowsAndColumnsFindTent class is a helper class inherited from FictivHelper.
# Its role is to find a cell whitch is a tent because of its row/column, or a near one.
#
# ===== Methods
# * +help+ - Inherited from FictivHelper, but defined there.
class RowsAndColumnsFindTent < FictivHelper

  public_class_method :new

  ##
  # ===== Presentation
  # This method tries to find a cell whitch is a tent because of its row/column, or a near one.
  #
  # ===== Attributes
  # * +game+ - The game you need help for.
  #
  # ===== Returns
  # If it finds a cell whitch is a tent because of its row/column, or a near one,
  # returns a HelpAllPossibilitiesGiveItRow instance if it depends on a row,
  # returns a HelpAllPossibilitiesGiveItColumn instance if it depends on a column,
  # else it returns a HelpNotFound instance.
  #
  # ===== How to use
  # To get help :
  #     RowsAndColumnsFindTent_instace.help(theGameYouWantHelpFor)
  # -----------
  def help(game)

    game = game.game()

    #Algorithm for each columns
    (0...game.nCol).each do |i|

      cell = nil  #reset
      nbTent = 0

      whiteZone = FindWhiteZone.find(game, 0, i)
      whiteZone.each do |zone| #Count the number of possible tent
        if (zone.size % 2 == 0)
          nbTent += (zone.size / 2)
        else
          nbTent += (zone.size / 2) + 1
          cell = zone.first #registered answer
        end
      end
      nbTent += Count.count(game, :tent, 0, i)

      if nbTent != game.colClues[i]
        break
      end

      if !(cell.nil?) #We find an answer
        return HelpAllPossibilitiesGiveItRow.new(cell, game.correction.cols[i], "tent")
      end

    end

    #Algorithm for each row
    (0...game.nRow).each do |i|

      cell = nil  #reset
      nbTent = 0

      whiteZone = FindWhiteZone.find(game, 1, i)
      whiteZone.each do |zone| #Count the number of possible tents
        if (zone.size % 2 == 0)
          nbTent += (zone.size / 2)
        else
          nbTent += (zone.size / 2) + 1
          cell = zone.first #register answer
        end
      end
      nbTent += Count.count(game, :tent, 1, i)

      if nbTent == game.rowClues[i]

        if !(cell.nil?) #We find an answer
          return HelpAllPossibilitiesGiveItColumn.new(cell, game.correction.rows[i], "tent")
        end

      end
    end

    return HelpNotFound.new()

  end
end
