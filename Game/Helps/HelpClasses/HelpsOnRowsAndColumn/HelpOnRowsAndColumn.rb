# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOnRowsAndColumn.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019



require File.dirname(__FILE__) + "/../Help"

class HelpOnRowsAndColumn < Help
  #abstract class
  #help gave when the player need a row or a column

  attr_reader :column, :row

  def initialize(rowOrColumn)
    @column = rowOrColumn
    @row = rowOrColumn
    super()
  end

  def ==(otherHelp)
    return(super(otherHelp) && @column == otherHelp.column && @row == otherHelp.row)
  end
end
