require File.dirname(__FILE__) + "/../HelpOn2Cells"

class HelpOnACellTouchATent < HelpOn2Cells
  public_class_method :new
  def initialize(cell, tentCell)
    super(cell, tentCell)
  end

  def getText()
    return "La case " + @cell.to_s + " touche une tente case " + @cell2.to_s
  end
end
