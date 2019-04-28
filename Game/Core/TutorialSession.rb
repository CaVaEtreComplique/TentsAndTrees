# @Author: Maxime Touze <maxime>
# @Date:   05-Apr-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: TutorialSession.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019
require File.dirname(__FILE__) + "/Session"

##
# ===== Presentation
# The TutorialSession class is inherited from the Session class.
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
class TutorialSession < Session

	# :nodoc:
	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty
	# attr_writer :score
	# :startdoc:

	##
	# ===== Presentation
	# This class' constructor initializes the variables using the parental
	# constructor of Session and so creates a TutorialSession.
	#
	# ===== How to Use
	#    session = TutorialSession.new()
	def initialize
		super(:tutorial, :tutorial, false)
	end

	##
	# ===== Presentation
	# This method redefines the continuable? method from Session in order to make
	# the game continuable.
	# -----
	def continuable?
		true
	end

	##
	# ===== Presentation
	# This method redefines the method calculateScore from Session .
	# -----
	def calculateScore
		return 42
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
		return true
	end

	##
	# ===== Presentation
	# This method redefines the method setTime from Session in order to set the
	# timer at a random value in order to not make the tutorial bug.
	def setTime
		@time=42
	end

end
