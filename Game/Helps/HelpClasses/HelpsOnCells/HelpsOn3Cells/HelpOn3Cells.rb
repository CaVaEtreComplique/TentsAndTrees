# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpOn3Cells.rb
# @Last modified by:   Sckylle
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpOnCells"

class HelpOn3Cells < HelpOnCells #Abstract class
  #A class whitch help the player and need two cells to help him
  def initialize(cell1, cell2, cell3)
    @cell2 = cell2
    @cell3 = cell3
    super(cell1)
  end
end
