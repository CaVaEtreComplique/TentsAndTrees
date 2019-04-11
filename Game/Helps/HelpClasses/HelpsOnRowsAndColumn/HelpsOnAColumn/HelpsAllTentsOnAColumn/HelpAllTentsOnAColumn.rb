# @Author: Maxime Touze <Maxime>
# @Date:   06-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpAllTentsOnAColumn.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpOnAColumn"

##
# ===== Presentation
# The HelpAllTentsOnAColumn class is inherited from the HelpOnAColumn abstract
# class. It is used when all the tents on a column are placed so that the player
# knows that the remaining cells on the column are grass.
#
# ===== Variables
# * +column+ : The column that has all of its tents placed.
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
class HelpAllTentsOnAColumn < HelpOnAColumn

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
  #     @helpText = @textManager.getHelpsTexts("alltentsoncolumn", helpLevel, 0)
  # This will send to the player the following help text :
  #    "A column has all its tents placed"
  #
  # But when the help level is at 3, this method fetches the text and gives the
  # column's value so that the player will know where to act :
  #    @helpText = @textManager.getHelpsTexts("alltentsoncolumn", helpLevel, 0) + @column[0].row.to_s + @helpText = @textManager.getHelpsTexts("alltentsoncolumn", helpLevel, 1)
  # This will send to the player the following text, with c being the column :
  #    "All the tents on the column c have been placed so the remaining cells are grass"
  def getText(helpLevel)
    case(helpLevel)
      when 1
        @helpText = @textManager.getHelpsTexts("alltentsoncolumn", helpLevel, 0)
      when 2
        @helpText = @textManager.getHelpsTexts("alltentsoncolumn", helpLevel, 0)
      when 3
        @helpText = @textManager.getHelpsTexts("alltentsoncolumn", helpLevel, 0) + @column[0].getVisualRankRow.to_s + @helpText = @textManager.getHelpsTexts("alltentsoncolumn", helpLevel, 1)
      else
          super(helpLevel)
      end
  end
end
