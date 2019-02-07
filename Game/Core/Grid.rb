require File.dirname(__FILE__) + "/Cell"

class Grid
	@rows
	@cols

	attr_reader :rows, :cols

	def initialize(nRow, nCol,gridAnswers)
		@gridAnswers=gridAnswers
		@rows = (0..nRow-1).map {|x|
			(0..nCol-1).map { |y|
				if @gridAnswers.at(x).at(y)=='A'
					Cell.new(state: :tree,frozen: false)
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

end
