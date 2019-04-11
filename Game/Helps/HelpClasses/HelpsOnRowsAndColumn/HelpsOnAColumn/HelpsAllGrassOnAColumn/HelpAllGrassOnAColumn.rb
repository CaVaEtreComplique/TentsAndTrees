# @Author: Maxime Touze <Maxime>
# @Date:   06-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpAllGrassOnAColumn.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpOnAColumn"

##
# ===== Presentation
# The HelpAllGrassOnAColumn class is inherited from the HelpOnAColumn abstract
# class. It is used when all the empty cells left on a column are tents so that
# the player knows when all the grass is placed.
#
# ===== Variables
# * +column+ : The column that has all its grass placed.
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
class HelpAllGrassOnAColumn < HelpOnAColumn

  # :nodoc:
  public_class_method :new

  def initialize(column)
    super(column)
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
  #     @helpText = @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 0)
  # This will send to the player the following help text :
  #    "You have placed all of a column's grass"
  #
  # But when the help level is at 3, this method fetches the text and gives the
  # column's value so that the player will know where to act :
  #    @helpText = @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 0) + @column[0].row.to_s + @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 1)
  # This will send to the player the following text, with c being the column :
  #    "All of the grass of the column c have been placed so the remaining empty cells are tents"
  def getText(helpLevel)
    case(helpLevel)
      when 1
        @helpText = @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 0)
      when 2
        @helpText = @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 0)
      when 3
        @helpText = @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 0) + @column[0].getVisualRankRow.to_s + @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 1)
      else
          super(helpLevel)
      end
  end
end
