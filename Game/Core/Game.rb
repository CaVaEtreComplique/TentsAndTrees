# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Game.rb
# @Last modified by:   zeigon
# @Last modified time: 11-Apr-2019



require "observer"
require File.dirname(__FILE__) + "/Guess"
require File.dirname(__FILE__) + "/Grid"
require File.dirname(__FILE__) + "/GridGenerator"
require File.dirname(__FILE__) + "/../Helps/Helpers/Helper"


##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class Game
   # :nodoc:
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
    @time = @baseTime
    @malus = 0
    @curr, @min, @max = 1,1,3
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
    res = @helper.help(self)
    @malus += @helper.price
    res
  end

  def clearHelper
    @helper=nil
  end

  def manageHelp( min, max)
    @min, @max = min, max
    @helper = Helper.instance(min, max)
  end

	def run
    @helper = Helper.new(@min, @max)
    @chrono=GLib::Timer.new
    @chrono.start
    lastTime=0
    ["TERM", "INT", "QUIT"].each{ |sig|
        Signal.trap(sig) {
          @session.updateSave
          Gtk.main_quit
       }
    }
    case @session.gameMode
    when :timeAttack
      @baseTime-=@baseTime-@time
    when :tutorial
      @helper.helpLevelSetMinMax(3, 3)
    else
      @baseTime=-@time
    end
		loop do
      @malus *=-1 if@session.gameMode==:timeAttack
      @time=(@baseTime-@chrono.elapsed[0]).abs + @malus
			if @moveDone || @time!=lastTime
        lastTime=@time
				changed                 # notify observers
				notify_observers()
        @moveDone=false
			end
      @malus=@malus.abs if@session.gameMode==:timeAttack
			sleep(0.1)
		end
	end

end
