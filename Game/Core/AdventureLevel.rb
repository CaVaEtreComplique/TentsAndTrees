# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: AdventureLevel.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 15-Mar-2019

require File.dirname(__FILE__) + "/Session"

class AdventureLevel < Session

	attr_reader :game, :gridPick, :time, :score, :difficulty, :stars, :finishedGrid, :numberOfGrid, :overallStars


	def initialize(gameMode, difficulty, scoreMultiplier, maxStars,numberOfGrid, overallStars, levelNumber )
		super(gameMode, difficulty,true)
    @scoreMultiplier = scoreMultiplier
		@maxStars = maxStars
		@numberOfGrid = numberOfGrid
		@finishedGrid =0
    @actualStars = 0
		@overallStars = overallStars
		@levelNumber = levelNumber
		@maxScore=0
	end

	def continuable?
		if numberOfGrid == 1
			false
		else
			true
		end
	end

	def calculateScore
    case @gameMode
    when :timeAttack
				@finishedGrid+=1
				@maxScore += @gridPick.associatedTimer/@numberOfGrid
        @score+= (@game.time*@scoreMultiplier)/@numberOfGrid
    when :quickplay
				@finishedGrid+=1
				@maxScore += @gridPick.associatedTimer/@numberOfGrid
        @score += ([@gridPick.associatedTimer-@game.time,0].max * @scoreMultiplier)/@numberOfGrid
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
		if @maxStars == 3
			if @score >0.45*@maxScore
				@actualStars = 3
			elsif @score>0.45*@maxScore
				@actualStars=2
			elsif @score>0.25*@maxScore
				@actualStars = 1
			else
				@actualStars=0
			end
		end

		if @maxStars == 4
			if @score >0.47*@maxScore
				@actualStars = 4
			elsif @score>0.4*@maxScore
				@actualStars=3
			elsif @score>0.35*@maxScore
				@actualStars = 2
			elsif @score>0.3*@maxScore
				@actualStars = 1
			else
				@actualStars=0
			end
		end

		if @maxStars == 5
			if @score >0.5*@maxScore
				@actualStars = 5
			elsif @score>0.45*@maxScore
				@actualStars=4
			elsif @score>0.4*@maxScore
				@actualStars = 3
			elsif @score>0.37*@maxScore
				@actualStars = 2
			elsif @score>0.33*@maxScore
				@actualStars = 1
			else
				@actualStars=0
			end
		end

		if @overallStars.include?(@levelNumber)
			if @overallStars.fetch(@levelNumber)<@actualStars
				@overallStars[@levelNumber]=@actualStars
			end
		else
			@overallStars[@levelNumber]=@actualStars
		end
		return @actualStarse
  end

	def calculateOverallStars
		res = 0;
		@overallStars.each_value{ |v|
			res+=v
		 }
		 return res
	end

end
