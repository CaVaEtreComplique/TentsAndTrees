require File.dirname(__FILE__) + "/../HelpOnAColumn"
#Help witch fill with grass a column who have all it's tents
class HelpAllTentsOnAColumn < HelpOnAColumn
  # Help when all the tents are placed and we need only grass
  public_class_method :new #instanciable class
  def initialize(column)
    super(column)
  end

  def getText #returns the text of the help, saying that "All tents need have been placed, so all the empty cells of the column are grass"
    @helpText = "All tents needed have been placed, so all the empty cells of the column " + @column.to_s + " are grass"
  end
end
