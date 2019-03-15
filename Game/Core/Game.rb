# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Game.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019



require "observer"
require File.dirname(__FILE__) + "/Guess"
require File.dirname(__FILE__) + "/Grid"
require File.dirname(__FILE__) + "/GridGenerator"
require File.dirname(__FILE__) + "/../Helps/Helpers/Helper"

class Game
  include Observable
	@currentGuess
	@correction
	@rowClues
	@colClues
	@nCol
	@nRow
  @helper

	attr_reader :rowClues, :colClues, :nRow, :nCol, :currentGuess, :correction
	attr_reader :chrono, :time, :baseTime, :session

  attr_writer :currentGuess, :time

	def initialize(session)
		ProcessStatus.send("Initialisation de la Partie")
    @session=session
		@rowClues = @session.gridPick.rows
		@colClues = @session.gridPick.cols
		@nCol = @session.gridPick.nCols.to_i
		@nRow = @session.gridPick.nCols.to_i
		@gridAnswers = @session.gridPick.answers
		@currentGuess = Guess.new(Grid.new(@nRow, @nCol,@gridAnswers))
		@correction =Grid.new(@nRow, @nCol,@gridAnswers,true)
    @moveDone=false
    @baseTime=@session.time
    # (@chrono=GLib::Timer.new).stop
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
		@currentGuess.addmove(move)
	end

  def calculateScore
    @session.calculateScore
  end

  def help
    return Helper.instance.help(self)
  end

	def run
    (@chrono=GLib::Timer.new).start
    lastTime=0
		loop do
      @time=(@baseTime-(@chrono.elapsed[0]).truncate).abs
			if @moveDone || @time!=lastTime
        lastTime=@time
				changed                 # notify observers
				notify_observers()
        @moveDone=false
			end
			sleep(0.1)
		end
	end

end
