# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Game.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019



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

	attr_reader :rowClues, :colClues, :nRow, :nCol, :currentGuess, :correction
	attr_reader :chrono, :time

	def initialize(oGrid,gameMode,baseTime=0,save=nil)
		ProcessStatus.send("Initialisation de la Partie")
		@rowClues = oGrid.rows
		@colClues = oGrid.cols
		@nCol = oGrid.nCols.to_i
		@nRow = oGrid.nCols.to_i
		@gridAnswers = oGrid.answers
		@currentGuess = Guess.new(Grid.new(@nRow, @nCol,@gridAnswers))
		@correction =Grid.new(@nRow, @nCol,@gridAnswers,true)
    @moveDone=false
    @baseTime=baseTime
    (@chrono=GLib::Timer.new).stop
    @time=@chrono.elapsed[0]
	end

	def resetGrid
    @moveDone=true
		@currentGuess = Guess.new(Grid.new(@nRow, @nCol,@gridAnswers))
	end

	def beginGuess
		@currentGuess = @currentGuess.next()
	end

	def removeGuess
    @moveDone=true
		@currentGuess = @currentGuess.prev()
	end

	def cellAt(row, col)
		@currentGuess.cellAt(row, col)
	end


	def undo
    @moveDone=true
		@currentGuess.undo
	end

	def redo
    @moveDone=true
		@currentGuess.redo
	end

	def addmove(move,triRotative=true)
    @moveDone=true
		@currentGuess.addmove(move,triRotative)
	end

	def run
    @chrono.start
    lastTime=0
		loop do
      @time=(@baseTime-(@chrono.elapsed[0]).truncate).abs
			if @moveDone || @time!=lastTime
        lastTime=@time
				changed                 # notify observers
				notify_observers()
        # delete_observers()
        @moveDone=false
			end
			sleep(0.1)
		end
	end

end
