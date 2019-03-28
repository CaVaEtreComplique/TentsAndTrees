# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpOn3Cells.rb
# @Last modified by:   maxime
# @Last modified time: 28-Mar-2019



require File.dirname(__FILE__) + "/../HelpOnCells"

class HelpOn3Cells < HelpOnCells #Abstract class
  #A class whitch help the player and need two cells to help him

  attr_reader :cell2, :cell3

  def initialize(cell1, cell2, cell3)
    @cell2 = cell2
    @cell3 = cell3
    super(cell1)
  end
  def cellsList(helpLevel)
    return super(helpLevel).push(@cell2).push(@cell3)
  end

  def ==(otherHelp)
    return(super(otherHelp) && @cell2 == otherHelp.cell2 && @cell3 == otherHelp.cell3)
  end
end
