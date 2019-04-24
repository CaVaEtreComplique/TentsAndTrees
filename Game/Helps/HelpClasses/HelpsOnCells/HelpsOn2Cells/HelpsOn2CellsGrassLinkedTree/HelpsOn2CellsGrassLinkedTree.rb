# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpsOn2CellsGrassLinkedTree.rb
# @Last modified by:   Sckylle
# @Last modified time: 24-Apr-2019

require File.dirname(__FILE__) + "/../HelpOn2Cells"

##
# ===== Presentation
# The HelpsOn2CellsGrassLinkedTree class is inherited from the HelpOn2Cells
# abstract class. When a part of the grid has a tent for every
# tree, this help will show a text telling that any empty cell in this part of
# the grid should be grass. This class is instanciable.
#
# ===== Methods
# This class' methods are its constructor and the getText method from the
# HelpOn2Cells class.
class HelpsOn2CellsGrassLinkedTree < HelpOn2Cells

  # :nodoc:
  public_class_method :new
  # :startdoc:

  ##
  # ===== Presentation
  # The class' constructor that is here to initialize the two variables taken in
  # parameters with the initialize method from the HelpOn2Cells class.
  #
  # ===== Parameters
  # * +cellTent+ : One of the two cells needed, this one is a tent.
  # * +cellTree+ : The other one of the two cells, this one is a tree.
  def initialize(cellTent, cellTree)
    super(cellTent, cellTree)
  end

  ##
  # ===== Presentation
  # This method fetches the text from the XML file to show the help text.
  #
  # ===== Parameters
  # * +helpLevel+ : The help's importance. The higher the level, the better the advice.
  #
  # ===== Returns
  # This method fetches the help text from the XML file and returns it depending
  # on the help level.
  #
  # ===== Examples
  # When the help level is at 1, this method fetches the text only without giving
  # any variable's value :
  #    return @textManager.getHelpsTexts("grasslinkedtree", helpLevel, 0)
  # This will send to the player the following help text :
  #    "A tree network is complete"
  #
  # But when the help level is at 3, this method fetches the text and gives the
  # two cells values so that the player will know where to act :
  #    return @textManager.getHelpsTexts("grasslinkedtree", helpLevel, 0) + @cell.to_s + @textManager.getHelpsTexts("grasslinkedtree", helpLevel, 1) + @cell2.to_s + @textManager.getHelpsTexts("grasslinkedtree", helpLevel, 2)
  # This will send to the player the following text, with c1 and c2 being
  # respectively the coordinates of cell 1 and cell 2 :
  #    "The cell c1 is grass because the tree network on c2 is complete"
  def getText(helpLevel)
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
