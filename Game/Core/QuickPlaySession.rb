# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: QuickPlaySession.rb
# @Last modified by:   zeigon
# @Last modified time: 18-Mar-2019

require File.dirname(__FILE__) + "/Session"

##
# ===== Presentation
# The QuickPlaySession class is inherited from the class Session and represents
# a game in quick play mode.
#
# ===== Variables
# * +game+ - This variable represents a Game class.
#
# * +gridPick+ - This variable represents the GridGenerator class.
#
# * +time+ - A Timer class from Gtk3.
#
# * +score+ - An integer that represents the score.
#
# * +gameMode+ - The session's game mode.
#
# * +difficulty+ - The difficulty involved.
#
# * +session+ - The type of session.
#
# * +save+ - The Save link to the session.
#
# ==== Methods
# This class knows an initialization method and the methods described below.
class QuickPlaySession < Session

	# :nodoc:
	attr_reader :game, :gridPick, :time, :score, :difficulty, :maxScore
	# attr_writer :score
	# :startdoc:

	##
	# ===== Presentation
	# This class' constructor initializes the variable using the parental
	# constructor of Session and creates a QuickPlaySession.
	#
	# ===== Attributes
	# * +difficulty+ : The game's difficulty.
	# * +partOfAdventure+ : Boolean telling if this session is part of the adventure.
	#
	# ===== How to Use
	#    session = QuickPlaySession.new(:hard, false)
	def initialize(difficulty, partOfAdventure=false)
		super(:quickplay,difficulty, partOfAdventure)
	end

	##
	# ===== Presentation
	# This method redefines the calculateScore method from Session in order to
	# calculate the session's score by using +game+.
	# -----
	def calculateScore
		if @game
      @score += [@gridPick.associatedTimer-@game.time,0].max
		else
			@score = 0
		end
	end

	##
	# ===== Presentation
	# This method redefines the isTutorial? method from the Session class in order to
	# define this session as a tutorial.
	#
	# ===== How to Use
	#    session.isTutorial?()  #return true
	# -----
	def isTutorial?
		return false
	end

	##
	# ===== Presentation
	# This method redefines the setTime method from Session in order to set the
	# timer at 0.
	def setTime
			@time=0
	end


end
