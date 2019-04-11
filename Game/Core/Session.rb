# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Session.rb
# @Last modified by:   zeigon
# @Last modified time: 08-Apr-2019

class Session

	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty, :session, :save
	# attr_writer :score


	def initialize(gameMode, difficulty, partOfAdventure=false)
		@gameMode=gameMode
		@difficulty=difficulty
		@partOfAdventure=partOfAdventure
		@score=0
		replay(false)
	end

	def createSave
		@save = ConnectDB.new.save(Connexion.getJoueur,self.to_yaml()).id_save
	end

	def partOfAdventure?
		@partOfAdventure
	end

	def isTutorial?
		return false
	end

	def setSave(save)
			@save = save
	end

	def deleteSave
			ConnectDB.new.deleteSave(self.save)
	end

	def updateSave
		if @gameMode != :adventure
			self.game.delete_observers
			self.game.clearHelper
		end
		ConnectDB.new.updateSave(self.to_yaml(), self.save)
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
			@time=@game.time+@gridPick.associatedTimer
		else
			setTime
			@score=0
		end
		@game=Game.new(self)

		self
	end
end
