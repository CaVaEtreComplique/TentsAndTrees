# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: TimeAttackSession.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 19-Mar-2019

require File.dirname(__FILE__) + "/Session"


#
# ==== Presentation
# The TimeAttackSession class is inherited from the class Session and represente
# a time attack game.
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
# ==== Methods
# This class knows an initialization method described below.
class TimeAttackSession < Session

	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty
	# attr_writer :score

	##
	# ===== Presentation
	# This class' constructor initializes the variable using the parental
	# constructor of Session and so create a TimeAttackSession.
	#
	# ===== Attributes
  # * +difficulty+ : the difficulty of the game .
  # * +partOfAdventure+ : Boolean representing of this session is part of the
	# adventure.
  #
	# ===== Exemple
	#    session = TimeAttackSession.new(:hard, false)
	def initialize(difficulty, partOfAdventure=false)
		super(:timeAttack, difficulty, partOfAdventure)
	end

	##
	# ===== Presentation
	# This methode redefine the continuable? method of Session class in order to
	# say this session can be continued and thus be save.
	#
	# ===== Exemple
	#    session.continuable?()  #return true
	def continuable?
		true
	end

	##
	# ===== Presentation
	# This methode calculate the score of session by using @game.
	#
	def calculateScore
		if @game
			@score+=game.time
		end
	end

	##
	# ===== Presentation
	# This methode set the time of the timer by using the time affected to each
	# grid.
	#
	def setTime
		@time=@gridPick.associatedTimer
	end

end
