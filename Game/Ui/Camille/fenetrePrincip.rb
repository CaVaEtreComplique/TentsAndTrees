require 'gtk3'
class FenetrePrinc
  def initialize
    fenetre = Gtk::Window.new
    # Titre de la fenêtre
    fenetre.set_title("Des arbres et des tentes")
    # Taille de la fenêtre
    fenetre.set_default_size(500,500)

    #Menu principal
    #menuV=box verticale
    centrer= Gtk::Table.new(1,3,false)
    fenetre.add(centrer)

    menuV=Gtk::Box.new(:vertical,100)
    centrer.attach(menuV,1,2,0,1)

    #Premiere case : titre
    titre= "<span font_desc=\"menu\">Des arbres et des tentes </span>\n"
    monLabel=Gtk::Label.new()
    monLabel.set_markup(titre)
    menuV.add(monLabel)

    #Bontons de menu
    jouer=Gtk::Button.new :label =>'jouer'
    menuV.add(jouer)
    parametre=Gtk::Button.new :label =>'parametres'
    menuV.add(parametre)
    regle=Gtk::Button.new :label =>'regle'
    menuV.add(regle)
    meilleurScore=Gtk::Button.new :label =>'meilleur Score'
    menuV.add(meilleurScore)
    fenetre.show_all
    Gtk.main
  end
  def onDestroy
       puts "Fin de l'application"
       Gtk.main_quit
  end
end

FenetrePrinc.new
