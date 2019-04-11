# @Author: Maxime Touze <Maxime>
# @Date:   06-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpAllGrassOnARow.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpOneRow"

##
# ===== Presentation
# The HelpAllGrassOnARow class is inherited from the HelpOneRow abstract
# class. It is used when all the empty cells left on a row are tents so that
# the player knows when all the grass is placed.
#
# ===== Variables
# * +row+ : The row that has all its grass placed.
#
# ===== Methods
# This class knows its constructor and the getText method. The constructor only
# calls the parent class' constructor.
#
# ===== Examples
# This is the class' constructor. As said before, it only calls the parent
# constructor with the given parameters :
#
#   def initialize(column)
#     super(column)
#   end
class HelpAllGrassOnARow < HelpOneRow

  # :nodoc:
  public_class_method :new

  def initialize(row)
    super(row)
  end
  # :startdoc:

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
  #     @helpText = @textManager.getHelpsTexts("allgrassonrow", helpLevel, 0)
  # This will send to the player the following help text :
  #    "You have placed all of a row's grass"
  #
  # But when the help level is at 3, this method fetches the text and gives the
  # row's value so that the player will know where to act :
  #    @helpText = @textManager.getHelpsTexts("allgrassonrow", helpLevel, 0) + @row[0].column.to_s + @textManager.getHelpsTexts("allgrassonrow", helpLevel, 1)
  # This will send to the player the following text, with r being the row :
  #    "The remaining cells of the row r are tents because all of this row's grass has been placed"
  def getText(helpLevel)
    case(helpLevel)
      when 1
        @helpText = @textManager.getHelpsTexts("allgrassonrow", helpLevel, 0)
      when 2
        @helpText = @textManager.getHelpsTexts("allgrassonrow", helpLevel, 0)
      when 3
        @helpText = @textManager.getHelpsTexts("allgrassonrow", helpLevel, 0) + @row[0].getVisualRankColumn.to_s + @textManager.getHelpsTexts("allgrassonrow", helpLevel, 1)
      else
          super(helpLevel)
      end
  end
end
