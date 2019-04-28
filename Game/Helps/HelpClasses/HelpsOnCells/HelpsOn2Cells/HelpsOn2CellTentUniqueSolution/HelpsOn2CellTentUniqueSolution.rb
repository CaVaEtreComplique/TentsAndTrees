# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpsOn2CellUniqueSolution.rb
# @Last modified by:   Sckylle
# @Last modified time: 24-Apr-2019

require File.dirname(__FILE__) + "/../HelpOn2Cells"

##
# ===== Presentation
# The HelpsOn2CellTentUniqueSolution class is inherited from the HelpOn2Cells
# abstract class. It shows a help text to the player when a tree does not have
# a tent nearby and has an unique empty cell, meaning that this cell is obviously
# the tent for this tree. This class is instanciable.
#
# ===== Methods
# This class has an inherited constructor from the HelpOn2Cells class and the
# getText method.
class HelpsOn2CellTentUniqueSolution < HelpOn2Cells

  # :nodoc:
  public_class_method :new
  # :startdoc:

  ##
  # ===== Presentation
  # The class' constructor, it initializes each cell variable with the cell
  # taken in parameters. It uses the constructor from HelpOn2Cells to do so.
  #      def initialize(cellTent, cellTree)
  #        super(cellTent, cellTree)
  #      end
  def initialize(cellTent, cellTree)
    super(cellTent, cellTree)
  end

  ##
  # ===== Presentation
  # This method fetches the text from the XML file to show the help text.
  #
  # ===== Attributes
  # * +helpLevel+ : The help's importance. The higher the level, the better the advice.
  #
  # ===== Returns
  # This method fetches the help text from the XML file and returns it depending
  # on the help level.
  #
  # ===== Examples
  # When the help level is at 1, this method fetches the text only without giving
  # any variable's value :
  #        return @textManager.getHelpsTexts("unicsolution", helpLevel, 0)
  # This will send to the player the following help text :
  #    "A tree is without a tent and has an unique white cell nearby"
  #
  # But when the help level is at 3, this method fetches the text and gives the
  # two cells values so that the player will know where to act :
  #    return @textManager.getHelpsTexts("unicsolution", helpLevel, 0) + @cell.to_s + @textManager.getHelpsTexts("unicsolution", helpLevel, 1) + @cell2.to_s
  # This will send to the player the following text, with c1 and c2 being
  # respectively the coordinates of cell 1 and cell 2 :
  #    "The cell c1 is a tent because it is the only solution for the tree on c2."
  def getText(helpLevel)
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
