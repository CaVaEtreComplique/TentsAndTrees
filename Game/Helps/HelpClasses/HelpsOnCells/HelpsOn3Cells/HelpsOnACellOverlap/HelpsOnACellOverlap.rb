require File.dirname(__FILE__) + "/../HelpOn3Cells"


class HelpsOnACellOverlap < HelpOn3Cells
  #a class for helping when a cell touch a tent, so the cell is grass
  public_class_method :new #instanciable
  def initialize(cellGrass, cellwhite1, cellwhite2)
    super(cellGrass, cellwhite1, cellwhite2)
  end

  def getText()
    #returns the text of the help, saying that a cell touch a class and is some grass
    return "La case " + @cell.to_s + " est toucher par du gazon en " + @cell2.to_s + " et du gazon en " + @cell3.to_s + " et est donc du gazon."
  end
end
