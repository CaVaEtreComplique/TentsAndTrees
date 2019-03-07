#RowsAndColumnsFindGrass help you to find grass in a row or columns

require File.dirname(__FILE__) + "/../../FindWhiteZone"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpNotFound/HelpNotFound"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsCellsAndRowsOrColumns/HelpsCellsAndColumns/HelpsAllPossibilitiesGiveItColumns/HelpAllPossibilitiesGiveItColumn"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsCellsAndRowsOrColumns/HelpsCellsAndRows/HelpsAllPossibilitiesGiveItRows/HelpAllPossibiliesGiveItRow"
require File.dirname(__FILE__) + "/../FictivHelper"

class RowsAndColumnsFindGrass < FictivHelper

  public_class_method :new

  def help(game)

    #puts(game.cellAt(0,5).state.to_s)

    #Algorithm for each columns
    (0...game.nCol).each do |i|
      cell = nil  #reset
      nbTent = 0
      odd = true

      whiteZone = FindWhiteZone.Find(game, 0, i)
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
                return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row, cell.column + 1), i, "grass") if game.cellAt(cell.row, cell.column + 1).isAWhite?
              end
              if(cell.column - 1 >= 0)
                return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row, cell.column - 1), i, "grass") if game.cellAt(cell.row, cell.column - 1).isAWhite?
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
                    return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row - 1, cell.column + 1), i, "grass") if game.cellAt(cell.row - 1, cell.column + 1).isAWhite?
                  end
                  if cell.column - 1 >= 0
                    return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row - 1, cell.column - 1), i, "grass") if game.cellAt(cell.row - 1, cell.column - 1).isAWhite?
                  end
                end
              end
              odd = true
              zone.each do |cell|
                if !odd
                  if(cell.column + 1 < game.nCol)
                    return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row, cell.column + 1), i, "grass") if game.cellAt(cell.row, cell.column + 1).isAWhite?
                  end
                  if(cell.column - 1 >= 0)
                    return HelpAllPossibilitiesGiveItRow.new(game.cellAt(cell.row, cell.column - 1), i, "grass") if game.cellAt(cell.row, cell.column - 1).isAWhite?
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

      whiteZone = FindWhiteZone.Find(game, 1, i)
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
                return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row + 1, cell.column), i, "grass") if game.cellAt(cell.row + 1, cell.column).isAWhite?
              end
              if(cell.row - 1 >= 0)
                return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row - 1, cell.column), i, "grass") if game.cellAt(cell.row - 1, cell.column).isAWhite?
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
                    return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row + 1, cell.column - 1), i, "grass") if game.cellAt(cell.row + 1, cell.column - 1).isAWhite?
                  end
                  if cell.row - 1 >= 0
                    return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row - 1, cell.column - 1), i, "grass") if game.cellAt(cell.row - 1, cell.column - 1).isAWhite?
                  end
                end
              end
              odd = true
              zone.each do |cell|
                if !odd
                  if(cell.row + 1 < game.nRow)
                    return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row + 1, cell.column), i, "grass") if game.cellAt(cell.row + 1, cell.column).isAWhite?
                  end
                  if(cell.row - 1 >= 0)
                    return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(cell.row - 1, cell.column), i, "grass") if game.cellAt(cell.row - 1, cell.column).isAWhite?
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
