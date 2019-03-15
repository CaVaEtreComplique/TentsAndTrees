# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellsAndColumns.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

class HelpCellsAndColumns < HelpCellsAndRowsOrColumns
  #abstract class

  def initialize(cell, column)
    super(cell, column)
  end
end
