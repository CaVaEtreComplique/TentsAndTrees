# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpsOnACellOverlap.rb
# @Last modified by:   Sckylle
# @Last modified time: 24-Apr-2019

require File.dirname(__FILE__) + "/../HelpOn3Cells"

##
# ===== Presentation
# The HelpsOnACellOverlap class is inherited from the HelpOn3Cells abstract class.
# This class shows the player a text saying that when 3 empty cells are adjacent,
# the middle one can only be grass when a tent is nearby. This class is instanciable.
#
# ===== Methods
# This class has an inherited constructor from the HelpOn3Cells class and the
# getText method.
class HelpsOnACellOverlap < HelpOn3Cells

   # :nodoc:
  public_class_method :new
  # :startdoc:

  ##
  # ===== Presentation
  # The class' constructor that is here to initialize the three variables taken in
  # parameters with the initialize method from the HelpOn3Cells class.
  #
  # ===== Parameters
  # * +cellGrass+ : The empty cell that has to be grass.
  # * +cellwhite1+ and +cellwhite2+ : The two empty cells nearby.
  def initialize(cellGrass, cellwhite1, cellwhite2)
    super(cellGrass, cellwhite1, cellwhite2)
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
  #     return @textManager.getHelpsTexts("overlap", helpLevel, 0)
  # This will send to the player the following help text :
  #    "Two white cells leave only one possible state for a third one"
  #
  # But when the help level is at 3, this method fetches the text and gives the
  # three cells' values so that the player will know where to act :
  #    return @textManager.getHelpsTexts("overlap", helpLevel, 0) + @cell.to_s + @textManager.getHelpsTexts("overlap", helpLevel, 1) + @cell2.to_s + @textManager.getHelpsTexts("overlap", helpLevel, 2) + @cell3.to_s + @textManager.getHelpsTexts("overlap", helpLevel, 3)
  # This will send to the player the following text, with cG, cw1 and cw2 being
  # respectively the coordinates of cellGrass, cellwhite1 and cellwhite2 :
  #    "The cell cG is nearby the two white cells cw1 and cw2 and therefore is grass"
  def getText(helpLevel)
    case helpLevel
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
