# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOn1Cell.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpOnCells"

class HelpOn1Cell < HelpOnCells
  #abstract class
  def initialize(cell)
    super(cell)
  end
end
