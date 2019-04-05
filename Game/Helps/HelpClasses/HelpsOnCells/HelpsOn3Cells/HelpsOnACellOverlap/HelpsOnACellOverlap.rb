# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpsOnACellOverlap.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019



require File.dirname(__FILE__) + "/../HelpOn3Cells"


class HelpsOnACellOverlap < HelpOn3Cells
  #a class for helping when a cell touch a tent, so the cell is grass
  public_class_method :new #instanciable
  def initialize(cellGrass, cellwhite1, cellwhite2)
    super(cellGrass, cellwhite1, cellwhite2)
  end

  def getText(helpLevel) #overlap
    #returns the text of the help, saying that a cell touch a class and is some grass
    case helpText
      when 1
        return @textManager.getHelpsTexts("overlap", helpLevel, 0)
      when 2
        return @textManager.getHelpsTexts("overlap", helpLevel, 0)
      when 3
        return @textManager.getHelpsTexts("overlap", helpLevel, 0) + @cell.to_s + @textManager.getHelpsTexts("overlap", helpLevel, 1) + @cell2.to_s + @textManager.getHelpsTexts("overlap", helpLevel, 2) + @cell3.to_s + @textManager.getHelpsTexts("overlap", helpLevel, 3)
      else
          super(helpLevel)
    end
  end
end
