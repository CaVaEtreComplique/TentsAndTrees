# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: AdventureLevel.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 15-Mar-2019

require File.dirname(__FILE__) + "/Session"

class AdventureSession < Session

	attr_reader :game, :gridPick, :time, :score, :difficulty, :levelInfo, :overAllStarsHash, :overAllStars, :levelInfo, :adventureInfo

	def initialize()
		super(:adventure, :none)
		@adventureInfo= Levels.new
		@overAllStarsHash={}
		@stars= 0
		@overAllStars = 0
		@score =0
	end

	def getLevel(lvlNumber)
		@finishedGrid = 0
		self.getLevelInformation(lvlNumber)
		@adventureInfo.getLevel(lvlNumber)
	end

	def replay(none)
		# This shit has no reaason to have a replay. Overwriting this method w/ nothing allows
		# less code dup than redifining it in all other sessions
	end

	def getLevelInformation(lvlNumber)
			@levelInfo = @adventureInfo.levels.fetch(lvlNumber)
	end

	def calculateScore(game)
			@score += @adventureInfo.calculateScore(@levelInfo[2],@levelInfo[4],game)
	end

	def calculateStars
		@stars = @adventureInfo.calculateStars(@score,@levelInfo[3],@overAllStarsHash,@levelInfo[5])
		@score = 0
		self.updateOverallStarsHash
		self.calculateOverallStars
		return @stars
	end

	def calculateOverallStars
		@overAllStars= @adventureInfo.calculateOverallStars(@overAllStarsHash)
		return @overAllStars
	end

	def updateOverallStarsHash
		@overAllStarsHash = @adventureInfo.overallStarsHash
	end

	def lvlAvailable?(lvl)
		@adventureInfo.lvlAvailable?(lvl, @overAllStars)
	end

	def continuable?
		@adventureInfo.continuable?(@levelInfo[4])
	end

end
