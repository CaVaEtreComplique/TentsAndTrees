require File.dirname(__FILE__) + "/../HelpsOneRow"

class HelpAllGrassOnARow
  def initialize(row)
    super(row)
  end

  def getText
    @helpText = "All tents need to be placed, so all the empty cells of the row " + @row + " are tents"
  end
end
