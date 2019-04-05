# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpOn3Cells.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpOnCells"

##
# ===== Presentation
# The HelpOn3Cells class is an abstract class inherited from HelpOnCells.
# Its direct child is HelpsOnACellOverlap.
#
# This class is a model for all the help classes that will need to know or
# return three cells.
#
# ===== Methods
# This class overrides the initialize, cellsList and '==' methods from
# helpOnCells.
#
# ===== Variables
# * +cell2+ and +cell3+ : This class adds two cells to the one given in HelpOnCells, the helps on 3 cells needing three of them.
class HelpOn3Cells < HelpOnCells

  # :nodoc:
  attr_reader :cell2, :cell3
  # :startdoc:

  ##
  # ===== Presentation
  # This class' constructor initializes the three variables taken in attributes as
  # described below :
  #
  # ===== Attributes
  # * +cell1+ : The first cell needed for the help, here it already exists in the parent class so we do not need to create it.
  # * +cell2+ and +cell3+ : The second and third cells needed for the help, these are created in this class.
  # ===== Example
  # Here is what this method does :
  #   def initialize(cell1, cell2, cell3)
  #      @cell2 = cell2
  #      @cell3 = cell3
  #      super(cell1)
  #   end
  def initialize(cell1, cell2, cell3)
    @cell2 = cell2
    @cell3 = cell3
    super(cell1)
  end

  ##
  # ====== Presentation
  # The cellsList method from this class overrides this method from the
  # HelpOnCells class.
  #
  # ===== Attributes
  # * +helpLevel+ : The help's importance, the higher the level is, the more helpful and precise it is and the more expensive it is.
  #
  # ===== Returns
  # This method returns the cells list, the help level decides whether or not the
  # cell2 and cell3 should be in it or not. This method is here so that when the player
  # needs help the text shown gives the cell's position, but only if the previous
  # texts didn't help the player enough.
  #
  # ===== Example
  #   def cellsList(helpLevel)
  #      list = super(helpLevel)
  #      if(helpLevel == 3)
  #         return list.push(@cell2).push(@cell3)
  #      end
  #      return list
  #   end
  def cellsList(helpLevel)
    list = super(helpLevel)
    if(helpLevel == 3)
      return list.push(@cell2).push(@cell3)
    end
    return list
  end

  ##
  # ===== Presentation
  # The == method overrides the == method in HelpOnCells. It is here
  # to compare this object with the help taken in parameters.
  #
  # ===== Attributes
  # * +otherHelp+ : The help we want to compare to this one.
  #
  # ===== Returns
  # This method returns a boolean being the result of this expression :
  #    super(otherHelp) && @cell2 == otherHelp.cell2 && @cell3 == otherHelp.cell3
  # This boolean will determine whether or not the current object is the same as the
  # one taken in parameters.
  # ----------
  def ==(otherHelp)
    return(super(otherHelp) && @cell2 == otherHelp.cell2 && @cell3 == otherHelp.cell3)
  end
end
