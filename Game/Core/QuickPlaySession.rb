# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: QuickPlaySession.rb
# @Last modified by:   zeigon
# @Last modified time: 18-Mar-2019

require File.dirname(__FILE__) + "/Session"

#
# ==== Presentation
# The QuickPlaySession class is inherited from the class Session and represent
# a quick game.
#
# ==== Variables
# * +game+ - This variables represent a Game class
#
# * +gridPick+ - This variable represente the GridGenerator class.
#
# * +time+ - A Timer Class from Gtk3.
#
# * +score+ - An integer that represent the score.
#
# * +gameMode+ - The gameMode of Session.
#
# * +difficulty+ - The difficulty involve.
#
# * +session+ - The type of session
#
# * +save+ - The Save link to the session
#
# ==== Methods
# This class knows an initialization method described below.
class QuickPlaySession < Session

	attr_reader :game, :gridPick, :time, :score, :difficulty, :maxScore
	# attr_writer :score

	##
	# ===== Presentation
	# This class' constructor initializes the variable using the parental
	# constructor of Session and so create a QuickPlaySession.
	#
	# ===== Attributes
	# * +difficulty+ : the difficulty of the game .
	# * +partOfAdventure+ : Boolean representing of this session is part of the
	# adventure.
	#
	# ===== Exemple
	#    session = QuickPlaySession.new(:hard, false)
	def initialize(difficulty, partOfAdventure=false)
		super(:quickplay,difficulty, partOfAdventure)
	end

	##
	# ===== Presentation
	# This methode redefine the calculateScore method from Session in order to
	# calculate the score of session by using @game.
	#
	def calculateScore
		if @game
      @score += [@gridPick.associatedTimer-@game.time,0].max
		else
			@score = 0
		end
	end

	##
	# ===== Presentation
	# This methode redefine the isTutorial? method of Session class in order to
	# define this session as a tutorial
	#
	# ===== Exemple
	#    session.isTutorial?()  #return true
	def isTutorial?
		return false
	end

	##
	# ===== Presentation
	# This methode redefine the method setTime from Session in order to set the
	# timer at 0.
	#
	def setTime
			@time=0
	end


end
