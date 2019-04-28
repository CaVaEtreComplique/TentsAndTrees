# @Author: Maxime Touze <MaximeTouze>
# @Date:   09-Feb-2019
# @Email:  maxime_touze.etu@univ-lemans.fr
# @Filename: HelpNotFound.rb
# @Last modified by:   maxime
# @Last modified time: 31-Mar-2019

require File.dirname(__FILE__) + "/../Help"

##
# ===== Presentation
# The HelpNotFound class is inherited from the Help class. This class is
# instanciated when no help can be found.
class HelpNotFound < Help
   # :nodoc:
  public_class_method :new
  # :startdoc:

  ##
  # ===== Presentation
  # This method is a redefinition of the helpFound? method in the Help class.
  #
  # ===== Returns
  # It returns false because no help has been found.
  def helpFound?()
    return false
  end

  ##
  # ===== Presentation
  # The class' constructor calls the constructor from the parent class.
  def initialize()
    super()
  end

  ##
  # ===== Presentation
  # This method is a redefinition of the getText method in the Help class.
  #
  # ===== Returns
  # It returns a text saying that no help has been found.
  def getText(helpLevel) #notfound

    return @textManager.getHelpsTexts("notfound", 0, 0)
  end
end
