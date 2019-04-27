# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Session.rb
# @Last modified by:   zeigon
# @Last modified time: 08-Apr-2019


#
# ==== Presentation
# The TimeAttackSession class is inherited from the class Session.
#
# ==== Variables
# * +game+ - This variables represent a Game class
#
# * +gridPick+ - This variable represente the GridGenerator class.
#
# * +time+ - A Timer Class from Gtk3.
#
# * +score+ - An integer that represent the score.
#
# * +gameMode+ - The gameMode of Session.
#
# * +difficulty+ - The difficulty involve.
#
# * +session+ - The type of session
#
# * +save+ - The Save link to the session
#
# ==== Methods
# This class knows an initialization method described below.
class Session

	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty, :session, :save
	# attr_writer :score

	##
	# ===== Presentation
	# This class' constructor initializes the variable @gameMode, @difficulty and
	# score.
	#
	# ===== Attributes
	# +gameMode+ : The gamemode of the session (:tutorial, :quickplay or
	# :timeAttack ).
	# +difficulty+ : the difficulty of the game.
	# +partOfAdventure+ : Boolean representing if this session is part of the
	# adventure, if not give partOfAdventure is set to false.
	#
	# ===== Exemple
	#    session = Session.new(:tutorial, :hard, false)
	#    session = Session.new(:timeAttack, :hard)
	def initialize(gameMode, difficulty, partOfAdventure=false)
		@gameMode=gameMode
		@difficulty=difficulty
		@partOfAdventure=partOfAdventure
		@score=0
		replay(false)
	end

	##
	# ===== Presentation
	# This methode create a Save linked to the Session and add it to the
	# database.
	def createSave
		@save = ConnectDB.new.save(Connexion.getJoueur,self.to_yaml()).id_save
	end

	##
	# ===== Presentation
	# This methode return the variable @partOfAdventure, in order to know if the
	# session is an adventure.
	def partOfAdventure?
		@partOfAdventure
	end

	##
	# ===== Presentation
	# This methode return true if the session is a tutorial, false otherwise
	def isTutorial?
		return false
	end

	##
	# ===== Presentation
	# This methode link a Save to the Session.
	#
	# ===== Attributes
	# * +save+ : The Save that going to be linked.
	def setSave(save)
			@save = save
	end

	##
	# ===== Presentation
	# This methode delete the linked save from the database.
	def deleteSave
			ConnectDB.new.deleteSave(self.save)
	end

	##
	# ===== Presentation
	# This methode update the linked save from the database.
	def updateSave
		if @gameMode != :adventure
			self.game.delete_observers
			self.game.clearHelper
		end
		ConnectDB.new.updateSave(self.to_yaml(), self.save)
	end

	##
	# ===== Presentation
	# This methode say if a session can be continued, a Session can be continued.
	def continuable?
		false
	end

	##
	# ===== Presentation
	# This methode calculate the scor.
	def calculateScore

	end

	##
	# ===== Presentation
	# This methode set base time for the timer.
	def setTime

	end

	##
	# ===== Presentation
	# This methode replay a game with the same parameter.
	#
	# ===== Attributes
	# * +continue+ : Allow to continue an allready lanched game.
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
