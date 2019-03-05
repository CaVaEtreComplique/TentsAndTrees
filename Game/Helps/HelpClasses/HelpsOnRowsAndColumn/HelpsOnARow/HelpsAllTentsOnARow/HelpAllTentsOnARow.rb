require File.dirname(__FILE__) + "/../HelpOneRow"

class HelpAllTentsOnARow < HelpOneRow
  #class saying that all tents of the row are placed , it need to be filled with grass
  public_class_method :new #instanciable class
  def initialize(row)
    super(row)
  end

  def getText #returns the text of the help, saying that "All tents needed are placed, so all the empty cells of the row ° are grass"
    @helpText = "All tents needed are placed, so all the empty cells of the row " + @row.to_s + " are grass"
  end
end
