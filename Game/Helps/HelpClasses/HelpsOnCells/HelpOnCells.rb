require File.dirname(__FILE__) + "/../Help"


class HelpOnCells < Help
  def initialize(cell)
    super()
    @cell = cell
  end
end
