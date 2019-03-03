#RowsAndColumnsFindTent help you to find Tent in a row or columns

require File.dirname(__FILE__) + "/../../Core/Game"

class RowsAndColumnsFindTent

  def RowsAndColumnsFindTent.help(game)
    #Algorithm for each row
    (0...game.nRow).each do |i|

      cell = nil  #reset
      nbTent = 0

      whiteZone = FindWhiteZone.Find(game, 0, i)
      whiteZone.each do |zone| #Count the number of possible tent
        if (zone.size % 2 == 0)
          nbTent += (zone.size / 2)
        else
          nbTent += (zone.size / 2) + 1
          cell = zone.first #register answer
        end
      end
      nbTent += Count.count(game, :tent, 0, i)

      if nbTent != game.colClues[i]  #Un bug : colClues est l'indice de ligne
        break
      end

      if !(cell.nil?) #We find an answer
        return HelpAllPossibilitiesGiveItRow.new(cell, i, "tent")
      end

    end

    #Algorithm for each column
    (0...game.nCol).each do |i|

      cell = nil  #reset
      nbTent = 0

      whiteZone = FindWhiteZone.Find(game, 1, i)
      whiteZone.each do |zone| #Count the number of possible tent
        if (zone.size % 2 == 0)
          nbTent += (zone.size / 2)
        else
          nbTent += (zone.size / 2) + 1
          cell = zone.first #register answer
        end
      end
      nbTent += Count.count(game, :tent, 1, i)

      if nbTent != game.rowClues[i]  #Un bug : rowClues est l'indice de colone
        break
      end

      if !(cell.nil?) #We find an answer
        return HelpAllPossibilitiesGiveItColumn.new(cell, i, "tent")
      end

    end

    return HelpNotFound.new()

  end
end
