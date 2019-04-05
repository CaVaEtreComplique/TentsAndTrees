# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpsOn2CellsGrassLinkedTree.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019



require File.dirname(__FILE__) + "/../HelpOn2Cells"

class HelpsOn2CellsGrassLinkedTree < HelpOn2Cells
  #a class for helping when a cell is link to a tree because of only one posibility
  public_class_method :new #instanciable
  def initialize(cellTent, cellTree)
    super(cellTent, cellTree)
  end

  def getText(helpLevel) #grasslinkedtree
    #returns the text of the help, saying that a cell touch a class and is some grass
    case helpLevel
      when 1
        return @textManager.getHelpsTexts("grasslinkedtree", helpLevel, 0)
      when 2
        return @textManager.getHelpsTexts("grasslinkedtree", helpLevel, 0)
      when 3
        return @textManager.getHelpsTexts("grasslinkedtree", helpLevel, 0) + @cell.to_s + @textManager.getHelpsTexts("grasslinkedtree", helpLevel, 1) + @cell2.to_s + @textManager.getHelpsTexts("grasslinkedtree", helpLevel, 2)
      else
          super(helpLevel)
    end
  end
end
