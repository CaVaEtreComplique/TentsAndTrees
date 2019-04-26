# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   01-Mar-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: AdventureLevel.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 25-Apr-2019

require File.dirname(__FILE__) + "/Session"

##
# ===== Presentation
# This class inherited from Session.
# The AdventureSession is the session that will be save to register all the informations
# needed for a player to move forward in his adventure.
#
# ===== Methods
# This class' methods are all described below.
#
##
class AdventureSession < Session

	attr_reader :game, :gridPick, :time, :score, :difficulty, :levelInfo, :overAllStarsHash, :overAllStars, :levelInfo, :adventureInfo

	##
	# ===== Presentation
	# This class' constructor call the inherited constructor from Session and defined the Game mode
	# as adventure with no difficulty. It initialize all the variables needed to run a new adventure.
	# Those variables are the overall number of stars and a hash table that
	# will contain the information about all the number of stars that the user has per level.
	# AdventurInfo  a variable wich initialize as a Levels. Levels is a class that contain all
	# the informations about all level and all the operation.
	##
	def initialize()
		super(:adventure, :none)
		@adventureInfo= Levels.new
		@overAllStarsHash={}
		@overAllStars = 0
	end

	##
	# ===== Presentation
	# This method is used when the player wants to play a level in the adventure.
	#
	# ===== Attributes
	# * +levelNumber+ : The Number of the level.
	#
	# ===== Returns
	# This method returns the session of the level.
	#
	# ===== Examples
	# This method creates a finishedGrid variable and calls the method getLevelInformation
	# for the class to know all the information about the level :
	#     self.getLevelInformation(lvlNumber)
	# Then it return the session of the level get from the adventureInfo :
	# 		adventureInfo.getLevel(lvlNumber)
	##
	def getLevel(lvlNumber)
		@finishedGrid = 0
		self.getLevelInformation(lvlNumber)
		@adventureInfo.getLevel(lvlNumber)
	end

	##
	# ===== Presentation
	# This class has no reaason to have a replay. Overwriting this method with nothing allows
	# less code dup than redifining it in all other sessions
	#
	# ===== Attributes
	# * +none+ : none
	#
	# ===== Returns
	# This method returns nothing.
	#
	##
	def replay(none)
	end

	##
	# ===== Presentation
	# This method is used when the player wants to play a level in the adventure.
	# This is use to access the information about the current level thtat is beeing played.
	#
	# ===== Attributes
	# * +levelNumber+ : The Number of the level.
	#
	# ===== Returns
	# This method returns the information about the level.
	#
	# ===== Examples
	# This method creates a levelInfo variable wich is an array of all the informations
	# about the level beeing played :
	#     levelInfo = @adventureInfo.levels.fetch(lvlNumber)
	##
	def getLevelInformation(lvlNumber)
			@levelInfo = @adventureInfo.levels.fetch(lvlNumber)
	end

	##
	# ===== Presentation
	# This method is used when the player end a game.
	# This is use to calculate the score with the level condition.
	#
	# ===== Attributes
	# * +score+ : The score of the session .
	#
	# ===== Returns
	# This method returns the score of the session.
	#
	# ===== Examples
	# This method calculate the score using the method of the class Levels :
	#     @score = @adventureInfo.calculateScore(@levelInfo[0],@levelInfo[2],@levelInfo[4],score)
	##
	def calculateScore(score)
			@score = @adventureInfo.calculateScore(@levelInfo[2],@levelInfo[4],score)
	end

	##
	# ===== Presentation
	# This method is used when the player end a game.
	# This is use to calculate the number of stars depending on the score.
	#
	# ===== Returns
	# This method returns the number of stars for a level.
	#
	# ===== Examples
	# This method calculate the stars using the method of the class Levels :
	#     @overAllStars= @adventureInfo.calculateOverallStars(@overAllStarsHash)
	# Update the hash table overAllStarsHash with the method updateOverallStarsHash :
	# 		self.updateOverallStarsHash
	# Calculate the new overall star :
	# 		self.calculateOverallStars
	##
	def calculateStars
		@stars = @adventureInfo.calculateStars(@score,@levelInfo[3],@overAllStarsHash,@levelInfo[5])
		self.updateOverallStarsHash
		self.calculateOverallStars
		return @stars
	end

	##
	# ===== Presentation
	# This method is used when the player end a game.
	# This is use to calculate the overallstars of an adventure session.
	#
	# ===== Returns
	# This method returns the overall stars.
	#
	# ===== Examples
	# This method calculate the stars using the method of the class Levels :
	#     @overAllStars= @adventureInfo.calculateOverallStars(@overAllStarsHash)
	##
	def calculateOverallStars
		@overAllStars= @adventureInfo.calculateOverallStars(@overAllStarsHash)
	end

	##
	# ===== Presentation
	# This method is used when the player end a game.
	# This is use to update the overAllStarsHash variable.
	#
	# ===== Returns
	# This method returns the hash table that contain all the stars get per level.
	#
	# ===== Examples
	# This method return the overAllStarsHash of the class Level (adventureInfo) :
	#     @overAllStarsHash = @adventureInfo.overallStarsHash
	##
	def updateOverallStarsHash
		@overAllStarsHash = @adventureInfo.overallStarsHash
	end

	##
	# ===== Presentation
	# This method is used to know if a player can access a level.
	#
	# ===== Returns
	# This method return true or false.
	#
	# ===== Examples
	# This method tell if a level is avaible or not using the method of the class Levels:
	#     @adventureInfo.lvlAvailable?(lvl, @overAllStars)
	##
	def lvlAvailable?(lvl)
		@adventureInfo.lvlAvailable?(lvl, @overAllStars)
	end

	##
	# ===== Presentation
	# This method is used to know if a level is continuable.
	#
	# ===== Returns
	# This method return true or false.
	#
	# ===== Examples
	# This method tell if a level is continuable or not using the method of the class Levels:
	#     @adventureInfo.continuable?(@levelInfo[4])
	##
	def continuable?
		@adventureInfo.continuable?(@levelInfo[4])
	end

end
