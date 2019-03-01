require File.dirname(__FILE__) + "/../HelpOneRow"

class HelpAllTentsOnARow < HelpOneRow
  public_class_method :new
  def initialize(row)
    super(row)
  end

  def getText
    @helpText = "All tents needed are placed, so all the empty cells of the row " + @row.to_s + " are grass"
  end
end
