# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpsOn2CellUniqueSolution.rb
# @Last modified by:   maxime
# @Last modified time: 31-Mar-2019



require File.dirname(__FILE__) + "/../HelpOn2Cells"

class HelpsOn2CellTentUniqueSolution < HelpOn2Cells
  #a class for helping when a cell is link to a tree because of only one posibility
  public_class_method :new #instanciable
  def initialize(cellTent, cellTree)
    super(cellTent, cellTree)
  end

  def getText(helpLevel) #unicsolution
    #returns the text of the help, saying that a cell touch a class and is some grass
    case helpLevel
      when 1
        return @textManager.getHelpsTexts("unicsolution", helpLevel, 0)
      when 2
        return @textManager.getHelpsTexts("unicsolution", helpLevel, 0)
      when 3
        return @textManager.getHelpsTexts("unicsolution", helpLevel, 0) + @cell.to_s + @textManager.getHelpsTexts("unicsolution", helpLevel, 1) + @cell2.to_s
      else
          super(helpLevel)
    end
  end
end
