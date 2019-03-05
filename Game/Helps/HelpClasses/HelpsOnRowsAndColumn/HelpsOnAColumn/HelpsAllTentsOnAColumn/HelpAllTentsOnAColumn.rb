require File.dirname(__FILE__) + "/../HelpOnAColumn"
#Help whitch gives a column whitch has all it's tents, and it needs to be fill by grass
class HelpAllTantsOnAColumn < HelpOnAColumn
  # Help when all the tents are placed and we need only grass
  public_class_method :new #instanciable class
  def initialize(row)
    super(row)
  end

  def getText #returns the text of the help, saying thatAll tents needed are placed, so all the empty cells of the column ° are grass"
    @helpText = "All tents needed are placed, so all the empty cells of the column " + @column.to_s + " are grass"
  end
end
