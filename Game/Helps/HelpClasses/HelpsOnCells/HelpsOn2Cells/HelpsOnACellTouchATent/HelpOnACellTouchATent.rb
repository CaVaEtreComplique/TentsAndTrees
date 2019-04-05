# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOnACellTouchATent.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019



require File.dirname(__FILE__) + "/../HelpOn2Cells"

class HelpOnACellTouchATent < HelpOn2Cells
  #a class for helping when a cell touch a tent, so the cell is grass
  public_class_method :new #instanciable
  def initialize(cell, tentCell)
    super(cell, tentCell)
  end

  def getText(helpLevel) #celltouchatent
    #returns the text of the help, saying that a cell touch a class and is some grass
    case helpLevel
      when 1
        return @textManager.getHelpsTexts("celltouchatent", helpLevel, 0)
      when 2
        return @textManager.getHelpsTexts("celltouchatent", helpLevel, 0)
      when 3
        return @textManager.getHelpsTexts("celltouchatent", helpLevel, 0) + @cell.to_s + @textManager.getHelpsTexts("celltouchatent", helpLevel, 1) + @cell2.to_s+ @textManager.getHelpsTexts("celltouchatent", helpLevel, 2)
      else
          super(helpLevel)
    end
  end
end
