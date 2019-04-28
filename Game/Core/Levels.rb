# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   18-Mar-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: Levels.rb
# @Last modified by:   quentinGoncalves
# @Last modified time: 25-Apr-2019

require File.dirname(__FILE__) + "/AdventureSession"
require File.dirname(__FILE__) + "/TimeAttackSession"
require File.dirname(__FILE__) + "/QuickPlaySession"
require File.dirname(__FILE__) + "/Session"

##
# ===== Presentation
# The Levels class is used to know all levels particularity. It is also used to
# do all of the operations in relation with the levels.
#
# ===== Methods
# This class knows its initialization method and the methods described below.
class Levels

	# :nodoc:
	attr_reader :levels, :maxScore, :overallStarsHash
	attr_writer :maxScore
	# :startdoc:

 	## @levels is all the information about a level
	# A level is defined by : GameMode, Difficulty, score Multiplier, MaxStars, Number of grid to finish, LevelNumber

	##
	# ===== Presentation
	# This class' constructor initializes the variables, 4 hash tables described below.
	#
	# ===== Variables
	# * +levels+ - A hash table which contains all of the information about every level.
	# A level is defined by its game mode, its difficulty, its score multiplier,
	# the number of stars that we can have, the number of grids to complete the level and its number.
	# * +neededStars+ - A hash table which contains the number of stars needed to unlock each level.
	# * +overallStarsHash+ - A hash table that will contain the number of stars that the user has per level.
	# * +levelsSession+ - A hash table that will contain all session in connection with the levels hash table.
	def initialize()
    @levels = {
			1 => [:quickplay, :easy, 1, 3, 1,1],
			2 => [:timeAttack, :easy, 1, 3, 1,2],
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
		@overallStarsHash={}
		@levelsSession={}
	end

	##
	# ===== Presentation
	# This method is used when the player wants to play a level in the adventure.
	#
	# ===== Attributes
	# * +level+ : The level's number.
	#
	# ===== Returns
	# This method returns the session of the level.
	#
	# ===== Examples
	# This method creates a finishedGrid variable and calls the method initLevel
	# if the levelsSession hash table has the level's number as a key and the session
	# of the level is nil :
	# 		if @levelsSession.has_key?(level)
	# 			if @levelsSession[level] == nil
	# 				self.initLevel(level)
	# 			end
	# Else calls the method initLevel :
	# 				else
	#		 		self.initLevel(level)
	#		 	end
	# -----
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

	##
	# ===== Presentation
	# This method is used when the player wants to play a level in the adventure.
	#
	# ===== Attributes
	# * +level+ : The level's number.
	#
	# ===== Returns
	# This method returns a new session of the level.
	#
	# ===== Examples
	# Initializes an array that contains all the information about a level.
	# According to the game mode and its difficulty for this level we will create
	# a new session :
	# 			case v[0]
	#				when :quickplay
	#					@levelsSession[v[5]] = QuickPlaySession.new(v[1],true)
	#				when :timeAttack
	#					@levelsSession[v[5]] = TimeAttackSession.new(v[1],true)
	#				end
	# -----
	def initLevel(level)
			v = @levels.fetch(level)
			case v[0]
			when :quickplay
				@levelsSession[v[5]] = QuickPlaySession.new(v[1],true)
			when :timeAttack
				@levelsSession[v[5]] = TimeAttackSession.new(v[1],true)
			end
	end

	##
	# ===== Presentation
	# This method is used to know the maximal number of stars for a level.
	#
	# ===== Attributes
	# * +lvl+ : The level's number.
	#
	# ===== Returns
	# This method returns the maximal number of stars for a level.
	#
	# ===== Examples
	# Initializes an array that contains all the information about a level and returns
	# the information about the maximal number of stars :
	# 		evelInfo= @levels.fetch(lvl)
	# 	 	return levelInfo[3]
	# -----
	def getLevelMaxStars(lvl)
		levelInfo= @levels.fetch(lvl)
		return levelInfo[3]
	end

	##
	# ===== Presentation
	# This method is used to know if a level can be continued.
	#
	# ===== Returns
	# This method returns a boolean.
	#
	# ===== Examples
	# This method tells if a level can be continued or not by verifying if the
	# number of grids in the level is equal to the number of grids finished :
	#     if numberOfGrid == 1
	#				false
	#			else
	#				if numberOfGrid != @finishedGrid
	#					true
	#				else
	#					false
	#				end
	#			end
	# -----
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

	##
	# ===== Presentation
	# This method is used when the player ends a game.
	# This is used to calculate the score with the level condition.
	#
	# ===== Attributes
	# * +score+ : The session's score.
	# * +scoreMultiplier+ : The score multiplier of the level.
	# * +numberOfGrid+ : The number of grids needed to end the level.
	#
	# ===== Returns
	# This method returns the score of the session.
	#
	# ===== Examples
	# This method implements the number of grids that are done and calculates the score :
	#     	@score = (score * scoreMultiplier)/numberOfGrid
	# -----
	def calculateScore(scoreMultiplier, numberOfGrid,score)
			@finishedGrid+=1
			@score = (score * scoreMultiplier)/numberOfGrid
	end

	##
	# ===== Presentation
	# This method is used when the player ends a game.
	# This is used to calculate the number of stars depending on the score.
	#
	# ===== Attributes
	# * +score+ : The score of the session.
	# * +maxStars+ : The maximum stars for the level.
	# * +levelNumber+ : The number of the level.
	# * +overAllStars+ : The hash table that contains all the stars owned per level.
	#
	# ===== Returns
	# This method returns the number of stars for a level.
	#
	# ===== Examples
	# This method calculates the stars according to the maximum stars for a level :
	# 		if maxStars == 3
	#				if score >0.45*@maxScore
	#					@actualStars = 3
	#				elsif score>0.45*@maxScore
	#					@actualStars=2
	#				elsif score>0.25*@maxScore
	#					@actualStars = 1
	#				else
	#					@actualStars=0
	#				end
	#			end
	# 		...
	# Then it updates the hash table if the number of stars from this session is better
	# than the previous one or creates a new key, value instance :
	# 		@overallStarsHash = overAllStarsHash
	#			if @overallStarsHash.has_key?(levelNumber)
	#				if @overallStarsHash.fetch(levelNumber)<@actualStars
	#					@overallStarsHash[levelNumber]=@actualStars
	#				end
	#			else
	#				@overallStarsHash[levelNumber] = @actualStars
	#			end
	# Finaly it sets the finished grid and the score variable to 0 and sets the session
	# to nil.
	# -----
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
		@score =0
		@levelsSession[levelNumber] = nil
		return @actualStars
	end

	##
	# ===== Presentation
	# This method is used when the player ends a game.
	# This is used to calculate the overall stars of an adventure session.
	#
	# ===== Attributes
	# * +overAllStarsHash+ : The hash table that contains all the stars owned per level.
	#
	# ===== Returns
	# This method returns the overall stars.
	#
	# ===== Examples
	# This method calculates the overall stars by adding all the values of the
	# hash table :
	#     res = 0;
	#			overAllStarsHash.each_value{ |v|
	#				res +=v
	#			}
	# ------
	def calculateOverallStars(overAllStarsHash)
		res = 0;
		overAllStarsHash.each_value{ |v|
			res +=v
		}
		return res
	end

	##
	# ===== Presentation
	# This method is used to know if a player can access a level.
	#
	# ===== Attributes
	# * +lvl+ : The level's number.
	# * +overAllStars+ : The overall number of stars for an adventure.
	#
	# ===== Returns
	# This method returns true or false.
	#
	# ===== Examples
	# This method tells if a level is available by fetching with the level number the
	# stars needed to unlock this level and comparing it to the overall stars :
	#     if @neededStars.fetch(lvl) > overAllStars
	#				false
	#			else
	#				true
	#			end
	def lvlAvailable?(lvl, overAllStars)
		if @neededStars.fetch(lvl) > overAllStars
			false
		else
			true
		end
	end

end
