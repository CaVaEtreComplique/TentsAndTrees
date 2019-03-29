# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOnACellTouchATent.rb
# @Last modified by:   maxime
# @Last modified time: 29-Mar-2019



require File.dirname(__FILE__) + "/../HelpOn2Cells"

class HelpOnACellTouchATent < HelpOn2Cells
  #a class for helping when a cell touch a tent, so the cell is grass
  public_class_method :new #instanciable
  def initialize(cell, tentCell)
    super(cell, tentCell)
  end

  def getText(helpLevel)
    #returns the text of the help, saying that a cell touch a class and is some grass
    case helpLevel
      when 1
        return "Il y a au moins une case qui touche une Tente"
      when 2
        return "Les cases qui touchent des tentes sont du gazon"
      when 3
        return "La case " + @cell.to_s + " touche une tente case " + @cell2.to_s+ " donc c est de l herbe"
      else
          super(helpLevel)
    end
  end
end
