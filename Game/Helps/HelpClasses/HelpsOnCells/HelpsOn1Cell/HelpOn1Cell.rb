# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOn1Cell.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpOnCells"

##
# ==== Presentation
# The HelpOn1Cell class is inherited from the HelpOnCells class and its only
# direct child is the HelpCellTooFarOfTrees class. This class consists of
# overrides of the parent class. Its two methods are the class' constructor
# and the cellsList method and they just call the parent method with their
# attributes.
# ===== Examples :
# The class' constructor :
#   def initialize(cell)
#     super(cell)
#   end
#
# The cellsList method :
#  def cellsList(helpLevel)
#     return super(helpLevel)
#  end
class HelpOn1Cell < HelpOnCells
   #:nodoc:
  def initialize(cell)
    super(cell)
  end

  def cellsList(helpLevel)
    return super(helpLevel)
  end

end
