# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpsOn2CellUniqueSolution.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpOn2Cells"

class HelpsOn2CellUniqueSolution < HelpOn2Cells
  #a class for helping when a cell is link to a tree because of only one posibility
  public_class_method :new #instanciable
  def initialize(cellTent, cellTree)
    super(cellTent, cellTree)
  end

  def getText()
    #returns the text of the help, saying that a cell touch a class and is some grass
    return "La case " + @cell.to_s + " est une tent car elle est la solution unique de l'arbre en " + @cell2.to_s
  end
end
