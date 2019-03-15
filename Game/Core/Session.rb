# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Session.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019

class Session

	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty
	# attr_writer :score


	def initialize(gameMode, difficulty)
		@gameMode=gameMode
		@difficulty=difficulty
		@score=0
    replay(false)
	end

	def continuable?
		[:timeAttack,:adventure].include?(@gameMode)
	end

	def calculateScore
    case @gameMode
    when :timeAttack
		    @score+=@game.time
    when :quickplay
        @score = [@gridPick.associatedTimer-@game.time,0].max
    end
	end

	def setTime
		case @gameMode
		when :timeAttack
				@time=@gridPick.associatedTimer
		when :quickplay
				@time=0
		end
	end

	def replay(continue)
    # Generation de la grille
    @gridPick = GridGenerator.new(@difficulty)
		setTime
		# Generation de la partie
		if continue
			@time+=@game.time
		else
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
