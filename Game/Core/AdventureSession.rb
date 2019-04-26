# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   01-Mar-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: AdventureLevel.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 25-Apr-2019

require File.dirname(__FILE__) + "/Session"

##
# ===== Presentation
# This class is inherited from Session.
# The AdventureSession is the session that will be saved to register all the informations
# needed for a player to move forward in his adventure.
#
# ===== Methods
# This class' methods are all described below.
class AdventureSession < Session

	# :nodoc:
	attr_reader :game, :gridPick, :time, :score, :difficulty, :levelInfo, :overAllStarsHash, :overAllStars, :levelInfo, :adventureInfo
	# :startdoc:

	##
	# ===== Presentation
	# This class' constructor calls the inherited constructor from Session and defines the game mode
	# as adventure with no difficulty. It initializes all the variables needed to run a new adventure.
	#
	# ===== Variables
	# The variables in this constructor are the overall number of stars and a hash table that
	# will contain the information about all the number of stars that the user has per level.
	# The adventureInfo variable is initialized as a Levels.
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
	# * +levelNumber+ - The level's number.
	#
	# ===== Returns
	# This method returns the level's Session.
	#
	# ===== Examples
	# This method creates a finishedGrid variable and calls the method getLevelInformation
	# for the class to know all the information about the level :
	#     self.getLevelInformation(lvlNumber)
	# Then it returns the session of the level get from the adventureInfo :
	# 		adventureInfo.getLevel(lvlNumber)
	# ----------
	def getLevel(lvlNumber)
		@finishedGrid = 0
		self.getLevelInformation(lvlNumber)
		@adventureInfo.getLevel(lvlNumber)
	end

	##
	# ===== Presentation
	# This class has no reason to have a replay. Overwriting this method with nothing allows
	# less code duplication than redifining it in all other sessions
	#
	# ===== Attributes
	# * +none+ - none
	#
	# ===== Returns
	# This method returns nothing.
	#
	# ===== Examples
	# Here is the complete replay class :
	#      def replay(none)
	#      end
	# ----------
	def replay(none)
	end

	##
	# ===== Presentation
	# This method is used when the player wants to play a level in the adventure.
	# This is here to access the information about the current level that is being played.
	#
	# ===== Attributes
	# * +levelNumber+ - The number of the level.
	#
	# ===== Returns
	# This method returns the information about the level.
	#
	# ===== Examples
	# This method creates a levelInfo variable which is an array of all the informations
	# about the level being played :
	#     levelInfo = @adventureInfo.levels.fetch(lvlNumber)
	# ----------
	def getLevelInformation(lvlNumber)
			@levelInfo = @adventureInfo.levels.fetch(lvlNumber)
	end

	##
	# ===== Presentation
	# This method is used when the player ends a game.
	# This is used to calculate the score with the level condition.
	#
	# ===== Attributes
	# * +score+ - The score of the session.
	#
	# ===== Returns
	# This method returns the score of the session.
	#
	# ===== Examples
	# This method calculates the score using the method of the class Levels :
	#     @score = @adventureInfo.calculateScore(@levelInfo[2],@levelInfo[4],score)
	# ----------
	def calculateScore(score)
			@score = @adventureInfo.calculateScore(@levelInfo[2],@levelInfo[4],score)
	end

	##
	# ===== Presentation
	# This method is used when the player ends a game.
	# This is used to calculate the number of stars depending on the score.
	#
	# ===== Returns
	# This method returns the number of stars for a level.
	#
	# ===== Examples
	# This method calculates the stars using the method of the class Levels :
	#     @stars = @adventureInfo.calculateStars(@score,@levelInfo[3],@overAllStarsHash,@levelInfo[5])
	# Update the hash table overAllStarsHash with the method updateOverallStarsHash :
	# 		self.updateOverallStarsHash
	# Calculate the new overall star :
	# 		self.calculateOverallStars
	# ----------
	def calculateStars
		@stars = @adventureInfo.calculateStars(@score,@levelInfo[3],@overAllStarsHash,@levelInfo[5])
		self.updateOverallStarsHash
		self.calculateOverallStars
		return @stars
	end

	##
	# ===== Presentation
	# This method is used when the player ends a game.
	# This is used to calculate the overallstars of an adventure session.
	#
	# ===== Returns
	# This method returns the overall stars.
	#
	# ===== Examples
	# This method calculates the stars using the method of the class Levels :
	#     @overAllStars= @adventureInfo.calculateOverallStars(@overAllStarsHash)
	# ----------
	def calculateOverallStars
		@overAllStars= @adventureInfo.calculateOverallStars(@overAllStarsHash)
	end

	##
	# ===== Presentation
	# This method is used when the player ends a game.
	# This is used to update the overAllStarsHash variable.
	#
	# ===== Returns
	# This method returns the hash table that contains all the stars earned per level.
	#
	# ===== Examples
	# This method returns the overAllStarsHash of the class Level (adventureInfo) :
	#     @overAllStarsHash = @adventureInfo.overallStarsHash
	def updateOverallStarsHash
		@overAllStarsHash = @adventureInfo.overallStarsHash
	end

	##
	# ===== Presentation
	# This method is used to know if a player can access a level.
	#
	# ===== Returns
	# This method returns a boolean, true if the player can access the level, else
	# it returns false.
	#
	# ===== Examples
	# This method tells if a level is avaible or not using the method of the class Levels :
	#     @adventureInfo.lvlAvailable?(lvl, @overAllStars)
	# ----------
	def lvlAvailable?(lvl)
		@adventureInfo.lvlAvailable?(lvl, @overAllStars)
	end

	##
	# ===== Presentation
	# This method is used to know if a level can be continued.
	#
	# ===== Returns
	# This method returns true or false.
	#
	# ===== Examples
	# This method tells if a level can be continued or not using the method of the class Levels :
	#     @adventureInfo.continuable?(@levelInfo[4])
	# ----------
	def continuable?
		@adventureInfo.continuable?(@levelInfo[4])
	end

end
