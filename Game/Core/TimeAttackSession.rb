# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: TimeAttackSession.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 19-Mar-2019

require File.dirname(__FILE__) + "/Session"


##
# ===== Presentation
# The TimeAttackSession class is inherited from the class Session and represents
# a time attack game.
#
# ===== Variables
# * +game+ - This variable represents a Game class.
#
# * +gridPick+ - This variable represents the GridGenerator class.
#
# * +time+ - A Timer Class from Gtk3.
#
# * +score+ - An integer that represents the score.
#
# * +gameMode+ - The Session's game mode.
#
# * +difficulty+ - The difficulty involved.
#
# ==== Methods
# This class knows an initialization method and the methods described below.
class TimeAttackSession < Session

	# :nodoc:
	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty
	# attr_writer :score
	# :startdoc:

	##
	# ===== Presentation
	# This class' constructor initializes the variable using the parental
	# constructor of Session and so creates a TimeAttackSession.
	#
	# ===== Attributes
  # * +difficulty+ : The difficulty of the game.
  # * +partOfAdventure+ : Boolean representing if this session is part of the adventure.
  #
	# ===== How to Use
	#    session = TimeAttackSession.new(:hard, false)
	def initialize(difficulty, partOfAdventure=false)
		super(:timeAttack, difficulty, partOfAdventure)
	end

	##
	# ===== Presentation
	# This method redefines the continuable? method from the Session class in order to
	# tell if this session can be continued and thus be saved.
	#
	# ===== How to Use
	#    session.continuable?()  #return true
	# -----
	def continuable?
		true
	end

	##
	# ===== Presentation
	# This method calculates the score of the session by using @game.
	# -----
	def calculateScore
		if @game
			@score+=game.time
		end
	end

	##
	# ===== Presentation
	# This method sets the time of the timer by using the time affected to each
	# grid.
	def setTime
		@time=@gridPick.associatedTimer
	end

end
