# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOn1Cell.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpOnCells"

##
# The HelpOn1Cell class is an abstract class inherited from the HelpOnCells
# class. It is a model for all the help classes that will only need to know one
# cell. This class only knows the initialize method and it just calls the
# initialize method from HelpOnCells with a cell in parameters.
class HelpOn1Cell < HelpOnCells
   #:nodoc:
  def initialize(cell)
    super(cell)
  end
  def cellsList(helpLevel)
    return super(helpLevel)
  end

end
