# @Author: Maxime Touze <MaximeTouze>
# @Date:   09-Feb-2019
# @Email:  maxime_touze.etu@univ-lemans.fr
# @Filename: HelpNotFound.rb
# @Last modified by:   MaximeTouze
# @Last modified time: 13-Mar-2019

require File.dirname(__FILE__) + "/../Help"

##
# The HelpNotFound class is inherited from the Help class. This class is
# instanciated when no help can be found.
class HelpNotFound < Help
  #Class instanciated when any help has been found
  public_class_method :new #instanciable

  # This is a redefinition of the Help.helpFound? method. It returns false
  # because no help has been found.
  def helpFound?()
    return false
  end

  # This method is a redefinition of the Help.getText method. It returns a text
  # saying that no help has been found.
  def getText()
    return "Aucune aide trouvée"
  end
end
