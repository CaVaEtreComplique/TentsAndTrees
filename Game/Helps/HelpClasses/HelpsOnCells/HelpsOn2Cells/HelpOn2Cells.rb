require File.dirname(__FILE__) + "/../HelpOnCells"

class HelpOn2Cells < HelpOnCells #Abstract class
  #A class whitch help the player and need two cells to help him
  def initialize(cell1, cell2)
    @cell2 = cell2
    super(cell1)
  end
end
