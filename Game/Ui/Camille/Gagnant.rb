require 'gtk3'
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

class Gagnant < Screen
  def initialize(parent,game=nil)
    super(parent)
      @gtkObject=Gtk::Box.new(:vertical, 100)

      titre= "<span font_desc=\"menu\">VICTOIRE</span>\n"
      monLabel=Gtk::Label.new()
      monLabel.set_markup(titre)
      @gtkObject.add(monLabel)

      tps= "<span font_desc=\"menu\">Temps : </span>\n"
      monLabel=Gtk::Label.new()
      monLabel.set_markup(tps)
      @gtkObject.add(monLabel)

      menuV=Gtk::Box.new(:vertical,100)
      @gtkObject.add(menuV)

      #Bontons de menu

      if(game=="aventure")
        rj=Button.new(:horizontal,"Niveau Suivant")
        menuV.add(rj.gtkObject)
        rj.onClick{
            #Partie suivante
        }
      end
      quitter=Button.new(:horizontal,"Quitter")
      menuV.add(quitter.gtkObject)
      quitter.onClick{
        FenetrePrinc.new(@parent).applyOn(@gtkObject)
      }

    end
end
