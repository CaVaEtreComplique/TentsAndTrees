# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellsAndRows.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

##
# ===== Presentation
# The HelpCellsAndRows class is an abstract class inherited from the abstract
# class HelpCellsAndRowsOrColumns. This abstract class will establish a model
# for every help class that needs to know a cell and a row.
# This class has a constructor and overrides the cellsList method.
#
# This class' direct child is the HelpAllPossibilitiesGiveItRow class.
class HelpCellsAndRows < HelpCellsAndRowsOrColumns

##
# ===== Presentation
# This method only does what the initialize method in HelpCellsAndRowsOrColumns
# does, but with a row instead of a row XOR a column.
  def initialize(cell, row)
    super(cell, row)
  end

  ##
  # ===== Presentation
  # This method overrides the cellsList method from the HelpCellsAndRowsOrColumns
  # class.
  #
  # ===== Attributes
  # * +helpLevel+ : The help's importance.
  #
  # ===== Returns
  # It returns an array with the rows added, whichever help level the
  # player is at.
  def cellsList(helpLevel)
    #in the 3 cases, we need the row
    res = super(helpLevel)
    @row.each{ |cell|
      res.push(cell)
     }
    return res
  end
end
