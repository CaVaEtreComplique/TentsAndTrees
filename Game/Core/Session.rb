# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Session.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 19-Mar-2019

class Session

	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty
	# attr_writer :score


	def initialize(gameMode, difficulty, partOfAdventure=false)
		@gameMode=gameMode
		@difficulty=difficulty
		@partOfAdventure=partOfAdventure
		@score=0
	end

	def partOfAdventure?
		@partOfAdventure
	end

	def continuable?
		false
	end

	def calculateScore

	end

	def setTime
	end

	def replay(continue)
		# Generation de la grille
		@gridPick = GridGenerator.new(@difficulty)
		# Generation de la partie
		if continue
			@time=@game.time+30
		else
			setTime
			@score=0
		end
		@game=Game.new(self)

		self
	end

	def save
		@game.delete_observers
		Save.update(self)
	end

end
