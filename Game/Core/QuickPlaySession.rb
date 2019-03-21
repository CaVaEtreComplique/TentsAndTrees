# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: QuickPlaySession.rb
# @Last modified by:   zeigon
# @Last modified time: 18-Mar-2019

require File.dirname(__FILE__) + "/Session"

class QuickPlaySession < Session

	attr_reader :game, :gridPick, :time, :score, :difficulty
	# attr_writer :score

	def initialize(gameMode,difficulty, partOfAdventure=false)
		super(gameMode,difficulty, partOfAdventure)
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
