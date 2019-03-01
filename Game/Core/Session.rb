# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Session.rb
# @Last modified by:   zeigon
# @Last modified time: 01-Mar-2019

class Session

	attr_reader :game, :gridPick, :time, :score, :win, :gameMode, :difficulty
	# attr_writer :score

	def initialize(win, gameMode, difficulty)
			@win=win
			@gameMode=gameMode
			@difficulty=difficulty
			@score=0
			replay(false)
	end

	def continuable?
		[:timeAttack,:adventure].include?(@gameMode)
	end

	def calculateScore
		@score+=@game.time
	end

	def replay(continue)
		# Generation de la grille
		@gridPick = GridGenerator.new(@gameMode,@difficulty)
		@time=@gridPick.associatedTimer
		# Save loading here ?
		# Generation de la partie
		if continue
			@time+=@game.time
		else
			@score=0
		end
		@game=Game.new(self)
		self
	end

end
