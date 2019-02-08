require 'gtk3'
class ModeDeJeu
  def initialize
    fenetre = Gtk::Window.new
    # Titre de la fenêtre
    fenetre.set_title("Des arbres et des tentes")
    # Taille de la fenêtre
    fenetre.set_default_size(500,500)
    #Menu principal
    #menuV=box verticale
    menuV=Gtk::Box.new(:vertical, 100)
    fenetre.add(menuV)
    #Premiere case : titre
    titre= "<span font_desc=\"menu\">Mode de Jeu </span>\n"
    monLabel=Gtk::Label.new()
    monLabel.set_markup(titre)
    menuV.add(monLabel)

    #Bontons de menu
    aventure=Gtk::Button.new :label =>'Aventure'
    menuV.add(aventure)
    timeA=Gtk::Button.new :label =>'partie rapide'
    menuV.add(timeA)
    clm=Gtk::Button.new :label =>'Contre la montre'
    menuV.add(clm)
    fenetre.show_all
    Gtk.main
  end
  def onDestroy
	   puts "Fin de l'application"
	   Gtk.main_quit
  end
end

ModeDeJeu.new
