# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Game.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 10-Feb-2019



require "observer"
require File.dirname(__FILE__) + "/Guess"
require File.dirname(__FILE__) + "/Grid"
require File.dirname(__FILE__) + "/GridGenerator"

class Game
  include Observable
	@currentGuess
	@correction
	@rowClues
	@colClues
	@nCol
	@nRow

	attr_reader :rowClues, :colClues, :nRow, :nCol, :currentGuess
	attr_reader :chrono

	def initialize(oGrid,gameMode,save=nil)
		ProcessStatus.send("Initialisation de la Partie")
		@rowClues = oGrid.rows
		@colClues = oGrid.cols
		@nCol = oGrid.nCols
		@nRow = oGrid.nCols
		@gridAnswers = oGrid.answers
		@currentGuess = Guess.new(Grid.new(@nRow, @nCol,@gridAnswers,true))
		@correction =Grid.new(@nRow, @nCol,@gridAnswers,true)
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

	def addmove(move,triRotative=true)
		@currentGuess.addmove(move,triRotative)
	end

	def run
		loop do
			if (@currentGuess.grid)==@correction
				changed                 # notify observers
				notify_observers()
        delete_observers()
			end
			sleep(0.1)
		end
	end

end
