# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpsOnACellOverlap.rb
# @Last modified by:   maxime
# @Last modified time: 29-Mar-2019



require File.dirname(__FILE__) + "/../HelpOn3Cells"


class HelpsOnACellOverlap < HelpOn3Cells
  #a class for helping when a cell touch a tent, so the cell is grass
  public_class_method :new #instanciable
  def initialize(cellGrass, cellwhite1, cellwhite2)
    super(cellGrass, cellwhite1, cellwhite2)
  end

  def getText(helpLevel)
    #returns the text of the help, saying that a cell touch a class and is some grass
    case helpText
      when 1
        return "Deux cellules blanches indiquent l'etat d'une troisième"
      when 2
        return "Deux cellules blanches indiquent qu'une autre cellule est du gazon"
      when 3
        return "La case " + @cell.to_s + " est touchée par deux cases blanches en " + @cell2.to_s + " et en " + @cell3.to_s + " et est donc du gazon."
      else
          super(helpLevel)
    end
  end
end
