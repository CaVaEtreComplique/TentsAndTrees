# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellTooFarOfTrees.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpOn1Cell"

##
# ===== Presentation
# The HelpCellTooFarOfTrees class is inherited from the HelpOn1Cell class. This
# class is used to help the player finding a white cell which isn't near a tree.
# This class is instanciable.
#
# ===== Methods
# This class' methods are the constructor, which just calls the parent class'
# constructor, and the getText method.
class HelpCellTooFarOfTrees < HelpOn1Cell
  # :nodoc:
  public_class_method :new
  # :startdoc:

  ##
  # ===== Presentation
  # The initialize method just calls the initialize method from HelpOn1Cell with
  # the cell taken in parameters.
  #
  # ===== Example :
  #   def initialize(cell)
  #     super(cell)
  #   end
  def initialize(cell)
    super(cell)
  end

  ##
  # ===== Presentation
  # The getText method returns the help text saying that the cell must be grass.
  # This text is taken in an XML file so that the text depends on the language
  # chosen by the player.
  #
  # ===== Parameters
  # * +helpLevel+ : The help's importance.
  #
  # ===== Returns
  # Depending on the help level, the text given will not be the same. The higher
  # the level is, the more precise and expensive the help is.
  #
  # ===== Examples
  #   case helpLevel
  #    when 1
  #       @helpText = @textManager.getHelpsTexts("toofaroftrees", helpLevel, 0)
  #    when 2
  #        @helpText = @textManager.getHelpsTexts("toofaroftrees", helpLevel, 0)
  #    when 3
  #        @helpText = @textManager.getHelpsTexts("toofaroftrees", helpLevel, 0) + @cell.to_s + @textManager.getHelpsTexts("toofaroftrees", helpLevel, 1)
  #     else
  #        super(helpLevel)
  #    end
  def getText(helpLevel)
    case helpLevel
    when 1
        @helpText = @textManager.getHelpsTexts("toofaroftrees", helpLevel, 0)
    when 2
        @helpText = @textManager.getHelpsTexts("toofaroftrees", helpLevel, 0)
    when 3
        @helpText = @textManager.getHelpsTexts("toofaroftrees", helpLevel, 0) + @cell.to_s + @textManager.getHelpsTexts("toofaroftrees", helpLevel, 1)
      else
          super(helpLevel)
    end
  end
end
