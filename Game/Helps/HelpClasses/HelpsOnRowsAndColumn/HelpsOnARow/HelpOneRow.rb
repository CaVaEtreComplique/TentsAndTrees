# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOneRow.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn"

##
# ==== Presentation
# The HelpOneRow abstract class is inherited from the HelpOnRowsAndColumn
# abstract class and its direct children are HelpAllGrassOnARow and
# HelpAllTentsOnARow. This is the main help when only a row is needed to
# help the player.
#
# Its two methods are the class' constructor and the cellsList method.
# The class' constructor only calls the constructor of the parent class.
#
# ===== Examples :
# The class' constructor :
#  def initialize(row)
#    super(row)
#  end
class HelpOneRow < HelpOnRowsAndColumn

  # :nodoc:
  private_class_method :new

  def initialize(row)
    super(row)
  end
  # :startdoc:

  ##
  # ====== Presentation
  # The cellsList method from this class overrides this method from the
  # HelpOnRowsAndColumn class.
  #
  # ===== Attributes
  # * +helpLevel+ : The help's importance, the higher the level is, the more helpful and precise it is and the more expensive it is.
  #
  # ===== Returns
  # This method returns the cells list, the help level decides whether the
  # cell should be in it or not. This method is here so that when the player
  # needs help the text shown gives the cell's position, but only if the previous
  # texts didn't help the player enough.
  #
  # ===== Example
  #   def cellsList(helpLevel)
  #      res = super(helpLevel)
  #      if(helpLevel == 3)
  #        @column.each{ |cell|
  #          res.push(cell)
  #        }
  #      end
  #      return res
  #   end
  def cellsList(helpLevel)
    res = super(helpLevel)
    if(helpLevel == 3)
      @row.each{ |cell|
        res.push(cell)
       }
     end
    return res
  end
end
