#RowsAndColumnsFindTent help you to find Tent in a row or columns

require File.dirname(__FILE__) + "/../Count"
require File.dirname(__FILE__) + "/../..//HelpClasses/HelpsCellsAndRowsOrColumns/HelpsCellsAndColumns/HelpsAllPossibilitiesGiveItColumns/HelpAllPossibilitiesGiveItColumn"




class RowsAndColumnsFindTent

  def RowsAndColumnsFindTent.help(game)

    return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(0, 0), 0, "grass")

    #return HelpNotFound.new()

  end
end
