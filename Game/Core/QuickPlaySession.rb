# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Session.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019

require File.dirname(__FILE__) + "/Session"

class QuickPlaySession < Session

	attr_reader :game, :gridPick, :time, :score, :difficulty
	# attr_writer :score

	def initialize(gameMode,difficulty)
		super(gameMode,difficulty)
	end

	def calculateScore
		if @game
      @score = [@gridPick.associatedTimer-@game.time,0].max
		else
			@score = 0
		end
	end

	def setTime
			@time=0
	end


end
