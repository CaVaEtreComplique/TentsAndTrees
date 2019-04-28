# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Session.rb
# @Last modified by:   zeigon
# @Last modified time: 08-Apr-2019


##
# ===== Presentation
# The Session class implements everything about a game session in the game.
#
# ===== Variables
# * +game+ - This variable represents a Game class.
#
# * +gridPick+ - This variable represents the GridGenerator class.
#
# * +time+ - A Timer Class from Gtk3.
#
# * +score+ - An integer that represents the score.
#
# * +gameMode+ - The game mode of Session.
#
# * +difficulty+ - The difficulty involved.
#
# * +session+ - The type of session.
#
# * +save+ - The Save link to the session.
#
# ===== Methods
# This class knows an initialization method and the methods described below.
class Session

	# :nodoc:
	attr_reader :game, :gridPick, :time, :score, :gameMode, :difficulty, :session, :save
	# attr_writer :score
	# :startdoc:

	##
	# ===== Presentation
	# This class' constructor initializes the variables +gameMode+, +difficulty+ and
	# +score+ .
	#
	# ===== Attributes
	# * +gameMode+ : The session's game mode (:tutorial, :quickplay or :timeAttack).
	# * +difficulty+ : The difficulty of the game.
	# * +partOfAdventure+ : Boolean representing if this session is part of the adventure, if not partOfAdventure is set to false.
	#
	# ===== Examples
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
	# This method creates a Save linked to the Session and adds it to the
	# database.
	#
	# ===== Examples
	# The following request will call the method save from the class ConnectDB
	# to create the save :
	#      ConnectDB.new.save(Connexion.getJoueur,self.to_yaml()).id_save
	# -----
	def createSave
		@save = ConnectDB.new.save(Connexion.getJoueur,self.to_yaml()).id_save
	end

	##
	# ===== Presentation
	# This method returns the variable +partOfAdventure+, in order to know if the
	# session is an adventure.
	# -----
	def partOfAdventure?
		@partOfAdventure
	end

	##
	# ===== Presentation
	# This method returns true if the session is a tutorial level, false otherwise.
	# -----
	def isTutorial?
		return false
	end

	##
	# ===== Presentation
	# This method links a Save to the Session.
	#
	# ===== Attributes
	# * +save+ : The Save that is going to be linked.
	# -----
	def setSave(save)
			@save = save
	end

	##
	# ===== Presentation
	# This method deletes the linked save from the database, calling the method from
	# ConnectDB.
	# -----
	def deleteSave
			ConnectDB.new.deleteSave(self.save)
	end

	##
	# ===== Presentation
	# This method updates the linked save from the database.
	def updateSave
		if @gameMode != :adventure
			self.game.delete_observers
			self.game.clearHelper
		end
		ConnectDB.new.updateSave(self.to_yaml(), self.save)
	end

	##
	# ===== Presentation
	# This method tells if a session can be continued.
	# -----
	def continuable?
		false
	end

	##
	# ===== Presentation
	# This method calculates the score.
	# -----
	def calculateScore

	end

	##
	# ===== Presentation
	# This method sets the base time for the timer.
	# -----
	def setTime

	end

	##
	# ===== Presentation
	# This method replays a game with the same parameters.
	#
	# ===== Attributes
	# * +continue+ : Boolean allowing to continue an already launched game.
	#
	# ===== Examples
	# First the grid is generated :
	#      @gridPick = GridGenerator.new(@difficulty)
	# Then we change the value of time whether we continue or not :
	#      if continue
	#         @time=@game.time+@gridPick.associatedTimer
	#      else
	#         setTime
	#         @score=0
	#      end
	# And finally we create a new game :
	#      @game=Game.new(self)
	# -----
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
