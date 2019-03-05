require File.dirname(__FILE__) + "/../Help"


class HelpOnCells < Help
  #abstract class
  #A help that help player, and need a cell to help him
  def initialize(cell)
    @cell = cell
    super()
  end
end
