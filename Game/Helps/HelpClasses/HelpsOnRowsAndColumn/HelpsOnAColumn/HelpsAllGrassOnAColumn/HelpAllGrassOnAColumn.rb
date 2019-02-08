require File.dirname(__FILE__) + "/../HelpsOneColumn"

class HelpAllGrassOnAColumn
  def initialize(column)
    super(column)
  end

  def getText
    @helpText = "All tents need to be placed, so all the empty cells of the column " + @row + " are tents"
  end
end
