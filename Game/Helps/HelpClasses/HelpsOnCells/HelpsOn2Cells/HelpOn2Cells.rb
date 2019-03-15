# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOn2Cells.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpOnCells"

class HelpOn2Cells < HelpOnCells #Abstract class
  #A class whitch help the player and need two cells to help him
  def initialize(cell1, cell2)
    @cell2 = cell2
    super(cell1)
  end
  def cellsList
    return super().push(@cell2)
  end
end
