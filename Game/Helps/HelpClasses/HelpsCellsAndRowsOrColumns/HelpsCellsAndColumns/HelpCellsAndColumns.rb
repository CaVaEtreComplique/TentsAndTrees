# @Author: Maxime Touze <Maxime>
# @Date:   04-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpCellsAndColumns.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpCellsAndRowsOrColumns"

##
# The HelpCellsAndColumns class is an abstract class inherited from the abstract
# class HelpCellsAndRowsOrColumns. This abstract class will determine a model
# for every help class that needs to know a cell and a column. The only method
# this class knows is its initialization method.
class HelpCellsAndColumns < HelpCellsAndRowsOrColumns
  #abstract class

##
# This method only does what the initialize method in HelpCellsAndRowsOrColumns
# does, but with a column instead of a row XOR a column.
  def initialize(cell, column)
    super(cell, column)
  end
