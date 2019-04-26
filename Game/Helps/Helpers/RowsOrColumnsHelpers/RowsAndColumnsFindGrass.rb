# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: RowsAndColumnsFindGrass.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../../FindWhiteZone"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsCellsAndRowsOrColumns/HelpsCellsAndColumns/HelpsAllPossibilitiesGiveItColumns/HelpAllPossibilitiesGiveItColumn"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsCellsAndRowsOrColumns/HelpsCellsAndRows/HelpsAllPossibilitiesGiveItRows/HelpAllPossibiliesGiveItRow"
require File.dirname(__FILE__) + "/../FictivHelper"

##
# ===== Presentation
# The RowsAndColumnsFindGrass class is a helper class inherited from FictivHelper.
# Its role is to find a cell whitch is grass because of its row/column, or a near one.
#
# ===== Methods
# * +help+ - Inherited from FictivHelper, but defined there.
class RowsAndColumnsFindGrass < FictivHelper

  public_class_method :new

  ##
  # ===== Presentation
  # This method tries to find a cell whitch is grass beacause of its row/column, or a near one.
  #
  # ===== Attributes
  # * +game+ - The game you want help for.
  #
  # ===== Returns
  # If it finds a cell whitch is grass because of its row/column, or a near one,
  # returns a HelpAllPossibilitiesGiveItRow instance if it depends on a row or
  # returns a HelpAllPossibilitiesGiveItColumn instance if it depends on a column.
  # If nothing is found, returns a HelpNotFound instance.
  #
  # ===== How to use
  # To get help :
  #     rowsAndColumnsFindGrass_instace.help(theGameYouWantHelpFor)
  # -----------
  def help(game)

    game = game.game()

    #Algorithm for each columns
    (0...game.nCol).each do |i|
      cell = nil  #reset
      nbTent = 0
      odd = true

      whiteZone = FindWhiteZone.find(game, 0, i)
      whiteZone.each do |zone| #Count the number of possible tent
        if (zone.size % 2 == 0)
          nbTent += (zone.size / 2)
        else
          nbTent += (zone.size / 2) + 1
        end
      end
      nbTent += Count.count(game, :tent, 0, i)

      if ((nbTent == game.colClues[i] || (nbTent == game.colClues[i] + 1)) && game.colClues[i] != 0)

        #Time efficient, in case of medium/big grid
        if (nbTent == game.colClues[i])

          whiteZone.each do |zone|
            zone.each do |cell|
              if(cell.column + 1 < game.nCol)
                return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row, cell.column + 1), game.correction.cols[i], "grass") if game.cellAt(cell.row, cell.column + 1).isAWhite?
              end
              if(cell.column - 1 >= 0)
                return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row, cell.column - 1), game.correction.cols[i], "grass") if game.cellAt(cell.row, cell.column - 1).isAWhite?
              end
            end
          end

        else  #nbTent == game.colClues[i]+1
          whiteZone.each do |zone|
            if zone.size % 2 == 1 #odd zone
              if(!odd)   #Two consecutive odd zone
                cell = zone.first
                if (game.cellAt(cell.row - 2, cell.column).isAWhite?)
                  if cell.column + 1 < game.nCol
                    return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row - 1, cell.column + 1), game.correction.cols[i], "grass") if game.cellAt(cell.row - 1, cell.column + 1).isAWhite?
                  end
                  if cell.column - 1 >= 0
                    return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row - 1, cell.column - 1), game.correction.cols[i], "grass") if game.cellAt(cell.row - 1, cell.column - 1).isAWhite?
                  end
                end
              end
              odd = true
              zone.each do |cell|
                if !odd
                  if(cell.column + 1 < game.nCol)
                    return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row, cell.column + 1), game.correction.cols[i], "grass") if game.cellAt(cell.row, cell.column + 1).isAWhite?
                  end
                  if(cell.column - 1 >= 0)
                    return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row, cell.column - 1), game.correction.cols[i], "grass") if game.cellAt(cell.row, cell.column - 1).isAWhite?
                  end
                end
                odd = !odd
              end
              odd = false
            else  #zone.size % 2 == 0 --> even zone
              odd = true
            end
          end

        end
      end
    end

    #Algorithm for each row
    (0...game.nRow).each do |i|
      cell = nil  #reset
      nbTent = 0
      odd = true

      whiteZone = FindWhiteZone.find(game, 1, i)
      whiteZone.each do |zone| #Count the number of possible tent
        if (zone.size % 2 == 0)
          nbTent += (zone.size / 2)
        else
          nbTent += (zone.size / 2) + 1
        end
      end
      nbTent += Count.count(game, :tent, 1, i)

      if ((nbTent == game.rowClues[i] || (nbTent == game.rowClues[i] + 1)) && game.rowClues[i] != 0)

        #Time efficient, in case of medium/big grid
        if (nbTent == game.rowClues[i])

          whiteZone.each do |zone|
            zone.each do |cell|
              if(cell.row + 1 < game.nRow)
                return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row + 1, cell.column), game.correction.rows[i], "grass") if game.cellAt(cell.row + 1, cell.column).isAWhite?
              end
              if(cell.row - 1 >= 0)
                return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row - 1, cell.column), game.correction.rows[i], "grass") if game.cellAt(cell.row - 1, cell.column).isAWhite?
              end
            end
          end

        else  #nbTent == game.rowClues[i]+1
          whiteZone.each do |zone|
            if zone.size % 2 == 1 #odd zone
              if(!odd)   #Two consecutive odd zone
                cell = zone.first
                if (game.cellAt(cell.row, cell.column - 2).isAWhite?)
                  if cell.row + 1 < game.nRow
                    return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row + 1, cell.column - 1), game.correction.rows[i], "grass") if game.cellAt(cell.row + 1, cell.column - 1).isAWhite?
                  end
                  if cell.row - 1 >= 0
                    return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row - 1, cell.column - 1), game.correction.rows[i], "grass") if game.cellAt(cell.row - 1, cell.column - 1).isAWhite?
                  end
                end
              end
              odd = true
              zone.each do |cell|
                if !odd
                  if(cell.row + 1 < game.nRow)
                    return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row + 1, cell.column), game.correction.rows[i], "grass") if game.cellAt(cell.row + 1, cell.column).isAWhite?
                  end
                  if(cell.row - 1 >= 0)
                    return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row - 1, cell.column), game.correction.rows[i], "grass") if game.cellAt(cell.row - 1, cell.column).isAWhite?
                  end
                end
                odd = !odd
              end
              odd = false
            else  #zone.size % 2 == 0 --> even zone
              odd = true
            end
          end

        end
      end
    end

    return HelpNotFound.new()

  end
end
