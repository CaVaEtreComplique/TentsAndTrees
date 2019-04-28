# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellsAndColumns.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019



require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

##
# ===== Presentation
# The HelpCellsAndColumns class is an abstract class inherited from the abstract
# class HelpCellsAndRowsOrColumns. This abstract class will determine a model
# for every help class that needs to know a cell and a column.
#
# This class' direct child is the HelpAllPossibilitiesGiveItColumn class.
class HelpCellsAndColumns < HelpCellsAndRowsOrColumns

##
# ===== Presentation
# This method only does what the initialize method in HelpCellsAndRowsOrColumns
# does, but with a column instead of a row XOR a column.
  def initialize(cell, column)
    super(cell, column)
  end

  ##
  # ===== Presentation
  # The cellsList method is a redefinition from the Help class.
  #
  # ===== Attributes
  # * +helpLevel+ : The help's importance.
  #
  # ===== Returns
  # This method returns the result of this method in the parent class so an array
  # with the column, like this :
  #   @column.each{ |cell|
  #      res.push(cell)
  #   }
  def cellsList(helpLevel)
    #in the 3 cases, we need the column
    res = super(helpLevel)
    @column.each{ |cell|
      res.push(cell)
     }
    return res
  end
end
