# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOnRowsAndColumn.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../Help"

##
# ===== Presentation
# The HelpOnRowsAndColumn abstract class is inherited from the Help class and
# its direct children are HelpOnAColumn and HelpOneRow.
#
# ===== Methods
# This class knows its constructor and the '==' method. All these methods are
# overloads of the Help class.
class HelpOnRowsAndColumn < Help

  # :nodoc:
  attr_reader :column, :row
  # :startdoc:

  ##
  # ===== Presentation
  # This class' constructor assigns a value to the @column and @row variables
  # and calls the constructor from the Help class.
  # ===== Attributes
  # * +rowOrColumn+ : The row or the column we want to work with. Both @row and @column variables will take its value so we can work either on a row or on a column
  def initialize(rowOrColumn)
    @column = rowOrColumn
    @row = rowOrColumn
    super()
  end

  ##
  # ===== Presentation
  # The == method compares this help with another one.
  #
  # ===== Parameters
  # * +otherHelp+ : The help we want to compare the current object to.
  #
  # ===== Returns
  # This method returns the boolean value of this operation :
  #    super(otherHelp) && @column == otherHelp.column && @row == otherHelp.row
  def ==(otherHelp)
    return(super(otherHelp) && @column == otherHelp.column && @row == otherHelp.row)
  end
end
