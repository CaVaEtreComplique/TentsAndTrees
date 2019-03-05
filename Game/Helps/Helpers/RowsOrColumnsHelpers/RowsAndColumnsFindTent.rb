#RowsAndColumnsFindTent help you to find Tent in a row or columns

require File.dirname(__FILE__) + "/../Count"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsCellsAndRowsOrColumns/HelpsCellsAndColumns/HelpsAllPossibilitiesGiveItColumns/HelpAllPossibilitiesGiveItColumn"

require File.dirname(__FILE__) + "/../FictivHelper"


class RowsAndColumnsFindTent  < FictivHelper

  public_class_method :new

  def help(game)

    return HelpAllPossibilitiesGiveItColumn.new(game.cellAt(0, 0), 0, "grass")

    #return HelpNotFound.new()

  end
end
