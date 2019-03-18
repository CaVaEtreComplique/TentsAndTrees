# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Grid.rb
# @Last modified by:   zeigon
# @Last modified time: 05-Mar-2019

require File.dirname(__FILE__) + "/Cell"


##
# ====Presentation
# The Grid class is the core of all the grids in the game.
#
# ====Variables
# Each Grid will know two variables : @rows and @cols : two array lists,
# respectively the grid's rows and the grid's columns, one being the transposed
# of the other.
#
# ====Methods
# This class knows the initialization method and the methods described below.
class Grid
	@rows
	@cols

	#:nodoc:
	attr_reader :rows, :cols
	#:startdoc:

	# ====Parameters
	# * +nRow+ - The number of rows
	# * +nCol+ - The number of columns
	# * +gridAnswers+ - The grid we take the data from
	# * +withAnswers+ - A boolean set by default to false.
	# If the gridAnswers contains the actual answers, the boolean is set to true.
	# The gridAnswers is taken from a text file.
	#
	# ====Variables initialization
	# In this method, the @rows list takes its values from the grid in parameters
	# by reading the text file. When the @rows variable is initialized, the @cols
	# variable can be initialized by just transposing the @rows variable.
	def initialize(nRow, nCol, gridAnswers, withAnswers=false)
		ProcessStatus.send("Initialisation de la grille de jeu")
		@gridAnswers=gridAnswers
		@rows = (0..nRow-1).map {|x|
			(0..nCol-1).map { |y|
				if @gridAnswers.at(x).at(y)=="A"
					Cell.new(state: :tree,frozen: false,row: x,column: y)
				elsif @gridAnswers.at(x).at(y)=="T" && withAnswers
					Cell.new(state: :tent,frozen: false,row: x,column: y)
				elsif @gridAnswers.at(x).at(y)=="_" && withAnswers
					Cell.new(state: :grass,frozen: false,row: x,column: y)
				else
					Cell.new(state: :white,frozen: false,row: x,column: y)
				end
			}
		}
		@cols = @rows.transpose
	end

	##
	# The copyFrozen method creates a new grid that will have all the non-white
	# cells frozen in order to save the unfrozen grid if the hypothesis is
	# rejected.
	#
	# ====Returns
	# * +newG+ - The grid that has been generated.
	#
	# -----
	def copyFrozen
		newG = Grid.new(@rows.size, @cols.size,@gridAnswers)
		@rows.zip(newG.rows).each {|oldRow, newRow|
			oldRow.zip(newRow).each { |oldCell, newCell|
				newCell.frozenOf(oldCell)
			}
		}
		return newG
	end

	# The each method goes through the grid's rows.
	def each
		yield @rows.each
	end

	# The cellAt method returns the cell with the coordinates taken in
	# parameters.
	# * +row+ - The row in which the cell we are looking for is.
	# * +col+ - The column in which the cell we are looking for is.
	#
	# -----
	def cellAt(row, col)
		return @rows[row][col]
	end

	# The == boolean method compares two grids and returns true if the grids are
	# equal.
	#
	# ====Parameters
	# * +otherGrid+ - The grid we want to compare the current grid with.
	#
	# -----
	def ==(otherGrid)
		@rows.each_with_index{ |cols,x|
			cols.each_with_index { |_,y|
				return false unless self.cellAt(x,y)==otherGrid.cellAt(x,y)
			}
		}
		true
	end

end
