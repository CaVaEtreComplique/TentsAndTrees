# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellsAndRows.rb
# @Last modified by:   maxime
# @Last modified time: 28-Mar-2019

require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

##
# The HelpCellsAndRows class is an abstract class inherited from the abstract
# class HelpCellsAndRowsOrColumns. This abstract class will determine a model
# for every help class that needs to know a cell and a row. The only method
# this class knows is its initialization method.
class HelpCellsAndRows < HelpCellsAndRowsOrColumns

##
# This method only does what the initialize method in HelpCellsAndRowsOrColumns
# does, but with a row instead of a row XOR a column.
  def initialize(cell, row)
    super(cell, row)
  end

  def cellsList(helpLevel)
    res = super(helpLevel)
    @row.each{ |cell|
      res.push(cell)
     }
    return res
  end
end
