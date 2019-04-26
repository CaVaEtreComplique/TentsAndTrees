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
# The Levels class is use to know all levels particularity. Also to do all the
# operation in relation with the levels.
#
# ===== Methods
# This class' methods are all described below.
#
##
class Levels

	attr_reader :levels, :maxScore, :overallStarsHash
	attr_writer :maxScore

 	## @levels is all the information about a level
	# A level is define by : GameMode, Difficulty, score Multiplier, MaxStars, Number of grid to finish, LevelNumber

	##
	# ===== Presentation
	# This class constructor initialize a hash table levels wich conatain all
	# the information of all level. A level is defined by its game mode, its
	# difficulty, its score multiplier, the number of stars that we can have, the
	# number of grid to complete the level and its number.
	# It also initialize another hash table wich contain the stars needed to unlock
	# each level.
	# A hash table thatwill contain the information about all the number of stars
	# that the user has per level.
	# And a hash table that will contain all session in connection with the levels
	# hash table.
	#
	##
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
	# * +level+ : The Number of the level.
	#
	# ===== Returns
	# This method returns the session of the level.
	#
	# ===== Examples
	# This method creates a finishedGrid variable and calls the method initLevel
	# if the levelsSession hash table has the level number as key  and the session
	# of the level is nil :
	# 		if @levelsSession.has_key?(level)
	# 			if @levelsSession[level] == nil
	# 				self.initLevel(level)
	# 			end
	# Else calls the method initLevel :
	# 				else
	#		 		self.initLevel(level)
	#		 	end
	##
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
	# * +level+ : The Number of the level.
	#
	# ===== Returns
	# This method returns a new session of the level.
	#
	# ===== Examples
	# Initialize an array that contains all the information about a level.
	# According of the gameMode and its difficulty of this level we will create
	# a new session :
	# 			case v[0]
	#				when :quickplay
	#					@levelsSession[v[5]] = QuickPlaySession.new(v[1],true)
	#				when :timeAttack
	#					@levelsSession[v[5]] = TimeAttackSession.new(v[1],true)
	#				end
	##
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
	# * +lvll+ : The Number of the level.
	#
	# ===== Returns
	# This method returns the maximal number of stars for a level.
	#
	# ===== Examples
	# Initialize an array that contains all the information about a level and return
	# the information about the maximal number of star :
	# 		evelInfo= @levels.fetch(lvl)
	# 	 	return levelInfo[3]
	##
	def getLevelMaxStars(lvl)
		levelInfo= @levels.fetch(lvl)
		return levelInfo[3]
	end

	##
	# ===== Presentation
	# This method is used to know if a level is continuable.
	#
	# ===== Returns
	# This method return true or false.
	#
	# ===== Examples
	# This method tell if a level is continuable or not by verifying if the
	# number of grid of the level is equal to the number of grid finished :
	#     if numberOfGrid == 1
	#				false
	#			else
	#				if numberOfGrid != @finishedGrid
	#					true
	#				else
	#					false
	#				end
	#			end
	##
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
	# This method is used when the player end a game.
	# This is use to calculate the score with the level condition.
	#
	# ===== Attributes
	# * +score+ : The score of the session.
	# * +scoreMultiplier+ : The score multiplier of the level.
	# * +numberOfGrid+ : The number of grid needed to end the level.
	#
	# ===== Returns
	# This method returns the score of the session.
	#
	# ===== Examples
	# This method implement the number of grid that are done and calculate the socre :
	#     	@score = (score * scoreMultiplier)/numberOfGrid
	##
	def calculateScore(scoreMultiplier, numberOfGrid,score)
			@finishedGrid+=1
			@score = (score * scoreMultiplier)/numberOfGrid
	end

	##
	# ===== Presentation
	# This method is used when the player end a game.
	# This is use to calculate the number of stars depending on the score.
	#
	# ===== Attributes
	# * +score+ : The score of the session.
	# * +maxStars+ : The maximum stars for the level.
	# * +levelNumber+ : The number of the level.
	# * +overAllStars+ : The hash table that contains all the stars own per level.
	#
	# ===== Returns
	# This method returns the number of stars for a level.
	#
	# ===== Examples
	# This method calculate the stars according to the maximum stars for a level :
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
	# Then it update the hash table if the number of stars from this session is better
	# than the previous one or create a new key, value instance :
	# 		@overallStarsHash = overAllStarsHash
	#			if @overallStarsHash.has_key?(levelNumber)
	#				if @overallStarsHash.fetch(levelNumber)<@actualStars
	#					@overallStarsHash[levelNumber]=@actualStars
	#				end
	#			else
	#				@overallStarsHash[levelNumber] = @actualStars
	#			end
	# Finaly it set the finished grid and the score variable to 0 and set the session
	# to nil.
	##
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
	# This method is used when the player end a game.
	# This is use to calculate the overallstars of an adventure session.
	#
	# ===== Attributes
	# * +overAllStarsHash+ : The hash table that contains all the stars own per level.
	#
	# ===== Returns
	# This method returns the overall stars.
	#
	# ===== Examples
	# This method calculate the overall stars by additioning all the value of the
	# hash table :
	#     res = 0;
	#			overAllStarsHash.each_value{ |v|
	#				res +=v
	#			}
	##
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
	# * +lvl+ : The number of the level.
	# * +overAllStars+ : The overall number of stars for an adventure.
	#
	# ===== Returns
	# This method return true or false.
	#
	# ===== Examples
	# This method tell if a level is avaible by fetching with the level number the
	# stars needed to unlock this level and comparing it to the overall stars :
	#     if @neededStars.fetch(lvl) > overAllStars
	#				false
	#			else
	#				true
	#			end
	##
	def lvlAvailable?(lvl, overAllStars)
		if @neededStars.fetch(lvl) > overAllStars
			false
		else
			true
		end
	end

end
