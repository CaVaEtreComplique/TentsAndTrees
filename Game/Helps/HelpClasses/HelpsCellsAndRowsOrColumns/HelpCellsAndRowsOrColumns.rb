# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellsAndRowsOrColumns.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../Help"

##
# The HelpCellsAndRowsOrColumns is an abstract class inherited from the Help
# abstract class and it will lead all the next specific help classes to help
# the player when a move can be done on a cell and a row or on a cell and a
# column. It only has to be initialized with a cell and a row/column.
class HelpCellsAndRowsOrColumns < Help
  ##
  # This class' constructor needs 2 attributes and instanciates 3 variables.
  # ===== Attributes
  # * +cell+ - A cell we would need to get helped on.
  # * +rowOrColumn+ - A row or a column we would need to get helped on.
  # ===== Variables
  # * +cell+ - Takes the value of the cell in attributes.
  # * +row+ - This variable takes the value of the rowOrColumn in attributes.
  # * +column+ - This variable takes the value of the rowOrColumn in attributes.
  #
  # The fact that 2 variables take the same value is because the method should
  # only take two parameters, the helps given afterwards will either contain a
  # row or a column, they can't contain both. They will also act on a cell.
  def initialize(cell, rowOrColumn)
    @column = rowOrColumn
    @cell = cell
    @row = rowOrColumn
    super()
  end

  def cellsList
    return super().push(cell)
  end
end
