# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpsOn2CellsGrassLinkedTree.rb
# @Last modified by:   maxime
# @Last modified time: 28-Mar-2019



require File.dirname(__FILE__) + "/../HelpOn2Cells"

class HelpsOn2CellsGrassLinkedTree < HelpOn2Cells
  #a class for helping when a cell is link to a tree because of only one posibility
  public_class_method :new #instanciable
  def initialize(cellTent, cellTree)
    super(cellTent, cellTree)
  end

  def getText(helpLevel)
    #returns the text of the help, saying that a cell touch a class and is some grass
    return "La case " + @cell.to_s + " est du gazon car le reseau d'arbre en  " + @cell2.to_s + " est complet"
  end
end
