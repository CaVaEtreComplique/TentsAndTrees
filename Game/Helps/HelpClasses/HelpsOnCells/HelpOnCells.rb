require File.dirname(__FILE__) + "/../Help"


class HelpOnCells < Help
  def initialize(cell)
    super()
    print "initialize avec" + cell.to_s
    @cell = cell
  end
end
