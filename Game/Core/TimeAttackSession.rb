# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Session.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019

require File.dirname(__FILE__) + "/Session"

class TimeAttackSession < Session

	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty
	# attr_writer :score

	def initialize(gameMode, difficulty)
		super(gameMode, difficulty)
	end

	def continuable?
		true
	end

	def calculateScore
		if @game
			@score+=100
		end
	end

	def setTime
		@time=@gridPick.associatedTimer
	end

end
