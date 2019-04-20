# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: TimeAttackSession.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 19-Mar-2019

require File.dirname(__FILE__) + "/Session"

class TimeAttackSession < Session

	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty
	# attr_writer :score

	def initialize(difficulty, partOfAdventure=false)
		super(:timeAttack, difficulty, partOfAdventure)
	end

	def continuable?
		true
	end

	def calculateScore
		if @game
			@score+=game.time
		end
	end

	def isTutorial?
		return false
	end

	def setTime
		@time=@gridPick.associatedTimer
	end

end
