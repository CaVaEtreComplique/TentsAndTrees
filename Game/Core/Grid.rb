# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Grid.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019



require File.dirname(__FILE__) + "/Cell"

class Grid
	@rows
	@cols

	attr_reader :rows, :cols

	def initialize(nRow, nCol,gridAnswers,withAnswers=false)
		ProcessStatus.send("Initialisation de la grille de jeu")
		@gridAnswers=gridAnswers
		@rows = (0..nRow-1).map {|x|
			(0..nCol-1).map { |y|
				if @gridAnswers.at(x).at(y)=='A'
					Cell.new(state: :tree,frozen: false)
				elsif @gridAnswers.at(x).at(y)=='T' && withAnswers
					Cell.new(state: :tent,frozen: false)
				elsif @gridAnswers.at(x).at(y)=='_' && withAnswers
					Cell.new(state: :grass,frozen: false)
				else
					Cell.new
				end
			}
		}
		@cols = @rows.transpose
	end

	def copyFrozen
		newG = Grid.new(@rows.size, @cols.size,@gridAnswers)
		@rows.zip(newG.rows).each {|oldRow, newRow|
			oldRow.zip(newRow).each { |oldCell, newCell|
				newCell.frozenOf(oldCell)
			}
		}
		return newG
	end

	def cellAt(row, col)
		return @rows[row][col]
	end

	def ==(otherGrid)
		@rows.each_with_index{ |cols,x|
			cols.each_with_index { |_,y|
				return false unless self.cellAt(x,y)==otherGrid.cellAt(x,y)
			}
		 }
		true
	end

end
