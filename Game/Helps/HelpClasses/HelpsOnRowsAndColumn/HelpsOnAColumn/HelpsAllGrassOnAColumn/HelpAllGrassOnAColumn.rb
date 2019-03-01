require File.dirname(__FILE__) + "/../HelpOnAColumn"

class HelpAllGrassOnAColumn < HelpOnAColumn
    public_class_method :new
  def initialize(column)
    super(column)
  end

  def getText
    @helpText = "All tents need to be placed, so all the empty cells of the column " + @row.to_s + " are tents"
  end
end
