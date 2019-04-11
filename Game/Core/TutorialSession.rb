# @Author: Maxime Touze <maxime>
# @Date:   05-Apr-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: TutorialSession.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019
require File.dirname(__FILE__) + "/Session"

class TutorialSession < Session

	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty
	# attr_writer :score

	def initialize
		super(:tutorial, :tutorial, false)
	end

	def continuable?
		true
	end

	def calculateScore
		return 42
	end

	def isTutorial?
		return true
	end

	def setTime
		@time=42
	end

end
