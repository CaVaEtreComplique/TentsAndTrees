# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOnACellTouchATent.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpOn2Cells"

##
# ===== Presentation
# The HelpOnACellTouchATent class is inherited from the HelpOn2Cells
# abstract class. It shows a help text to the player when a cell nearby a tent
# is empty, telling the player that it has to be grass. This class is
# instanciable.
#
# ===== Methods
# This class has an inherited constructor from the HelpOn2Cells class and the
# getText method.
class HelpOnACellTouchATent < HelpOn2Cells

  # :nodoc:
  public_class_method :new
  # :startdoc:

  ##
  # ===== Presentation
  # The class' constructor that is here to initialize the two variables taken in
  # parameters with the initialize method from the HelpOn2Cells class.
  #
  # ===== Parameters
  # * +cell+ : The empty cell that has to be grass.
  # * +tentcell+ : The tent cell nearby.
  def initialize(cell, tentCell)
    super(cell, tentCell)
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
  #    return @textManager.getHelpsTexts("celltouchatent", helpLevel, 0)
  # This will send to the player the following help text :
  #    "There is at least one cell nearby a tent"
  #
  # But when the help level is at 3, this method fetches the text and gives the
  # two cells values so that the player will know where to act :
  #    return @textManager.getHelpsTexts("celltouchatent", helpLevel, 0) + @cell.to_s + @textManager.getHelpsTexts("celltouchatent", helpLevel, 1) + @cell2.to_s+ @textManager.getHelpsTexts("celltouchatent", helpLevel, 2)
  # This will send to the player the following text, with c and tC being
  # respectively the coordinates of cell and tentCell :
  #    "The cell c is nearby the tent on tC so it must be grass"
  def getText(helpLevel)
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
