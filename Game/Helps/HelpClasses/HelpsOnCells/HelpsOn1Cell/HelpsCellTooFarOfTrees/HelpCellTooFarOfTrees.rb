# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellTooFarOfTrees.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpOn1Cell"

class HelpCellTooFarOfTrees < HelpOn1Cell
  #Help the player to find a white cell whitch isn't adjacent a tree

  public_class_method :new #Instanciable
  def initialize(cell)
    #the cell don't touch a tree
    super(cell)
  end

  def getText()
    #returns the text of the help, saying that the cell is grass
    return "La case " + @cell.to_s + " ne touche pas d arbre et est donc du gazon"
  end
end
