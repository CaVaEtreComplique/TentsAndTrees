require File.dirname(__FILE__) + "/../Help"


class HelpOnCells < Help
  def initialize(cell)
    @cell = cell
    super()
  end
end
