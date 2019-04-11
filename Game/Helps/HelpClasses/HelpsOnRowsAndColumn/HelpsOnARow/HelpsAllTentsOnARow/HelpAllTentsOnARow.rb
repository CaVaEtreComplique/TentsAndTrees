# @Author: Maxime Touze <Maxime>
# @Date:   08-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpAllTentsOnARow.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpOneRow"

##
# ===== Presentation
# The HelpAllTentsOnARow class is inherited from the HelpOneRow abstract
# class. It is used when all the tents on a row are placed so that the player
# knows that the remaining cells on the row are grass.
#
# ===== Variables
# * +row+ : The row that has all of its tents placed.
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
class HelpAllTentsOnARow < HelpOneRow

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
  #     @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 0)
  # This will send to the player the following help text :
  #    "You have placed every tent for a row"
  #
  # But when the help level is at 3, this method fetches the text and gives the
  # column's value so that the player will know where to act :
  #    @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 0) + @row[0].column.to_s + @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 1)
  # This will send to the player the following text, with r being the row :
  #    "You have placed every tent for the row r so all remaining cells on it are grass"
  def getText(helpLevel)
    case(helpLevel)
      when 1
        @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 0)
      when 2
        @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 0)
      when 3
        @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 0) + @row[0].getVisualRankColumn.to_s + @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 1)
      else
          super(helpLevel)
      end
  end
end
