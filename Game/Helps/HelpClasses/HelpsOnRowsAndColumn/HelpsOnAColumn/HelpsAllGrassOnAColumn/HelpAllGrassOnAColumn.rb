require File.dirname(__FILE__) + "/../HelpOnAColumn"
#Help witch fill with tent a column who only need tents
class HelpAllGrassOnAColumn < HelpOnAColumn
  # Help when all the grass are placed and we need only tents
  public_class_method :new #instanciable class
  def initialize(column)
    super(column)
  end

  def getText #returns the text of the help, saying that "All tents need to be placed, so all the empty cells of the column ° are tents"
    @helpText = "All tents needed have been placed, so all the empty cells of the column " + @column.to_s + " are tents"
  end
end
