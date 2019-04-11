# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   18-Mar-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: Levels.rb
# @Last modified by:   zeigon
# @Last modified time: 08-Apr-2019

require File.dirname(__FILE__) + "/AdventureSession"
require File.dirname(__FILE__) + "/TimeAttackSession"
require File.dirname(__FILE__) + "/QuickPlaySession"
require File.dirname(__FILE__) + "/Session"

class Levels

	attr_reader :levels, :maxScore, :overallStarsHash

 	## @levels is all the information about a levels
	# A level is define by : GameMode, Difficulty, score Multiplier, MaxStars, Number of grid to finish, LevelNumber
	def initialize()
    @levels = {
			1 => [:quickplay, :easy, 1, 3, 1,1],
			2 => [:timeAttack, :easy, 1, 3, 2,2],
			3 => [:quickplay, :easy, 0.95, 3, 1,3],
			4 => [:timeAttack, :easy, 1, 3, 2,4],
			5 => [:quickplay, :easy, 0.9, 5, 1,5]
		}
		@neededStars = {
			1 => 0,
			2 => 1,
			3 => 3,
			4 => 5,
			5 => 8
		}
		@finishedGrid = 0
		@maxScore =0
		@score =0
		@actualStars=0
		@overallStarsHash={}
		@levelsSession={}
	end


  def getLevel(level)
		@finishedGrid = 0
		if @levelsSession.has_key?(level)
			if @levelsSession[level] == nil
    		self.initLevel(level)
			end
		else
			self.initLevel(level)
		end
			return @levelsSession.fetch(level)
  end

	def initLevel(level)
			v = @levels.fetch(level)
			case v[0]
			when :quickplay
				@levelsSession[v[5]] = QuickPlaySession.new(v[1],true)
			when :timeAttack
				@levelsSession[v[5]] = TimeAttackSession.new(v[1],true)
			end
	end

	def getLevelMaxStars(lvl)
		levelInfo= @levels.fetch(lvl)
		return levelInfo[3]
	end

	def continuable?(numberOfGrid)
		if numberOfGrid == 1
			false
		else
			if numberOfGrid != @finishedGrid
				true
			else
				false
			end
		end
	end

	def calculateScore(scoreMultiplier, numberOfGrid,game)
		case game.session.gameMode
		when :timeAttack
				@finishedGrid+=1
				@maxScore += game.session.gridPick.associatedTimer/numberOfGrid
				@score+= (game.time*scoreMultiplier)/numberOfGrid
		when :quickplay
				@finishedGrid+=1
				@maxScore += game.session.gridPick.associatedTimer/numberOfGrid
				@score += ([game.session.gridPick.associatedTimer-game.time,0].max * scoreMultiplier)/numberOfGrid
		end
	end


	def calculateStars(score, maxStars,overAllStarsHash,levelNumber)
		if maxStars == 3
			if score >0.45*@maxScore
				@actualStars = 3
			elsif score>0.45*@maxScore
				@actualStars=2
			elsif score>0.25*@maxScore
				@actualStars = 1
			else
				@actualStars=0
			end
		end

		if maxStars == 4
			if score >0.47*@maxScore
				@actualStars = 4
			elsif score>0.4*@maxScore
				@actualStars=3
			elsif score>0.35*@maxScore
				@actualStars = 2
			elsif score>0.3*@maxScore
				@actualStars = 1
			else
				@actualStars=0
			end
		end

		if maxStars == 5
			if score >0.5*@maxScore
				@actualStars = 5
			elsif score>0.45*@maxScore
				@actualStars=4
			elsif score>0.4*@maxScore
				@actualStars = 3
			elsif score>0.37*@maxScore
				@actualStars = 2
			elsif score>0.33*@maxScore
				@actualStars = 1
			else
				@actualStars=0
			end
		end
		@overallStarsHash = overAllStarsHash
		if @overallStarsHash.has_key?(levelNumber)
			if @overallStarsHash.fetch(levelNumber)<@actualStars
				@overallStarsHash[levelNumber]=@actualStars
			end
		else
			@overallStarsHash[levelNumber] = @actualStars
		end
		@finishedGrid = 0
		@maxScore = 0
		@score =0
		@levelsSession[levelNumber] = nil
		return @actualStars
	end

	def calculateOverallStars(overAllStarsHash)
		res = 0;
		overAllStarsHash.each_value{ |v|
			res +=v
		}
		return res
	end

	def lvlAvailable?(lvl, overAllStars)
		if @neededStars.fetch(lvl) > overAllStars
			false
		else
			true
		end
	end

end
