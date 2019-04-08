# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOnCells.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../Help"

##
# ===== Presentation
# The HelpOnCells class is inherited from the Help class and its direct children
# are HelpOn1Cell, HelpOn2Cells and HelpOn3Cells.
#
# ===== Methods
# This class knows its constructor, the cellsList method and the '==' method. All
# these methods are overloads of the Help class.
class HelpOnCells < Help

   # :nodoc:
  attr_reader :cell
  # :startdoc:

  ##
  # This class' constructor assigns a value to the @cell variable and calls
  # constructor from the Help class.
  def initialize(cell)
    @cell = cell
    super()
  end

  ##
  # This method adds to the help list the value of the cell.
  # ===== Parameters
  # * +helpLevel+ : The help's importance needed. Here, the cell is pushed only in case of lvl 3 help
  #
  # ===== Returns
  # This method returns the help list.
  # ----------
  def cellsList(helpLevel)
    list = super(helpLevel)
    if(helpLevel == 3)
      list.push(@cell)
    end
    return list
  end

  ##
  # This method compares this help with another one.
  # ===== Parameters
  # * +otherHelp+ : The help we want to compare the current object to.
  #
  # ===== Returns
  # This method returns the boolean value of this operation :
  #      super(otherHelp) && @cell == otherHelp.cell
  # ----------
  def ==(otherHelp)
    return(super(otherHelp) && @cell == otherHelp.cell)
  end
end
