require File.dirname(__FILE__) + "/Guess"
require File.dirname(__FILE__) + "/Grid"
require File.dirname(__FILE__) + "/GridGenerator"

class Game
	@currentGuess
	@rowClues
	@colClues
	@nCol
	@nRow

	attr_reader :rowClues, :colClues, :nRow, :nCol, :currentGuess

	def initialize(oGrid,gameMode,save=nil)
		@rowClues = oGrid.rows
		@colClues = oGrid.cols
		@nCol = oGrid.nCols
		@nRow = oGrid.nCols
		@gridAnswers = oGrid.answers
		@currentGuess = Guess.new(Grid.new(@nRow, @nCol,@gridAnswers))
	end

	def resetGrid
		@currentGuess = Guess.new(Grid.new(@nRow, @nCol,@gridAnswers))
	end

	def beginGuess
		@currentGuess = @currentGuess.next()
	end

	def removeGuess
		@currentGuess = @currentGuess.prev()
	end

	def cellAt(row, col)
		@currentGuess.cellAt(row, col)
	end


	def undo
		@currentGuess.undo
	end

	def redo
		@currentGuess.redo
	end

	def addmove(cellState)
		@currentGuess.addmove(cellState)
	end

end
