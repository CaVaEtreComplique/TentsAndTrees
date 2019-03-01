require File.dirname(__FILE__) + "/../HelpOn1Cell"

#Help the player to find a white cell whitch isn't adjacent a tree

class HelpCellTooFarOfTrees < HelpOn1Cell
  def initialize(cell)
    super(cell)
  end

  def getText()
    return "La case " + @cell.to_s + " ne touche pas d arbre et est donc du gazon"
  end
end
