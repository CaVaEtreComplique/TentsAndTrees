# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: AdventureLevel.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 15-Mar-2019

require File.dirname(__FILE__) + "/Session"

class AdventureLevel < Session

	attr_reader :game, :gridPick, :time, :score, :difficulty, :stars, :finishedGrid, :numberOfGrid
	# attr_writer :score

	def initialize(gameMode, difficulty, scoreMultiplier, maxStars,numberOfGrid )
		super(gameMode, difficulty,true)
    @scoreMultiplier = scoreMultiplier
		@maxStars = maxStars
		@numberOfGrid = numberOfGrid
		@finishedGrid =0
    @stars = 0
	end

	def continuable?
		case @gameMode
		when :timeAttack
			true
		when :quickplay
			false
		end
	end

	def calculateScore
    case @gameMode
    when :timeAttack
			if !@scoreMultiplier
				@finishedGrid+=1
				@score=+100
			else
				@finishedGrid+=1
        @score+= ((@game.time*@game.time)*@scoreMultiplier)/@numberOfGrid
			end
    when :quickplay
				@maxScore = @gridPick.associatedTimer * @gridPick.associatedTimer * @scoreMultiplier
        @score = [@gridPick.associatedTimer-@game.time,0].max * [@gridPick.associatedTimer-@game.time,0].max * @scoreMultiplier
	  end
	end

	def setTime
    case @gameMode
    when :timeAttack
        @time=@gridPick.associatedTimer
    when :quickplay
        @time=0
    end
	end

  def calculateStars(score)

  end


end
