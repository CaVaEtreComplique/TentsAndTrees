require File.dirname(__FILE__) + "/../HelpOn1Cell"

#Help the player to find a white cell whitch isn't adjacent a tree

class HelpCellTooFarOfTrees < HelpOn1Cell
  def initialize(cell)
    super(cell)
  end

  def gotText()
    return "La case " + @cell + " ne touche pas d arbre eet est donc du gazon"
  end
end
