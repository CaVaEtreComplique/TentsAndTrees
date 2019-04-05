# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellTooFarOfTrees.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019



require File.dirname(__FILE__) + "/../HelpOn1Cell"

class HelpCellTooFarOfTrees < HelpOn1Cell
  #Help the player to find a white cell whitch isn't adjacent a tree

  public_class_method :new #Instanciable
  def initialize(cell)
    #the cell don't touch a tree
    super(cell)
  end

  def getText(helpLevel) #toofaroftrees
    #returns the text of the help, saying that the cell is grass
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
