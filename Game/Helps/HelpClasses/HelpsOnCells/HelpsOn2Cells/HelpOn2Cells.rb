require File.dirname(__FILE__) + "/../HelpOnCells"

class HelpOn2Cells < HelpOnCells
  def initialize(cell1, cell2)
    @cell2 = cell2
    super(cell1)
  end
end
