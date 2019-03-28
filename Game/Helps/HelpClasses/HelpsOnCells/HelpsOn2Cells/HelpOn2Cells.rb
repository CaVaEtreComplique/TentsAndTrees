# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOn2Cells.rb
# @Last modified by:   maxime
# @Last modified time: 28-Mar-2019



require File.dirname(__FILE__) + "/../HelpOnCells"

class HelpOn2Cells < HelpOnCells #Abstract class
  #A class whitch help the player and need two cells to help him

  attr_reader :cell2

  def initialize(cell1, cell2)
    @cell2 = cell2
    super(cell1)
  end
  def cellsList(helpLevel)
    return super(helpLevel).push(@cell2)
  end

  def ==(otherHelp)
    return(super(otherHelp) && @cell2 == otherHelp.cell2)
  end
end
