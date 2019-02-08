require 'gtk3'
require File.dirname(__FILE__) + "/FenetrePrinc"
require File.dirname(__FILE__) + "/ModeDeJeu"
require File.dirname(__FILE__) + "/Parametre"
require File.dirname(__FILE__) + "/Gagnant"

  fenetre = Gtk::Window.new
  # Titre de la fenêtre
  fenetre.set_title("Des arbres et des tentes")
  screen=Gdk::Screen.default
  fenetre = Gtk::Window.new.set_default_size(screen.width,screen.height)
  ep=FenetrePrinc.new(self)
  ep.applyOn(fenetre)
#  em=Gagnant.new(self,nil)
#  em.applyOn(fenetre)

  fenetre.signal_connect('delete_event') {
  	Gtk.main_quit
  	false
  }

  fenetre.show_all
  Gtk.main
