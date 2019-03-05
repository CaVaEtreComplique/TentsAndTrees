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
