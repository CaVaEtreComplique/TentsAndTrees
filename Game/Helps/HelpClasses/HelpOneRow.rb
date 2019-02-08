#

require File.dirname(__FILE__) + "/Help"

class HelpOneRow < Help
  def initialize(row, column, cell, text)
    Super(row, column, cell, text)
  end
end
