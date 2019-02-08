require File.dirname(__FILE__) + "/../HelpsOneRow"

class HelpAllTantsOnARow
  def initialize(row)
    Super(row)
  end

  def getText
    @helpText = "All tents needed are placed, so all the empty cells of the row " + @row + " are grass"
end
