# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOnCells.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../Help"


class HelpOnCells < Help
  #abstract class
  #A help that help player, and need a cell to help him
  def initialize(cell)
    @cell = cell
    super()
  end
end
