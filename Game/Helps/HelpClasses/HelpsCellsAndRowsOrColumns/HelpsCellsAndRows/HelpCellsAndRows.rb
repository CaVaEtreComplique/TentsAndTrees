# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellsAndRows.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

class HelpCellsAndRows < HelpCellsAndRowsOrColumns
  #abstract class
  #help about a cell and a row

  def initialize(cell, row)
    super(cell, row)
  end
end
