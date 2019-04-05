# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellsAndRowsOrColumns.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019



require File.dirname(__FILE__) + "/../Help"

##
# The HelpCellsAndRowsOrColumns is an abstract class inherited from the Help
# class and it will lead all the next specific help classes to help
# the player when a move can be done on a cell and a row or on a cell and a
# column. It contains a constructor, a redefinition of the '=='method and a
# redefinition of the cellsList method from Help.
#
# This abstract class' direct children are the abstract classes HelpCellsAndRows
# and HelpCellsAndColumns.
class HelpCellsAndRowsOrColumns < Help
   # :nodoc:
     attr_reader :cell, :column, :row
   # :startdoc:

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

  ##
  # The cellsList method is a redefinition from cellsList method in the Help class.
  # ===== Attributes
  # * +helpLevel+ : The help's importance, in order to tell the price.
  # ===== Returns
  # This method returns an array with all the important cells needed for the help.
  # Here specifically, it returns the level 3 helps, as you can see here :
  #     if(helpLevel == 3)
  #        list.push(cell)
  #     end
  def cellsList(helpLevel)
    list = super(helpLevel);
    if(helpLevel == 3)
      list.push(cell)
    end
    return list
  end

  ##
  # This method is a redefinition of this method in the Help class.
  # ===== Attributes
  # * +otherHelp+ : The object we want to compare values with.
  # ===== Returns
  # This method returns a boolean that is set to true if the '==' method in the
  # Help class returns true AND the column, the cell and the row of the other help
  # are matching with this class' variables, as you can see here :
  #     return(super(otherHelp) && @column == otherHelp.column && @cell == otherHelp.cell && @row == otherHelp.row)
  def ==(otherHelp)
    return(super(otherHelp) && @column == otherHelp.column && @cell == otherHelp.cell && @row == otherHelp.row)
	end
end
