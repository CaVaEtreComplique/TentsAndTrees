
# @Author: Maxime Touze <maxime>
# @Date:   05-Apr-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: TutorialSession.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019
require File.dirname(__FILE__) + "/Session"

#
# ==== Presentation
# The TutorialSession class is inherited from the class Session.
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
class TutorialSession < Session

	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty
	# attr_writer :score

	##
	# ===== Presentation
	# This class' constructor initializes the variable using the parental
	# constructor of Session and so create a TutorialSession.
	#
	# ===== Exemple
	#    session = TutorialSession.new()
	def initialize
		super(:tutorial, :tutorial, false)
	end

	##
	# ===== Presentation
	# This methode redefine the method continuable from Session in order ton make
	# the game continuable.
	#
	def continuable?
		true
	end

	##
	# ===== Presentation
	# This methode redefine the method calculateScore from Session .
	#
	def calculateScore
		return 42
	end

	##
	# ===== Presentation
	# This methode redefine the isTutorial? method of Session class in order to
	# define this session as a tutorial
	#
	# ===== Exemple
	#    session.isTutorial?()  #return true
	def isTutorial?
		return true
	end

	##
	# ===== Presentation
	# This methode redefine the method setTime from Session in order to set the
	# timer at a random value in order to not make the tutorial bug.
	#
	def setTime
		@time=42
	end

end
