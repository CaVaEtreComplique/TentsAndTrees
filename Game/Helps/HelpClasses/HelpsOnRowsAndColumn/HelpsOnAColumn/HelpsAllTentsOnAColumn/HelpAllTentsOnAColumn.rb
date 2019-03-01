require File.dirname(__FILE__) + "/../HelpOnAColumn"
#Help whitch gives a column whitch has all it's tents, and it needs to be fill by grass
class HelpAllTantsOnAColumn < HelpOnAColumn
  def initialize(row)
    super(row)
  end

  def getText
    @helpText = "All tents needed are placed, so all the empty cells of the column " + @column + " are grass"
  end
end
