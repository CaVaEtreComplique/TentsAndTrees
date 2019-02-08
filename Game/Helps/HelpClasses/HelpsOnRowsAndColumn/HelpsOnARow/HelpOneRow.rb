#

require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn" + ".rb"

class HelpOneRow < HelpOnRowsAndColumn
  def initialize(row, column, cell, text)
    Super(row, column, cell, text)
  end
end
