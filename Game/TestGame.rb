# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: TestGame.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Feb-2019



def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

require "gtk3"
require_all("Core")
require_all("Ui")
require_all("Helps")

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
		(loadScreen=LoadingScreen.new(@win)).applyOn(@win)
		loadScreen.run
		Thread.new {
			# Generation de la grille
			@gridPick = GridGenerator.new(@gameMode,@difficulty)
			@time=@gridPick.associatedTimer
			# Save loading here ?

			# Generation de la partie
			p continue
			if continue
				@time+=@game.time
			else
				@score=0
			end


			@game=Game.new(self)

			# Generation des textures
			cellAssets=CellAssets.new(gridPick.nRows, gridPick.nCols)
		  # Generation des ecrans de jeu
			victoryScreen=VictoryScreen.new(@win,self)
			gameScreen=GameScreen.new(@win,@game,cellAssets,victoryScreen)
			ProcessStatus.send("Affichage de l'écran de jeu")
			gameScreen.applyOn(@win)
			ProcessStatus.send("Lancement de la partie")
			@game.run
		}
		self
	end

end


# ----------------------------------
# => Main
# ----------------------------------
ProcessStatus.new
# ----------------------------------
# => Generation de la fenetre de jeu
# ----------------------------------
win = Gtk::Window.new.fullscreen
win.title = "Tent & Trees"
win.signal_connect('delete_event') {
	Gtk.main_quit
	false
}
win.icon=GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../Assets/Icons/tent.jpeg")
win.show_all

session=Session.new(win, :timeAttack, :easy)

Gtk.main
