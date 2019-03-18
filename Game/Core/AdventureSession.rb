# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Session.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019

require File.dirname(__FILE__) + "/Session"

class AdventureSession < Session

	attr_reader :game, :gridPick, :time, :score, :difficulty, :stars
	# attr_writer :score

	def initialize(gameMode, difficulty, scoreMultiplier)
		super(gameMode, difficulty)
    @scoreMultiplier = scoreMultiplier
    @stars = 0
	end

	def calculateScore
    case @gameMode
    when :timeAttack
        @score+= (@game.time*@game.time)
        @score*=@scoreMultiplier
				puts self.calculateStars
				@score
    when :quickplay
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

  def calculateStars
		@maxScore = @gridPick.associatedTimer * @gridPick.associatedTimer * @scoreMultiplier
    case @difficulty
    when :easy
				if @score > @maxScore*(3/4)
					@stars = 3
				end
				if @score > @maxScore*(2/3)
					@stars = 2
				end
				if @score > @maxScore*(1/3)
					@stars = 1
				end

    when :medium

    when :medium

    end
  end


end
