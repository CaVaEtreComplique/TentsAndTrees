require File.dirname(__FILE__) + "/../Help"

class HelpOnRowsAndColumn < Help
  #abstract class
  #help gave when the player need a row or a column
  def initialize(rowOrColumn)
    @column = rowOrColumn
    @row = rowOrColumn
    super()
  end
end
