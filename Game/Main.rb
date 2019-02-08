#!/usr/bin/env ruby

require "gtk3"
require File.dirname(__FILE__) + "/Core/GridGenerator"
require File.dirname(__FILE__) + "/Ui/AssetsLoaderClass/CellAssets"
require File.dirname(__FILE__) + "/Core/GameMode"
require File.dirname(__FILE__) + "/Core/Game"
require File.dirname(__FILE__) + "/Ui/Screens/LoadingScreen"
require File.dirname(__FILE__) + "/Ui/Screens/GameScreen"

# ----------------------------------
# => Generation de la fenetre de jeu
# ----------------------------------
screen=Gdk::Screen.default
win = Gtk::Window.new.set_default_size(screen.width,screen.height)
win.title = "Tent & Trees"
win.signal_connect('delete_event') {
	Gtk.main_quit
	false
}

win.icon=GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../Assets/Icons/tent.jpeg")
win.resizable=true
win.show_all
(loadScreen=LoadingScreen.new(self)).applyOn(win)
loadScreen.run

Thread.new {
	# Generation de la grille
	loadScreen.text("Generation de la grille")
	generatedGrid=GridGenerator.new("random")
	# Generation de la partie
	loadScreen.text("Génération de la sauvegarde")
	# save=Save.new
	loadScreen.text("Generation de la partie")
	game=Game.new(generatedGrid,nil,nil)
	# Generation des textures
	loadScreen.text("Generation des textures")
	assets=CellAssets.new(generatedGrid.nRows, generatedGrid.nCols)
  # Generation de ecran de jeu
	loadScreen.text("Generation de l'écran de jeu")
	gameScreen=GameScreen.new(self,game,assets)
	gameScreen.applyOn(win)
	loadScreen.kill
}

# ----------------------------------
# => Main
# ----------------------------------
Gtk.main
