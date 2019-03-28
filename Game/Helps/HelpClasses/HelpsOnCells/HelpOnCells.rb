# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOnCells.rb
# @Last modified by:   maxime
# @Last modified time: 28-Mar-2019

require File.dirname(__FILE__) + "/../Help"

##
# The HelpOnCells class is an abstract class inherited from the Help class that
# is a model for all the classes that will help the player without knowing a row
# or a column. It only knows the initialization method that creates a cell from
# parameters and initializes the class with the initialize method from the Help
# class.
class HelpOnCells < Help
#:nodoc:

  attr_reader :cell

  def initialize(cell)
    @cell = cell
    super()
  end
  def cellsList(helpLevel)
    return super(helpLevel).push(@cell)
  end

  def ==(otherHelp)
    return(super(otherHelp)  && @cell == otherHelp.cell )
  end
end
