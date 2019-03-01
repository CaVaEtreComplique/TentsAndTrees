require File.dirname(__FILE__) + "/../HelpOneRow"

class HelpAllGrassOnARow < HelpOneRow
  public_class_method :new

  def initialize(row)
    super(row)
  end

  def getText
    @helpText = "All tents need to be placed, so all the empty cells of the row " + @row.to_s + " are tents"
  end
end
