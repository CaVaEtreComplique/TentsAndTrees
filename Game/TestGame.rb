# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: TestGame.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019



def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end
require "gtk3"
require_all("Core")
require_all("Ui")


ProcessStatus.new
# ----------------------------------
# => Generation de la fenetre de jeu
# ----------------------------------
screen=Gdk::Screen.default
win = Gtk::Window.new.fullscreen
win.title = "Tent & Trees"
win.signal_connect('delete_event') {
	Gtk.main_quit
	false
}

win.icon=GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../Assets/Icons/tent.jpeg")
win.resizable=true
win.show_all

Thread.new {
	(loadScreen=LoadingScreen.new(win)).applyOn(win)
	loadScreen.run
	# Generation de la grille
	generatedGrid=GridGenerator.new("easy")
	# Generation de la partie
	# save=Save.new
	game=Game.new(generatedGrid,nil,nil)
	# Generation des textures
	cellAssets=CellAssets.new(generatedGrid.nRows, generatedGrid.nCols)
	# charAssets=CharAssets.new( (screen.width*0.3)/50 )
  # Generation de ecran de jeu
	gameScreen=GameScreen.new(win,game,cellAssets)
	ProcessStatus.send("Affichage de l'écran de jeu")
	gameScreen.applyOn(win)
	game.run
}

# ----------------------------------
# => Main
# ----------------------------------
Gtk.main
